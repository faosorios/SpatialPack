\name{SSIM}
\alias{SSIM}
\title{Structural similarity index}
\description{
  This function computes the structural similarity index (SSIM) proposed by Wang et al. (2004).
}
\usage{SSIM(x, y, alpha = 1, beta = 1, gamma = 1, eps = c(0.01, 0.03), L = 255)}
\arguments{
  \item{x}{reference image matrix (grayscale)}
  \item{y}{distorted image matrix (grayscale)}
  \item{alpha}{weight associated with luminance, default value is \code{alpha = 1}.}
  \item{beta}{weight associated with contrast, default value is \code{beta = 1}.}
  \item{gamma}{weight associated with structure, default value is \code{gamma = 1}.}
  \item{eps}{rescaling constants, by default \code{eps = c(0.01, 0.03)}}
  \item{L}{dynamic range of the images, by default \code{L = 255}.}
}
\value{
  A list containing the following components:
  \item{SSIM}{structural similarity index between images \code{x} and \code{y}.}
  \item{coefficients}{weights (\code{alpha}, \code{beta}, \code{gamma}) associated
  with each component of \code{SSIM}}
  \item{comps}{components of \code{SSIM}, that is \code{luminance}, \code{contrast} and \code{structure}}
  \item{stats}{sample statistics (means, variances and covariance) for each image.}
  \item{speed}{Running time taken by the procedure.}
}
\references{
  Wang, Z., Bovik, A.C. (2002).
  A universal image quality index.
  \emph{IEEE Signal Processing Letters} \bold{9}, 81-84.

  Wang, Z., Bovik, A.C., Sheikh, H.R., Simoncelli, E.P. (2004).
  Image quality assessment: From error visibility to structural similarity.
  \emph{IEEE Transactions on Image Processing} \bold{13}, 600-612.
}
\examples{
data(texmos2)

y <- imnoise(texmos2, type = "gaussian")
plot(as.raster(y))
o <- SSIM(texmos2, y)
o

y <- imnoise(texmos2, type = "speckle")
plot(as.raster(y))
o <- SSIM(texmos2, y)
o
}
\keyword{misc}
