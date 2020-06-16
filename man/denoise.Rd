\name{denoise}
\alias{denoise}
\title{Remove noise from an image}
\description{
  This function removes noise from an input image.
}
\usage{denoise(img, type = "Lee", looks = 1, damping = 1)}
\arguments{
  \item{img}{input grayscale image matrix.}
  \item{type}{character string, specifying the type of filter: \code{"median"},
  \code{"Lee"} and \code{"enhanced"} (enhanced Lee filter).}
  \item{looks}{parameter of gamma multiplicative noise. The default value is \code{looks = 1}.}
  \item{damping}{specifies the extent of exponential damping effect on filtering,
  by default \code{damping = 1}.}
}
\value{
  Filtered image, returned as a numeric matrix. It allows a better image interpretation.
  The \code{denoise} function clips output pixel values to the range \eqn{[0,1]} after
  removing the noise.
}
\details{
  The median filter, in which each pixel is replaced by the median of nearby values is
  suitable to remove additive noise from an image.

  The Lee filter reduces the speckle noise by applying a spatial filter to each pixel
  in an image, which filters the data based on local statistics calculated within a
  square window. The value of the center pixel is replaced by a value calculated
  using the neighboring pixels. Use the Lee filter to smooth speckled data that has
  a multiplicative component.

  The Enhanced Lee filter is a refined version of the Lee filter, reducing the speckle
  noise effectively by preserving image sharpness and detail. Use the Enhanced Lee filter
  to reduce speckle while preserving texture information.

  The size of the pixel window used to each filter is 3-by-3.
}
\references{
  Lee, J.S. (1980).
  Digital image enhancement and noise filtering by use of local statistics.
  \emph{IEEE Transactions on Pattern Analysis and Machine Intelligence} PAMI-2, 165-168.
}
\examples{
  data(texmos2)
  x <- imnoise(texmos2, type = "saltnpepper", epsilon = 0.10)
  plot(as.raster(x))

  y <- denoise(x, type = "median")
  plot(as.raster(y))

  x <- imnoise(texmos2, type = "speckle")
  plot(as.raster(x))

  y <- denoise(x, type = "Lee")
  plot(as.raster(y))
}
\keyword{misc}
