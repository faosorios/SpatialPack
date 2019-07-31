modified.Ftest <-
function(x, y, coords, nclass = 13)
{
  ## validating arguments
  dx <- dim(x)
  x <- as.matrix(x)
  if (length(y) != dx[1])
    stop("number of rows of 'x' and length of 'y' must be the same")
  if (!is.numeric(x)) stop("'x' must be a numeric matrix")
  if (!is.numeric(y)) stop("'y' must be a numeric vector")
  ## in order to remove all NAs
  OK <- complete.cases(x, y)
  x <- x[OK,]
  y <- y[OK]
  n <- length(x)
  ## fit a linear regression
  fm <- lm(y ~ -1 + x)
  yhat <- as.vector(fm$fitted)

  ## calling modified.ttest
  z <- modified.ttest(y, yhat, coords, nclass = nclass)

  ## creating output object
  ESS   <- z$ESS
  df1   <- dx[2]
  df2   <- ESS - df1 - 1
  p.value <- pf(df2 * z$Fstat / df1, df1, df2, lower.tail = FALSE)
  o <- list(corr = z$corr, ESS = ESS, Fstat = z$Fstat, df1 = df1, df2 = df2, p.value = p.value)
  o$yhat <- yhat
  o$dims <- z$dims
  o$upper.bounds <- z$upper.bounds
  o$card <- z$card
  o$imoran <- z$imoran
  names(o$imoran) <- c("response","predicted")
  o$coords.names <- z$coords.names
  o$speed <- z$speed
  class(o) <- "mod.Ftest"
  return(o)
}

print.mod.Ftest <- function(x, digits = 4, ...)
{
  cat("\n")
  cat("Multiple correlation for assessing spatial autocorrelation\n")
  cat("\n")
  cat("F-statistic:", format(round(x$df2 * x$Fstat / x$df1, digits = digits)), "on",
      format(round(x$df1, digits = digits)), "and",
      format(round(x$df2, digits = digits)), "DF, p-value:",
      format(round(x$p.value, digits = digits)), "\n")
  cat("alternative hypothesis: true multiple correlation is not equal to 0\n")
  cat("sample correlation:", format(round(x$corr, digits = digits)))
  cat("\n")
  invisible(x)
}

summary.mod.Ftest <- function(object, ...)
{
  z <- object
  coef <- cbind(z$upper.bounds, z$card, as.matrix(z$imoran))
  nclass <- z$dims[3]
  dimnames(coef) <- list(1:nclass, c("Upper Bounds", "Cardinality", "Moran:y", "Moran:predicted"))
  ans <- z[c("corr", "ESS", "Fstat", "df1", "df2", "p.value")]
  ans$data.names <- z$data.names
  ans$coords.names <- z$coords.names
  ans$coef <- coef
  class(ans) <- "summary.mod.Ftest"
  ans
}

print.summary.mod.Ftest <- function(x, digits = 4, ...)
{
  print.mod.Ftest(x)
  cat("\n")
  print(x$coef, digits = digits)
  invisible(x)
}
