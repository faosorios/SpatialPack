\name{cor.spatial}
\alias{cor.spatial}
\title{Tjostheim's Coefficient}
\description{
  Computes Tjostheim's coefficient for two spatial sequences observed over the same
  locations on the plane.
}
\usage{
  cor.spatial(x, y, coords)
}
\arguments{
  \item{x}{an \code{n}-dimensional vector of data values.}
  \item{y}{an \code{n}-dimensional vector of data values.}
  \item{coords}{an \code{n-by-2} matrix containing coordinates of the \code{n} data
  locations in each row.}
}
\details{
  The implemented  technique is a nonparametric coefficient that summarizes the
  association between two spatial variables. This coefficient was first introduced
  by Tjostheim (1978) and later generalized by Hubert and Golledge (1992). The
  computation of the coefficient is based on the construction of ranks associated
  to suitable modifications of the coordinates. Tjostheim's coefficient is a variant
  of the correlation coefficient (\code{\link{cor}}) to be used in a spatial statistics
  context.
}
\value{
  Tjostheim's coefficient. The variance is returned as the attribute \code{"variance"}.
}
\references{
  Tjostheim, D., (1978),
  A measure of association for spatial variables.
  \emph{Biometrika} \bold{65}, 109--114.

  Hubert, L., Golledge, R.G., (1982),
  Measuring association between spatially defined variables: Tjostheim's coefficient index and some extensions.
  \emph{Geographical Analysis} \bold{14}, 273--278.
}
\examples{
# Murray Smelter site dataset
data(murray)

# defining the arsenic (As) and lead (Pb) variables from the murray dataset
x <- murray$As
y <- murray$Pb

# extracting the coordinates from Murray dataset
coords <- murray[c("xpos","ypos")]

# computing Tjostheim's coefficient
z <- cor.spatial(x, y, coords)
z
}
\keyword{multivariate}
