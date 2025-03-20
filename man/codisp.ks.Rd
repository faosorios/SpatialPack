\name{codisp.ks}
\alias{codisp.ks}
\title{A Nadaraya-Watson Codispersion Coefficient}
\description{
  Computes a nonparametric version of the codispersion coefficient between 
  two spatial variables using a Nadaraya-Watson estimator.}
\usage{
  codisp.ks(x, y, coords, lags, kernel = "epanech", bandwidths)
}
\arguments{
  \item{x}{an \eqn{n}-dimensional vector of data values.}
  \item{y}{an \eqn{n}-dimensional vector of data values.}
  \item{coords}{an \eqn{n}-by-2 matrix containing coordinates of the \eqn{n} data
    locations in each row.}
  \item{lags}{ a 2D vector of spatial lags.}
  \item{kernel}{ character string which determines the smoothing kernel. \code{kernel} can be:
    \code{"uniform"} - a rectangular box. \code{"epanech"} - the Epanechnikov kernel or centred 
    Beta(2,2) density (the default). \code{"gaussian"} - the Gaussian density function. \code{"biweight"} 
    - quartic or biweight kernel. \code{"triangular"} - the triangular distribution.}
  \item{bandwidths}{ a 3D vector with the kernel bandwidth smoothing parameters.}
}
\details{
  The procedure computes the codispersion coefficient for two spatial variables which is based 
  on a Nadaraya-Watson version of the codispersion coefficient through a suitable kernel.
}
\value{
  A vector with the semivariogram for each variable, the crossed semivariogram and 
  the codispersion coefficient.
}
\references{
  Cuevas, F., Porcu, E., Vallejos, R. (2013). 
  Study of spatial relationships between two sets of variables: A nonparametric approach.
  \emph{Journal of Nonparametric Statistics} \bold{25}, 695-714.

  Vallejos, R., Osorio, F., Bevilacqua, M. (2020).
  \emph{Spatial Relationships Between Two Georeferenced Variables: With Applications in R}. 
  Springer, Cham.
}
\examples{
# Pinus Radiata dataset
data(radiata)

# defining basal-area and height variables from the Pinus Radiata dataset
x <- radiata$basal
y <- radiata$height

# extracting the coordinates from Pinus Radiata dataset
coords <- radiata[,1:2]

# computing the codispersion coefficient
bwds <- c(174, 247, 187)
cf <- codisp.ks(x, y, coords, lags = c(200,200), kernel = "epanech", bandwidths = bwds)
cf
}
\keyword{multivariate}
