\name{CQ}
\alias{CQ}
\title{Codispersion based similarity index}
\description{
  This function computes a similarity index (CQ) based on the codispersion coefficient.
}
\usage{CQ(x, y, h = c(0,1), eps = c(0.01, 0.03), L = 255)}
\arguments{
  \item{x}{reference image matrix (grayscale)}
  \item{y}{distorted image matrix (grayscale)}
  \item{h}{2-dimensional vector of the spatial lag. Default value is \code{h = c(0,1)}.}
  \item{eps}{rescaling constants, by default \code{eps = c(0.01, 0.03)}}
  \item{L}{dynamic range of the images, by default \code{L = 255}.}
}
\value{
  A list containing the following components:
  \item{CQ}{codispersion based similarity index between images \code{x} and \code{y}.}
  \item{direction}{vector of spatial lag.}
  \item{comps}{components of \code{CQ}, that is \code{luminance}, \code{contrast} and \code{codispersion}}
  \item{stats}{sample statistics (means, variances and covariance) for each image.}
  \item{speed}{Running time taken by the procedure.}
}
\references{
  Ojeda, S.M., Lamberti, P.W., Vallejos, R. (2012).
  Measure of similarity between images based on the codispersion coefficient.
  \emph{Journal of Electronic Imaging} \bold{21}, 023019.

  Vallejos, R., Mancilla, D., Acosta, J. (2016).
  Image similarity assessment based on coefficients of spatial association.
  \emph{Journal of Mathematical Imaging and Vision} \bold{56}, 77-98.
}
\examples{
data(texmos2)

y <- imnoise(texmos2, type = "gaussian")
plot(as.raster(y))
o <- CQ(texmos2, y, h = c(0,1))
o

y <- imnoise(texmos2, type = "speckle")
plot(as.raster(y))
o <- CQ(texmos2, y, h = c(0,1))
o
}
\keyword{misc}
