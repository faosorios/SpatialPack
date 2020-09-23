/* $ID: mod_ttest.c, last updated 2018-08-07, F.Osorio */

#include "base.h"
#include "spatialpack.h"
#include "stats.h"

/* static functions.. */
TTEST mod_ttest_init(double *, double *, double *, double *, int *, double *, double *, double *, double *, double *);
void mod_ttest_free(TTEST);
void MoranI(double *, double *, DIMS, double *, double *, double *, double *, double *);
double estimated_ESS(double *, double *, DIMS, double *, double *);
void mod_ttest(double *, double *, DIMS, double *, double *, double *, double *, double *, double *, double *);
/* ..end declarations */

void
modified_ttest(double *x, double *y, double *xpos, double *ypos, int *pdims,
  double *cor, double *upper_bounds, double *card, double *imoran, double *stats)
{
  TTEST obj;

  obj = mod_ttest_init(x, y, xpos, ypos, pdims, cor, upper_bounds, card, imoran, stats);
  mod_ttest(obj->data->x, obj->data->y, obj->data->dims, obj->data->xpos, obj->data->ypos,
    obj->data->upper_bounds, obj->cor, obj->data->card, obj->imoran, obj->stats);
  mod_ttest_free(obj);
}

TTEST
mod_ttest_init(double *x, double *y, double *xpos, double *ypos, int *pdims,
  double *cor, double *upper_bounds, double *card, double *imoran, double *stats)
{ /* modified t-test object */
  TTEST obj;
  int do_half = 0;

  obj = (TTEST) Calloc(1, TTEST_struct);
  obj->data = data_init(x, y, xpos, ypos, pdims, do_half, upper_bounds, card);
  obj->cor = cor;
  obj->imoran = imoran;
  obj->stats = stats;
  return obj;
}

void
mod_ttest_free(TTEST this)
{ /* destructor for a t-test object */
  data_free(this->data);
  Free(this);
}

void
MoranI(double *x, double *y, DIMS dims, double *xpos, double *ypos, double *upper_bounds,
  double *card, double *index)
{ /* Moran's I */
  int pos;
  double dx, dy, distance, dummy, sx, sy, xbar, xvar, ybar, yvar, wts;

  online_covariance(x, y, dims->n, &xbar, &ybar, &xvar, &yvar, &dummy);

  for (int k = 0; k < dims->nclass; k++) {
    sx = sy = wts = 0.0;
    for (int j = 0; j < dims->n; j++) {
      for (int i = j + 1; i < dims->n; i++) {
        dx = (xpos[i] - xpos[j]);
        dy = (ypos[i] - ypos[j]);
        distance = hypot(dx, dy);
        pos = find_interval(upper_bounds, dims->nclass, distance);
        if (pos == k) {
          wts++;
          sx += (x[i] - xbar) * (x[j] - xbar);
          sy += (y[i] - ybar) * (y[j] - ybar);
        }
      }
    }
    index[k] = (sx / wts) / xvar;
    index[k + dims->nclass] = (sy / wts) / yvar;
    card[k] = wts;
  }
}

double
estimated_ESS(double *xpos, double *ypos, DIMS dims, double *upper_bounds, double *imoran)
{
  int pos;
  double corx, cory, dx, dy, distance, rxx, ryy, sxx, syy, sxy, trxx, tryy, trxy, ans;

  /* initialization of correlation matrices */
  sxx = syy = sxy = trxy = 0.0;
  for (int j = 0; j < dims->n; j++) {
    rxx = ryy = 0.0;
    for (int i = 0; i < dims->n; i++) {
      if (i != j) {
        dx = (xpos[i] - xpos[j]);
        dy = (ypos[i] - ypos[j]);
        distance = hypot(dx, dy);
        pos = find_interval(upper_bounds, dims->nclass, distance);
        corx = imoran[pos];
        cory = imoran[pos + dims->nclass];
      } else
        corx = cory = 1.0;
      rxx  += corx;
      ryy  += cory;
      trxy += corx * cory;
    }
    sxx += rxx;
    syy += ryy;
    sxy += rxx * ryy;
  }

  /* computation of the effective sample size */
  trxx = (double) dims->n - sxx / dims->n;
  tryy = (double) dims->n - syy / dims->n;
  trxy += (sxx * syy / dims->n - 2.0 * sxy) / dims->n;
  ans = trxx * tryy / trxy;

  return (ans + 1.0);
}

void
mod_ttest(double *x, double *y, DIMS dims, double *xpos, double *ypos, double *upper_bounds,
  double *cor, double *card, double *imoran, double *stats)
{
  int lower_tail = 0, log_p = 0;
  double ESS, df, F, R, pval;

  MoranI(x, y, dims, xpos, ypos, upper_bounds, card, imoran);

  ESS  = estimated_ESS(xpos, ypos, dims, upper_bounds, imoran);
  R    = *cor; /* only for p = 2! */
  df   = ESS - 2.0;
  F    = SQR(R) / (1.0 - SQR(R)); /* unscaled F */
  pval = pf(df * F, 1.0, df, lower_tail, log_p);

  /* save results */
  stats[0] = ESS;
  stats[1] = F;
  stats[2] = pval;
}
