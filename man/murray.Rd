\name{murray}
\docType{data}
\alias{murray}

\title{The Murray smelter site dataset}
\description{
  The dataset consists of soil samples collected in and around the vacant, industrially
  contaminated, Murray smelter site (Utah, USA). This area was polluted by airborne emissions
  and the disposal of waste slag from the smelting process. A total of 253 locations were
  included in the study, and soil samples were taken from each location. Each georeferenced
  sample point is a pool composite of four closely adjacent soil samples in which the
  concentration of the heavy metals arsenic (As) and lead (Pb) was determined.
}
\usage{data(murray)}
\format{
  A data frame with 253 observations on the following 5 variables.
  \describe{
    \item{As}{ arsenic concentrations measurements.}
    \item{Pb}{ lead concentrations measurements.}
    \item{xpos}{ \code{x}-coordinates.}
    \item{ypos}{ \code{y}-coordinates.}
    \item{quad}{ a factor where numbers indicate different sub-regions within the area.}
  }
}
\source{
  Griffith, D., Paelinck, J.H.P. (2011).
  \emph{Non-Standard Spatial Statistics}.
  Springer, New York.
}
\keyword{datasets}
