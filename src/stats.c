/* $ID: stats.c, last updated 2020-09-10, F.Osorio */

#include "base.h"
#include "stats.h"
#include <fastmatrix_API.h>

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
  int k = (*nobs + 1) / 2; /* only for odd number of observations */

  return FM_find_quantile(x, *nobs, k);
}
