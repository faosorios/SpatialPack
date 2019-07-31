\name{normalize}
\alias{normalize}
\title{Normalization for a matrix}
\description{
  This function normalizes an image matrix so that the minimum value is 0 and the
  maximum value is 1.
}
\usage{normalize(img)}
\arguments{
  \item{img}{target image}
}
\value{
  Image matrix in which minimum value is 0 and maximum value is 1.
}
\examples{
  data(twelve)
  x <- RGB2gray(twelve, method = "RMY")
  x <- normalize(x)
  plot(as.raster(x))
}
\keyword{misc}
