/* $ID: codisp.c, last updated 2018/08/07, F.Osorio */

#include "spatialpack.h"

/* static functions.. */
CODISP codisp_init(double *, double *, double *, double *, int *, double *, double *, double *);
void codisp_free(CODISP);
void codisp_coef(double *, double *, DIMS, double *, double *, double *, double *, double *);
/* ..end declarations */

void
codisp(double *x, double *y, double *xpos, double *ypos, int *pdims, double *upper_bounds,
  double *card, double *coef)
{
  CODISP obj;

  obj = codisp_init(x, y, xpos, ypos, pdims, upper_bounds, card, coef);
  codisp_coef(obj->data->x, obj->data->y, obj->data->dims, obj->data->xpos,
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

  obj = (CODISP) Calloc(1, CODISP_struct);
  obj->data = data_init(x, y, xpos, ypos, pdims, do_half, upper_bounds, card);
  obj->coef = coef;
  return obj;
}

void
codisp_free(CODISP this)
{ /* destructor for a codisp object */
  data_free(this->data);
  Free(this);
}

void
codisp_coef(double *x, double *y, DIMS dims, double *xpos, double *ypos,
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
  double dx, dy, sxx = 0.0, syy = 0.0, sxy = 0.0;

  /* get direction */
  h1 = h[0]; h2 = h[1];

  for (int i = h1 + 1; i < nrow; i++) {
    for (int j = h2 + 1; j < ncol; j++) {
      dx = x[(i - h1) + (j - h2) * nrow] - x[i + j * nrow];
      dy = y[(i - h1) + (j - h2) * nrow] - y[i + j * nrow];
      sxx += SQR(dx);
      syy += SQR(dy);
      sxy += dx * dy;
    }
  }

  coef[0] = sxy / sqrt(sxx * syy);
}
