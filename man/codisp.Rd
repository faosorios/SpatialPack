\name{codisp}
\alias{codisp}
\title{Codispersion Coefficient}
\description{
  Computes the codispersion coefficient between two spatial variables for a given
  number of classes for the lag distance.}
\usage{
  codisp(x, y, coords, nclass = 13)
}
\arguments{
  \item{x}{an \eqn{n}-dimensional vector of data values.}
  \item{y}{an \eqn{n}-dimensional vector of data values.}
  \item{coords}{an \eqn{n}-by-2 matrix containing coordinates of the \eqn{n} data
  locations in each row.}
  \item{nclass}{a single number giving the number of cells for the codispersion
  coefficient. The default is 13. If this argument is \code{NULL} Sturges' formula is used.}
}
\details{
  The procedure computes the codispersion coefficient for two spatial sequences
  defined on general (non-rectangular) grids. First, a given number of bins are
  constructed for the lag distance. Then the codispersion is computed for each bin.
}
\value{
  A list with class \code{"codisp"} containing the following components:
  \item{coef}{a vector of size \code{nclass} containing the values of the codispersion
  coefficient.}
  \item{upper.bounds}{upper bounds of the intervals constructed to compute the
  codispersion coefficient.}
  \item{card}{number of elements in each interval generated to compute the
  codispersion coefficient.}

  The function \code{plot} can be used to obtain a graph of the codispersion coefficient
  versus the lag distance.
}
\references{
  Cuevas, F., Porcu, E., Vallejos, R. (2013). 
  Study of spatial relationships between two sets of variables: A nonparametric approach.
  \emph{Journal of Nonparametric Statistics} \bold{25}, 695-714.

  Matheron, G. (1965),
  \emph{Les Variables Regionalisees et leur Estimation}.
  Masson, Paris.

  Rukhin, A., Vallejos, R. (2008),
  Codispersion coefficient for spatial and temporal series.
  \emph{Statistics and Probability Letters} \bold{78}, 1290-1300.

  Vallejos, R. (2008).
  Assessing the association between two spatial or temporal sequences.
  \emph{Journal of Applied Statistics} \bold{35}, 1323-1343.
}
\examples{
# Murray Smelter site dataset
data(murray)

# defining the arsenic (As) and lead (Pb) variables from the murray dataset
x <- murray$As
y <- murray$Pb

# extracting the coordinates from Murray dataset
coords <- murray[c("xpos","ypos")]

# computing the codispersion coefficient
z <- codisp(x, y, coords)
z

## plotting the codispersion coefficient vs. the lag distance
plot(z)

# Comovement between two time series representing the monthly deaths
# from bronchitis, emphysema and asthma in the UK for 1974-1979
x <- mdeaths
y <- fdeaths
coords <- cbind(1:72, rep(1,72))
z <- codisp(x, y, coords)

# plotting codispersion and cross-correlation functions
par(mfrow = c(1,2))
ccf(x, y, ylab = "cross-correlation", max.lag = 20)
plot(z)
}
\keyword{multivariate}
