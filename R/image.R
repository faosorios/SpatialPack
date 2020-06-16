## $ID: image.R, last updated 2019/06/22, F.Osorio

RGB2gray <- function(img, method = "average", weights = NULL)
{
  dims <- dim(img)
  if (is.null(dims))
    stop("Image matrix is not correct.")
  if (length(dims) < 3)
    stop("Image matrix is not RGB image.")

  dims  <- dims[1:2] # discarding transparency info
  red   <- img[,,1]
  green <- img[,,2]
  blue  <- img[,,3]

  y <- matrix(0, nrow = dims[1], ncol = dims[2])

  storage.mode(red)   <- "double"
  storage.mode(green) <- "double"
  storage.mode(blue)  <- "double"
  storage.mode(y)     <- "double"

  choice <- switch(method, "average"   = 0,
                           "BT240"     = 1,
                           "brighter"  = 2,
                           "darker"    = 3,
                           "ITU"       = 4,
                           "lightness" = 5,
                           "LUMA"      = 6,
                           "RMY"       = 7,
                           "weighted"  = 8)

  if ((choice == 8) && is.null(weights))
    stop("weights are required.")

  if (length(weights) != 3)
    weights <- rep(1,3)
  weights <- weights / sum(weights)

  y <- .C("RGB2gray",
          y = y, ldy = as.integer(dims[1]),
          red = red, green = green, blue = blue,
          nrow = as.integer(dims[1]),
          ncol = as.integer(dims[2]),
          weights = as.double(weights),
          method = as.integer(choice))$y
  y
}

clipping <- function(img, low = 0, high = 1)
{
  dims <- dim(img)
  storage.mode(img) <- "double"

  if (!is.matrix(img))
    stop("Image must be a matrix.")

  y <- .C("clipping",
          y = img,
          ldy  = as.integer(dims[1]),
          nrow = as.integer(dims[1]),
          ncol = as.integer(dims[2]),
          low  = as.double(low),
          high = as.double(high))$y
  y
}

normalize <- function(img)
{ # equalization of a grayscale image
  dims <- dim(img)
  storage.mode(img) <- "double"

  if (!is.matrix(img))
    stop("Image must be a matrix.")

  y <- .C("normalize",
          y = img,
          ldy  = as.integer(dims[1]),
          nrow = as.integer(dims[1]),
          ncol = as.integer(dims[2]),
          min  = as.double(min(img)),
          max  = as.double(max(img)))$y
  y
}

imnoise <- function(img, type = "gaussian", mean = 0, sd = 0.01, epsilon = 0.05,
  var = 0.04, looks = 1)
{
  y <- img
  dims <- dim(y)
  storage.mode(y) <- "double"

  if (!is.matrix(y))
    stop("Image must be a matrix.")

  ok <- (0 <= min(img)) && (max(img) <= 1)
  if (!ok)
    stop("gray intensity must be in [0,1]")

  switch(type,
         "gaussian" = {
           y <- .C("add_noise",
                   y = y,
                   ldy  = as.integer(dims[1]),
                   nrow = as.integer(dims[1]),
                   ncol = as.integer(dims[2]),
                   mean = as.double(mean),
                   sd = as.double(sd))$y
           y <- clipping(y, low = 0, high = 1)
         },
         "saltnpepper" = {
           y <- .C("saltnpepper",
                    y = y,
                    ldy  = as.integer(dims[1]),
                    nrow = as.integer(dims[1]),
                    ncol = as.integer(dims[2]),
                    epsilon = as.double(epsilon))$y
           y <- clipping(y, low = 0, high = 1)
         },
         "speckle" = {
           y <- .C("unif_speckle",
                    y = y,
                    ldy  = as.integer(dims[1]),
                    nrow = as.integer(dims[1]),
                    ncol = as.integer(dims[2]),
                    var = as.double(var))$y
           y <- clipping(y, low = 0, high = 1)
         },
         "gamma" = {
           y <- .C("gamma_noise",
                    y = y,
                    ldy  = as.integer(dims[1]),
                    nrow = as.integer(dims[1]),
                    ncol = as.integer(dims[2]),
                    looks = as.double(looks))$y
           y <- clipping(y, low = 0, high = 1)
         },
         stop(paste(type, "is not implemented.")))
  y
}

denoise <- function(img, type = "Lee", looks = 1, damping = 1)
{
  y <- img
  dims <- dim(y)
  storage.mode(y) <- "double"

  if (!is.matrix(y))
    stop("Image must be a matrix.")

  ok <- (0 <= min(img)) && (max(img) <= 1)
  if (!ok)
    stop("gray intensity must be in [0,1]")

  task <- switch(type, "median"   = 0,
                       "Lee"      = 1,
                       "enhanced" = 2)

  y <- .Fortran("denoise",
          x = y,
          ldx  = as.integer(dims[1]),
          nrow = as.integer(dims[1]),
          ncol = as.integer(dims[2]),
          y = y,
          ldy = as.integer(dims[1]),
          looks = as.double(looks),
          damping = as.double(damping),
          task = as.integer(task))$y
  y <- clipping(y, low = 0, high = 1)
  y
}
