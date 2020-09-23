## $ID: similarity.R, last updated 2020/06/15, F.Osorio

SSIM <- function(x, y, alpha = 1, beta = 1, gamma = 1, eps = c(0.01, 0.03), L = 255)
{ ## structural similarity index for images (SSIM)
  # rescaling constants
  eps <- c(eps, 0)
  eps[1] <- (L * eps[1])^2
  eps[2] <- (L * eps[2])^2
  eps[3] <- .5 * eps[2]

  # coefficients of SSIM
  pars <- c(alpha, beta, gamma)

  if (all(dim(x)) != all(dim(y)))
    stop("x and y images must have same dimensions.")

  xrow <- nrow(x)
  xcol <- ncol(x)
  now  <- proc.time()

  # calling C function
  z <- .C("SSIM_coef",
          x = as.double(x),
          y = as.double(y),
          nrow = as.integer(xrow),
          ncol = as.integer(xcol),
          pars = as.double(pars),
          eps = as.double(eps),
          stats = double(5),
          comps = double(4))
  stats <- z$stats[c(1,3,2,4,5)]
  comps <- z$comps[2:4]
  ssim  <- z$comps[1]

  # output object
  speed <- proc.time() - now
  names(pars)  <- c("alpha", "beta", "gamma")
  names(stats) <- c("x.bar", "x.var", "y.bar", "y.var", "cov")
  names(comps) <- c("luminance", "contrast", "structure")
  o <- list(SSIM = ssim, coefficients = pars, comps = comps, stats = stats,
            speed = speed)
  o
}

CQ <- function(x, y, h = c(0,1), eps = c(0.01, 0.03), L = 255)
{ ## structural similarity index for images (CQ)
  # rescaling constants
  eps[1] <- (L * eps[1])^2
  eps[2] <- (L * eps[2])^2

  if (all(dim(x)) != all(dim(y)))
    stop("x and y images must have same dimensions.")

  if (!is.vector(h))
    stop("h must be a vector of directions.")
  if (length(h) > 2)
    warning("only the first two elements of h are used.")
  ok <- all(h >= 0)
  if (!ok)
    stop("only implemented for h >= 0.")

  xrow <- nrow(x)
  xcol <- ncol(x)
  now  <- proc.time()

  # calling C function
  z <- .C("CQ_coef",
          x = as.double(x),
          y = as.double(y),
          nrow = as.integer(xrow),
          ncol = as.integer(xcol),
          h = as.integer(h),
          eps = as.double(eps),
          stats = double(5),
          comps = double(4))
  stats <- z$stats[c(1,3,2,4,5)]
  comps <- z$comps[2:4]
  cq    <- z$comps[1]

  # output object
  speed <- proc.time() - now
  names(stats) <- c("x.bar", "x.var", "y.bar", "y.var", "cov")
  names(comps) <- c("luminance", "contrast", "structure")
  o <- list(CQ = cq, direction = h, comps = comps, stats = stats, speed = speed)
  o
}
