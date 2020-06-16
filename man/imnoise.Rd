\name{imnoise}
\alias{imnoise}
\title{Add noise to image}
\description{
  This function adds noise to an input image.
}
\usage{imnoise(img, type = "gaussian", mean = 0, sd = 0.01, epsilon = 0.05, var = 0.04,
       looks = 1)}
\arguments{
  \item{img}{input grayscale image matrix.}
  \item{type}{character string, specifying the type of contamination: \code{"gaussian"}
  (Gaussian white/additive noise), \code{"saltnpepper"} (salt and pepper noise or on-off noise),
  \code{"speckle"} (uniform multiplicative noise) and \code{"gamma"} (gamma multiplicative noise).}
  \item{mean}{mean for the Gaussian noise, default value is \code{mean = 0}.}
  \item{sd}{standard deviation for the Gaussian noise, default value is \code{sd = 0.01}.}
  \item{epsilon}{contamination percentage for the salt and pepper noise with default noise
  density \code{0.05}. This affects approximately \code{epsilon}\% of pixels.}
  \item{var}{variance of uniform multiplicative noise using the equation \eqn{noise = img + unif * img},
  with \eqn{unif} is uniformly distributed with mean \eqn{0} and variance \code{var}. Default value
  is \code{var = 0.04}.}
  \item{looks}{parameter of gamma multiplicative noise. The default value is \code{looks = 1}.}
}
\value{
  Noisy image, returned as a numeric matrix. The \code{imnoise} function clips output
  pixel values to the range \eqn{[0,1]} after adding noise.
}
\examples{
  data(texmos2)
  x <- imnoise(texmos2, type = "saltnpepper", epsilon = 0.10)
  plot(as.raster(x))

  y <- imnoise(texmos2, type = "speckle")
  plot(as.raster(y))

  z <- imnoise(texmos2, type = "gamma", looks = 4)
  plot(as.raster(z))
}
\keyword{misc}
