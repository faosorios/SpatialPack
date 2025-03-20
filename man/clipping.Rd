\name{clipping}
\alias{clipping}
\title{Clipping image}
\description{
  This function returns the image which restricts pixel value from the specified range.
}
\usage{clipping(img, low = 0, high = 1)}
\arguments{
  \item{img}{input grayscale image matrix.}
  \item{low}{lowest value.}
  \item{high}{highest value.}
}
\value{
  grayscale image matrix with the same size as \code{img}.
}
\examples{
data(texmos2)
plot(as.raster(texmos2))

# the appearance of next one doesn't change because of normalization
x <- normalize(2 * texmos2)
plot(as.raster(x))
title(main = "Doubled pixel value with normalization", font.main = 1)

# the next one is saturated as expected
x <- clipping(2 * texmos2)
plot(as.raster(x))
title(main = "Doubled pixel value with clipping", font.main = 1)
}
\keyword{misc}
