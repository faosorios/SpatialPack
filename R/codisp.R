## $ID: codisp.R, last updated 2024-09-28, F.Osorio

codisp <-
function(x, y, coords, nclass = 13)
{
  ## validating arguments
  if (length(x) != length(y))
    stop("'x' and 'y' must have the same length")
  if (!is.numeric(x)) stop("'x' must be a numeric vector")
  if (!is.numeric(y)) stop("'y' must be a numeric vector")
  ## in order to remove all NAs
  OK <- complete.cases(x, y)
  x <- x[OK]
  y <- y[OK]
  n <- length(x)
  dnames <- colnames(cbind(x, y))

  ## extract coordinates, is assumed that the variables are in the appropiate order
  coords <- as.matrix(coords)
  p <- ncol(coords)
  if (p < 2) stop("'coords' must be a matrix with two columns")
  if (p > 2) warning("only the first two columns of 'coords' are considered")
  p <- 2 # only implemented for this case!
  xpos <- coords[,1]
  ypos <- coords[,2]
  cnames <- colnames(coords)[1:p]

  ## some definitions
  ndist <- n * (n - 1) / 2
  if (is.null(nclass))
    nclass = as.integer(1.5 + 3.3 * log10(ndist))
  dims <- c(n, p, nclass)

  ## call routine
  now <- proc.time()
  z <- .C("codisp_coef",
          x = as.double(x),
          y = as.double(y),
          xpos = as.double(xpos),
          ypos = as.double(ypos),
          dims = as.integer(dims),
          upper.bounds = double(nclass),
          card = double(nclass),
          coef = double(nclass))
  speed <- proc.time() - now

  ## creating output object
  o <- list(coef = z$coef, upper.bounds = z$upper.bounds, card = z$card)
  o$dims <- dims
  o$data.names <- dnames
  o$speed <- speed
  class(o) <- "codisp"
  return(o)
}

codisp.ks <-
function(x, y, coords, lags, kernel = "epanech", bandwidths)
{
  # validating arguments
  if (length(x) != length(y))
    stop("'x' and 'y' must have the same length")
  if (!is.numeric(x)) stop("'x' must be a numeric vector")
  if (!is.numeric(y)) stop("'y' must be a numeric vector")

  # remove all NAs
  OK <- complete.cases(x, y)
  x <- x[OK]
  y <- y[OK]
  n <- length(x)

  # extract coordinates, is assumed that the variables are in the appropiate order
  coords <- as.matrix(coords)
  p <- ncol(coords)
  if (p < 2) stop("'coords' must be a matrix with two columns")
  if (p > 2) warning("only the first two columns of 'coords' are considered")
  p <- 2 # only implemented for this case!
  xpos <- coords[,1]
  ypos <- coords[,2]
  cnames <- colnames(coords)[1:p]

  # eval dimensions of 'lags' and 'bandwiths'
  if (length(lags) != 2)
    stop("'lags' must be a 2D-vector")
  if (length(bandwidths) != 3)
    stop("'bandwidths' must be a 3D-vector")

  # kernel to be used in computations
  task <- switch(kernel,
                 "uniform"    = 0,
                 "epanech"    = 1,
                 "gaussian"   = 3,
                 "biweight"   = 4,
                 "triangular" = 5)

  ## call routine
  now <- proc.time()
  z <- .C("codisp_ks",
          x = as.double(x),
          y = as.double(y),
          xpos = as.double(xpos),
          ypos = as.double(ypos),
          nobs = as.integer(n),
          lags = as.double(lags),
          bandwidths = as.double(bandwidths),
          task = as.integer(task),
          coef = double(4))$coef
  names(z) <- c("variog.x","variog.y","cross","codisp")
  z
}

print.codisp <- function(x, digits = 4, ...)
{
  z <- cbind(x$upper.bounds, x$card, x$coef)
  nclass <- x$dims[3]
  dimnames(z) <- list(1:nclass, c("Upper Bounds", "Cardinality", "Coefficient"))
  print(z, digits = digits)
  invisible(x)
}

plot.codisp <- function(x, ...)
{
  nclass <- x$dims[3]
  incr <- x$upper.bounds[1]
  from <- incr / 2
  midpoints <- seq(from = from, by = incr, length = nclass)
  y <- x$coef
  dnames <- paste(x$data.names, collapse = " and ", sep = "")
  plot(midpoints, y, type = "b", xlab = "distances", ylab = "codispersion coefficient")
  title(main = paste("Codispersion between ", dnames, sep = ""))
  invisible(x)
}
