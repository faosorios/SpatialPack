/* $ID: codisp.c, last updated 2024-09-28, F.Osorio */

#include "spatialpack.h"

/* static functions.. */
CODISP codisp_init(double *, double *, double *, double *, int *, double *, double *, double *);
void codisp_free(CODISP);
void codisp_cf(double *, double *, DIMS, double *, double *, double *, double *, double *);
/* ..end declarations */

void
codisp_coef(double *x, double *y, double *xpos, double *ypos, int *pdims, double *upper_bounds,
  double *card, double *coef)
{
  CODISP obj;

  obj = codisp_init(x, y, xpos, ypos, pdims, upper_bounds, card, coef);
  codisp_cf(obj->data->x, obj->data->y, obj->data->dims, obj->data->xpos,
            obj->data->ypos, obj->data->upper_bounds, obj->data->card,
            obj->coef);
  codisp_free(obj);
}

CODISP
codisp_init(double *x, double *y, double *xpos, double *ypos, int *pdims,
  double *upper_bounds, double *card, double *coef)
{
  CODISP obj;
  int do_half = 1;

  obj = (CODISP) R_Calloc(1, CODISP_struct);
  obj->data = data_init(x, y, xpos, ypos, pdims, do_half, upper_bounds, card);
  obj->coef = coef;
  return obj;
}

void
codisp_free(CODISP this)
{ /* destructor for a codisp object */
  data_free(this->data);
  R_Free(this);
}

void
codisp_cf(double *x, double *y, DIMS dims, double *xpos, double *ypos,
  double *upper_bounds, double *card, double *coef)
{
  int pos;
  double accum, distance, dx, dy, sxx, syy, sxy;

  for (int k = 0; k < dims->nclass; k++) {
    accum = sxx = syy = sxy = 0.0;
    for (int i = 0; i < dims->n; i++) {
      for (int j = i + 1; j < dims->n; j++) {
        dx = xpos[i] - xpos[j];
        dy = ypos[i] - ypos[j];
        distance = hypot(dx, dy);
        pos = find_interval(upper_bounds, dims->nclass, distance);
        if (pos == k) {
          accum++;
          dx = x[i] - x[j];
          dy = y[i] - y[j];
          sxx += SQR(dx);
          syy += SQR(dy);
          sxy += dx * dy;
        }
      }
    }
    sxx /= accum;
    syy /= accum;
    sxy /= accum;
    card[k] = accum;
    if (accum)
      coef[k] = sxy / sqrt(sxx * syy);
  }
}

void
codisp_direction(double *x, double *y, int *nr, int *nc, int *h, double *coef)
{
  int h1, h2, nrow = *nr, ncol = *nc;
  double dx, dy, cross = 0.0, sxx = 0.0, syy = 0.0;

  /* get direction */
  h1 = h[0]; h2 = h[1];

  for (int i = 0; i < nrow - h1; i++) {
    for (int j = 0; j < ncol - h2; j++) {
      dx = x[i + j * nrow] - x[i + h1 + (j + h2) * nrow];
      dy = y[i + j * nrow] - y[i + h1 + (j + h2) * nrow];
      cross += dx * dy;
      sxx += SQR(dx);
      syy += SQR(dy);
    }
  }

  *coef = cross / sqrt(sxx * syy);
}

void
codisp_ks(double *x, double *y, double *xpos, double *ypos, int *nobs, double *lags, double *bandwidths, int *task, double *coef)
{ /* creates the local model matrix and the working response */
  KERNEL kind = *task;
  int n = *nobs;
  double acc1, acc2, acc3, accu, accx, accy, cross, d1, d2, h1, h2, h3, k1, k2, prod, rho, vx, vy;

  /* get bandwidths */
  h1 = bandwidths[0]; h2 = bandwidths[1]; h3 = bandwidths[2];

  /* get lags */
  k1 = lags[0]; k2 = lags[1];

  acc1 = acc2 = acc3 = accu = accx = accy = 0.0;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      d1 = xpos[i] - xpos[j];
      d2 = ypos[i] - ypos[j];
      prod = do_weight((k1 - d1) / h1, kind) * do_weight((k2 - d2) / h1, kind);
      acc1 += prod;
      accx += prod * SQR(x[i] - x[j]);
      prod = do_weight((k1 - d1) / h2, kind) * do_weight((k2 - d2) / h2, kind);
      acc2 += prod;
      accy += prod * SQR(y[i] - y[j]);
      prod = do_weight((k1 - d1) / h3, kind) * do_weight((k2 - d2) / h3, kind);
      acc3 += prod;
      accu += prod * (x[i] - x[j]) * (y[i] - y[j]);
    }
  }
  vx = 0.5 * accx / acc1;
  vy = 0.5 * accy / acc2;
  cross = 0.5 * accu / acc3;
  rho = cross / sqrt(vx * vy);

  /* saving results */
  coef[0] = vx;
  coef[1] = vy;
  coef[2] = cross;
  coef[3] = rho;
}
