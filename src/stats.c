/* $ID: stats.c, last updated 2019-06-14, F.Osorio */

#include "stats.h"
#include "utils.h"

void
mean_and_var(double *x, int nobs, double *mean, double *var)
{ /* computes the sample mean and variance using an online algorithm */
  int n = 0;
  double accum = 0.0, diff;

  *mean = 0.0;
  for (int i = 0; i < nobs; i++) {
    n++;
    diff = x[i] - *mean;
    *mean += diff / n;
    accum += diff * (x[i] - *mean);
  }
  *var = accum / n;
}

void
online_covariance(double *x, double *y, int nobs, double *xbar, double *ybar,
  double *xvar, double *yvar, double *cov)
{ /* computes the sample covariance using an online algorithm */
  int n = 0;
  double accum = 0.0, acc_x = 0.0, acc_y = 0.0, diff_x, diff_y;

  *xbar = *ybar = 0.0;
  for (int i = 0; i < nobs; i++) {
    n++;
    diff_x = x[i] - *xbar;
    diff_y = y[i] - *ybar;
    *xbar += diff_x / n;
    *ybar += diff_y / n;
    acc_x += diff_x * (x[i] - *xbar);
    acc_y += diff_y * (y[i] - *ybar);
    accum += (n - 1) * (diff_x / n) * (diff_y / n) - accum / n;
  }
  *xvar = acc_x / n;
  *yvar = acc_y / n;
  *cov  = accum;
}

void
F77_SUB(moments)(double *x, int *nobs, double *mean, double *var)
{ /* wrapper to mean_and_var */
  mean_and_var(x, *nobs, mean, var);
}

double
F77_SUB(median)(double *x, int *nobs)
{ /* wrapper to select */
  int k = (*nobs + 1) / 2; /* only for odd number of observations */

  return find_quantile(x, *nobs, k);
}
