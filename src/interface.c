/* ID: interface.c, last updated 2024-09-28, F.Osorio */

#include "interface.h"
#include <fastmatrix_API.h>

/* ========================================================================== *
 * basic matrix manipulations
 * ========================================================================== */

double
norm_sqr(double *x, int n, int inc)
{ /* sum(x * x) */
  return FM_norm_sqr(x, inc, n);
}

void
scale(double *x, int n, int inc, double alpha)
{ /* x <- alpha * x */
  BLAS1_scale(alpha, x, inc, n);
}

void
crossprod(double *z, double *x, int ldx, int xrows, int xcols, double *y, int ldy, int yrows, int ycols)
{ /* cross product of two given matrices. z <- t(x) %*% y */
  FM_crossprod(z, x, ldx, xrows, xcols, y, ldy, yrows, ycols);
}

/* ========================================================================== *
 * (univariate) descriptive statistics 
 * ========================================================================== */

void
mean_and_var(double *x, int nobs, double *mean, double *var)
{ /* C wrapper to FM_mean_and_var */
  FM_mean_and_var(x, nobs, mean, var);
}

void
online_covariance(double *x, double *y, int nobs, double *xbar, double *ybar, double *xvar,
  double *yvar, double *cov)
{ /* C wrapper to FM_online_covariance */
  FM_online_covariance(x, y, nobs, xbar, ybar, xvar, yvar, cov);
}

void
F77_SUB(moments)(double *x, int *nobs, double *mean, double *var)
{ /* F77 wrapper to FM_mean_and_var */
  FM_mean_and_var(x, *nobs, mean, var);
}

double
F77_SUB(median)(double *x, int *nobs)
{ /* F77 wrapper to FM_find_quantile */
  int lo, hi, mid, n = *nobs;
  double val;

  if (n % 2 == 0) { /* even number of observations */
    lo = n / 2;
    hi = lo + 1;
    val  = FM_find_quantile(x, n, lo);
    val += FM_find_quantile(x, n, hi);
    val /= 2;
  } else {
    mid = (n + 1) / 2;
    val  = FM_find_quantile(x, n, mid);
  }
  return val;
}

/* ========================================================================== *
 * Euclidean distance
 * ========================================================================== */

double 
pythag(double a, double b)
{ /* Pythagorean sum: sqrt(a^2 + b^2) */
  return FM_pythag(a, b);
}

/* ========================================================================== *
 * Misc
 * ========================================================================== */

void
print_mat(double *x, int ldx, int nrow, int ncol, char *msg)
{ /* print matrix and message */
  FM_print_mat(x, ldx, nrow, ncol, msg);
}