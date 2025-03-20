/* $ID: cor_spatial.c, last updated 2024-09-13, F.Osorio */

#include "spatialpack.h"

/* static functions.. */
static void tjostheim_and_var(double *, double *, double *, double *, double *, double *, DIMS, double, double, double *, double *);
/* ..end declarations */

void
cor_spatial(double *fx, double *fy, double *gx, double *gy, double *bars, double *xpos,
  double *ypos, int *pdims, double *cor, double *var)
{ /* Tjostheim's association coefficient */
  DIMS dims;
  double xbar, ybar;

  dims = dimension(pdims);
  xbar = bars[0];
  ybar = bars[1];
  tjostheim_and_var(fx, fy, gx, gy, xpos, ypos, dims, xbar, ybar, cor, var);
  dimension_free(dims);
}

static void
tjostheim_and_var(double *fx, double *fy, double *gx, double *gy, double *xpos, double *ypos, 
  DIMS dims, double fbar, double gbar, double *cor, double *var)
{
  double accx, accy, prod, sxx, syy, sxy;

  accx = accy = prod = 0.0;
  sxx = syy = sxy = 0.0;
  for (int i = 0; i < dims->n; i++) {
    sxy += (fx[i] - fbar) * (fy[i] - fbar) + (gx[i] - gbar) * (gy[i] - gbar);
    sxx += SQR(fx[i] - fbar) + SQR(gx[i] - gbar);
    syy += SQR(fy[i] - fbar) + SQR(gy[i] - gbar);
    accx += SQR(xpos[i]);
    accy += SQR(ypos[i]);
    prod += xpos[i] * ypos[i];
  }

  /* Tjostheim's coefficient */
  *cor = sxy / sqrt(sxx * syy);

  /* variance of the coefficient */
  *var  = SQR(accx) + SQR(accy) + 2.0 * SQR(prod);
  *var /= (dims->n - 1.0) * SQR(accx + accy);
}
