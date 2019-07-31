/* $ID: cor_spatial.c, last updated 2018/08/07, F.Osorio */

#include "spatialpack.h"

/* static functions.. */
static void tjostheim(double *, double *, double *, double *, DIMS, double, double, double *);
static void var_tjostheim(double *, double *, DIMS, double *);
/* ..end declarations */

void
cor_spatial(double *fx, double *fy, double *gx, double *gy, double *bars, double *xpos,
  double *ypos, int *pdims, double *cor, double *var)
{
  DIMS dims;
  double xbar, ybar;

  dims = dimension(pdims);
  xbar = bars[0];
  ybar = bars[1];
  tjostheim(fx, fy, gx, gy, dims, xbar, ybar, cor);
  var_tjostheim(xpos, ypos, dims, var);
  dimension_free(dims);
}

static void
tjostheim(double *fx, double *fy, double *gx, double *gy, DIMS dims, double fbar,
  double gbar, double *cor)
{
  double sxx, syy, sxy;

  sxx = syy = sxy = 0.0;
  for (int i = 0; i < dims->n; i++) {
    sxy += (fx[i] - fbar) * (fy[i] - fbar) + (gx[i] - gbar) * (gy[i] - gbar);
    sxx += SQR(fx[i] - fbar) + SQR(gx[i] - gbar);
    syy += SQR(fy[i] - fbar) + SQR(gy[i] - gbar);
  }

  *cor = sxy / sqrt(sxx * syy);
}

static void
var_tjostheim(double *xpos, double *ypos, DIMS dims, double *var)
{
  double ans, sxx, syy, sxy;

  sxx = syy = sxy = 0.0;
  for (int i = 0; i < dims->n; i++) {
    sxx += SQR(xpos[i]);
    syy += SQR(ypos[i]);
    sxy += xpos[i] * ypos[i];
  }
  ans  = SQR(sxx) + SQR(syy) + 2.0 * SQR(sxy);
  ans /= (dims->n - 1.0) * SQR(sxx + syy);
  *var = ans;
}
