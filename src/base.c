/* $ID: base.c, last updated 2018-08-07, F.Osorio */

#include "base.h"

DIMS
dimension(int *pdims)
{ /* dims object */
  DIMS val;

  val = (DIMS) Calloc(1, DIMS_struct);
  val->n = (int) pdims[0];
  val->p = (int) pdims[1]; /* must be 2 */
  val->nclass = (int) pdims[2];
  return val;
}

void
dimension_free(DIMS this)
{ /* destructor for a dims object */
  Free(this);
}

double
distance_max(double *xpos, double *ypos, int n)
{ /* computes the maximum distance among locations */
  double dx, dy, val = 0.0;

  for (int j = 0; j < n; j++) {
    for (int i = j + 1; i < n; i++) {
      dx = (xpos[j] - xpos[i]);
      dy = (ypos[j] - ypos[i]);
      val = fmax2(val, hypot(dx, dy));
    }
  }
  return val;
}

int
find_interval(double *y, int n, double x)
{
  for (int i = 0; i < n; i++) {
    if (x <= y[i])
      return i;
  }
  return (n - 1);
}

void
set_bounds(DIMS dims, double maxdist, int do_half, double *upper_bounds)
{
  double accum = 0.0, half = 0.5, length;

  if (do_half)
    maxdist *= half;
  length = maxdist / dims->nclass;
  for (int i = 0; i < dims->nclass; i++) {
    accum += length;
    upper_bounds[i] = accum;
  }
}

DATA
data_init(double *x, double *y, double *xpos, double *ypos, int *pdims, int do_half,
  double *upper_bounds, double *card)
{
  DATA obj;

  obj = (DATA) Calloc(1, DATA_struct);
  obj->x = x;
  obj->y = y;
  obj->xpos = xpos;
  obj->ypos = ypos;
  obj->card = card;
  obj->dims = dimension(pdims);
  obj->maxdist = distance_max(obj->xpos, obj->ypos, obj->dims->n);
  obj->upper_bounds = upper_bounds;
  set_bounds(obj->dims, obj->maxdist, do_half, obj->upper_bounds);
  return obj;
}

void
data_free(DATA this)
{ /* destructor for a data object */
  dimension_free(this->dims);
  Free(this);
}
