\name{modified.Ftest}
\alias{modified.Ftest}
\title{Modified F test}
\description{
  Performs a modified version of the \emph{F} test to assess the multiple correlation
  between one spatial processes and several others.
}
\usage{
  modified.Ftest(x, y, coords, nclass = 13)
}
\arguments{
  \item{x}{an \eqn{n}-by-\eqn{q} matrix of data values.}
  \item{y}{an \eqn{n}-dimensional vector of data values.}
  \item{coords}{an \eqn{n}-by-2 matrix containing coordinates of the \eqn{n} data
  locations in each row.}
  \item{nclass}{a single number giving the number of cells for Moran's index.
  The default is 13. If this argument is \code{NULL} Sturges' formula us used.}
}
\details{
  The methodology implemented is a modified \emph{F} test for assessing the multiple
  correlation between one spatial process and several others. The test is based on
  corrections of the multiple correlation coefficient between the two spatially
  correlated sequences and required the estimation of an effective sample size.
  This factor takes into account the spatial association of both processes.
}
\value{
  A list with class \code{"mod.Ftest"} containing the following components:
  \item{corr}{the sample correlation coefficient.}
  \item{ESS}{the estimated effective sample size.}
  \item{Fstat}{the value of the (unscaled) \emph{F}-statistic.}
  \item{df1,df2}{degrees of freedom for the \emph{F}-statistic.}
  \item{p.value}{the \emph{p}-value for the test.}
  \item{upper.bounds}{upper bounds of the intervals constructed to compute Moran's \emph{I}.}
  \item{card}{number of elements in each interval generated to compute Moran's \emph{I}.}
  \item{imoran}{a matrix containing Moran's index for each interval associated with
  the response and predicted variables.}

  The generic functions \code{print} and \code{summary} are used to obtain
  and print additional details about the modified \emph{F} test.
}
\references{
  Dutilleul, P., Pelletier, B., Alpargu, G. (2008).
  Modified \emph{F} tests for assessing the multiple correlation between one spatial
  process and several others.
  \emph{Journal of Statistical Planning and Inference} \bold{138}, 1402-1415.
}
\examples{
# The Pinus Radiata data set
data(radiata)

# defining the response and predictor variables from the radiata data set
y <- radiata$height
x <- radiata[c("basal","altitude","slope")]

# extracting the coordinates from the radiata data set
coords <- radiata[c("xpos","ypos")]

# computing the modified F-test of spatial association
z <- modified.Ftest(x, y, coords)
z

# display the upper bounds, cardinality and the computed Moran's index
summary(z)
}
\keyword{htest}
