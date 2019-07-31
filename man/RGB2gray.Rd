\name{RGB2gray}
\alias{RGB2gray}
\title{Convert RGB image or colormap to grayscale image}
\description{
  This function converts color image to gray image.
}
\usage{RGB2gray(img, method = "average", weights = NULL)}
\arguments{
  \item{img}{target image, specified as an \code{nrow}-by-\code{ncol}-by-3 numeric array.}
  \item{method}{character, procedure for converting color to grayscale. Available methods
  are \code{"average"}, \code{"BT240"}, \code{"brighter"} (or maximum decomposition),
  \code{"darker"} (or minimu decomposition), \code{"ITU"} (or BT.709), \code{"lightness"}
  (or desaturation), \code{"LUMA"} (or BT.601), \code{"RMY"} and \code{"weighted"} (user provided).}
  \item{weights}{weights for red (R), green (G), and blue (B) channels. Required if
  \code{method = "weighted"}.}
}
\value{
  Grayscale image, returned as an \code{nrow}-by-\code{ncol} numeric matrix with values
  in the range \eqn{[0,1]}.

  \code{RGB2gray} converts RGB values to grayscale values by forming a weighted sum
  of the R, G, and B channels.
}
\examples{
  data(twelve)
  par(pty = "s", mfrow = c(1,3))
  plot(as.raster(twelve)) # in RGB
  title(main = "original", font.main = 1)

  x <- RGB2gray(twelve, method = "RMY")
  plot(as.raster(x)) # in grayscale
  title(main = "RMY", font.main = 1)

  x <- RGB2gray(twelve, method = "ITU")
  plot(as.raster(x)) # OMG! 12 is gone...
  title(main = "ITU", font.main = 1)
}
\keyword{misc}
