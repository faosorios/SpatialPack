\name{modified.ttest}
\alias{modified.ttest}
\title{Modified t test}
\description{
  Performs a modified version of the \emph{t} test to assess the correlation between
  two spatial processes.
}
\usage{
  modified.ttest(x, y, coords, nclass = 13)
}
\arguments{
  \item{x}{an \eqn{n}-dimensional vector of data values.}
  \item{y}{an \eqn{n}-dimensional vector of data values.}
  \item{coords}{an \eqn{n}-by-2 matrix containing coordinates of the \eqn{n} data
  locations in each row.}
  \item{nclass}{a single number giving the number of cells for Moran's index.
  The default is 13. If this argument is \code{NULL} Sturges' formula us used.}
}
\details{
  The methodology implemented is a modified \emph{t} test of spatial association
  based on the work of Clifford and Richardson (1989). The test is based on
  corrections of the sample correlation coefficient between the two spatially
  correlated sequences and required the estimation of an effective sample size.
  This factor takes into account the spatial association of both processes.
}
\value{
  A list with class \code{"mod.ttest"} containing the following components:
  \item{corr}{the sample correlation coefficient.}
  \item{ESS}{the estimated effective sample size.}
  \item{Fstat}{the value of the (unscaled) \emph{F}-statistic.}
  \item{dof}{the estimated degrees of freedom for the \emph{F}-statistic.}
  \item{p.value}{the \emph{p}-value for the test.}
  \item{upper.bounds}{upper bounds of the intervals constructed to compute Moran's \emph{I}.}
  \item{card}{number of elements in each interval generated to compute Moran's \emph{I}.}
  \item{imoran}{a matrix containing Moran's index for each interval associated with
  both variables.}

  The generic functions \code{print} and \code{summary} are used to obtain
  and print additional details about the modified \emph{t} test.
}
\references{
  Clifford, P., Richardson, S., Hemon, D. (1989).
  Assessing the significance of the correlation between two spatial processes.
  \emph{Biometrics} \bold{45}, 123-134.

  Dutilleul, P. (1993).
  Modifying the \emph{t} test for assessing the correlation between two spatial processes.
  \emph{Biometrics} \bold{49}, 305-314.
}
\examples{
# Murray Smelter site dataset
data(murray)

# defining the arsenic (As) and lead (Pb) variables from the murray dataset
x <- murray$As
y <- murray$Pb

# extracting the coordinates from Murray dataset
coords <- murray[c("xpos","ypos")]

# computing the modified t-test of spatial association
z <- modified.ttest(x, y, coords)
z

# display the upper bounds, cardinality and the computed Moran's index
summary(z)
}
\keyword{htest}
