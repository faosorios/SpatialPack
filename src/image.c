/* $ID: image.c, last updated 2019/07/25, F.Osorio */

#include "base.h"
#include "image.h"
#include "stats.h"

/* static functions.. */
static double average(double, double, double);
static double BT_240(double, double, double);
static double BT_709(double, double, double);
static double brighter(double, double, double);
static double darker(double, double, double);
static double lightness(double, double, double);
static double luma(double, double, double);
static double rmy(double, double, double);
static double weighted(double, double, double, double *);
static void grayscale(double *, int, double *, double *, double *, int, int, double *, method);
/* ..end declarations */

static double
average(double red, double green, double blue) {
  return (red + green + blue) / 3.;
}

static double
BT_240(double red, double green, double blue) {
  return (0.2120 * red + 0.7010 * green + 0.0870 * blue);
}

static double
BT_709(double red, double green, double blue) {
  return (0.2126 * red + 0.7152 * green + 0.0722 * blue); /* ITU */
}

static double
luma(double red, double green, double blue) {
  return (0.3000 * red + 0.5900 * green + 0.1100 * blue); /* BT.601, used by GIMP and Photoshop */
}

static double
rmy(double red, double green, double blue) {
  return (0.5000 * red + 0.4190 * green + 0.0810 * blue);
}

static double
brighter(double red, double green, double blue) {
  return MAX(MAX(red, green), blue); /* maximum decomposition */
}

static double
darker(double red, double green, double blue) {
  return MIN(MIN(red, green), blue); /* minimum decomposition */
}

static double
lightness(double red, double green, double blue)
{ /* desaturation */
  double largest, lowest;

  lowest  = MIN(MIN(red, green), blue);
  largest = MAX(MAX(red, green), blue);

  return (lowest + largest) / 2.;
}

static double
weighted(double red, double green, double blue, double *wts) {
  return (wts[0] * red + wts[1] * green + wts[2] * blue); /* user supplied weights */
}

static void
grayscale(double *y, int ldy, double *red, double *green, double *blue, int ncol,
  int nrow, double *weights, method job)
{ /* grayscale method dispatcher */
  for (int j = 0; j < ncol; j++) {
    for (int i = 0; i < nrow; i++) {
      switch (job) {
        case AVERAGE:
          y[i] = average(red[i], green[i], blue[i]);
          break;
        case BT240:
          y[i] = BT_240(red[i], green[i], blue[i]);
          break;
        case BRIGHTER:
          y[i] = brighter(red[i], green[i], blue[i]);
          break;
        case DARKER:
          y[i] = darker(red[i], green[i], blue[i]);
          break;
        case ITU:
          y[i] = BT_709(red[i], green[i], blue[i]);
          break;
        case LIGHTNESS:
          y[i] = lightness(red[i], green[i], blue[i]);
          break;
        case LUMA:
          y[i] = luma(red[i], green[i], blue[i]);
          break;
        case RMY:
          y[i] = rmy(red[i], green[i], blue[i]);
          break;
        case WEIGHTED:
          y[i] = weighted(red[i], green[i], blue[i], weights);
          break;
      }
    }
    y += ldy; red += ldy; green += ldy; blue += ldy;
  }
}

void
RGB2gray(double *y, int *ny, double *red, double *green, double *blue, int *nr, int *nc,
  double *weights, int *task)
{ /* convert an image in RGB channels into a graycale */
  int ldy = *ny, nrow = *nr, ncol = *nc;
  method job = *task;

  grayscale(y, ldy, red, green, blue, nrow, ncol, weights, job);
}

void
clipping(double *y, int *ny, int *nr, int *nc, double *low, double *high)
{
  int ldy = *ny, nrow = *nr, ncol = *nc;
  double lower = *low, upper = *high;

  for (int j = 0; j < ncol; j++) {
    for (int i = 0; i < nrow; i++) {
      if (y[i] < lower)
        y[i] = lower;
      else if (y[i] > upper)
        y[i] = upper;
    }
    y += ldy;
  }
}

void
normalize(double *y, int *ny, int *nr, int *nc, double *vmin, double *vmax)
{
  int ldy = *ny, nrow = *nr, ncol = *nc;
  double min = *vmin, max = *vmax, range;

  range = max - min;
  for (int j = 0; j < ncol; j++) {
    for (int i = 0; i < nrow; i++) {
      y[i] = (y[i] - min) / range;
    }
    y += ldy;
  }
}

void
add_noise(double *y, int *ny, int *nr, int *nc, double *mean, double *sd)
{ /* add gaussian noise to 'y' matrix */
  int ldy = *ny, nrow = *nr, ncol = *nc;

  GetRNGstate();
  for (int j = 0; j < ncol; j++) {
    for (int i = 0; i < nrow; i++) {
      y[i] += *mean + *sd * norm_rand();
    }
    y += ldy;
  }
  PutRNGstate();
}

void
saltnpepper(double *y, int *ny, int *nr, int *nc, double *epsilon)
{ /* add salt and pepper noise */
  int ldy = *ny, nrow = *nr, ncol = *nc, nobs;
  double eps = *epsilon, sd, unif, ybar, yvar;

  nobs = nrow * ncol;
  mean_and_var(y, nobs, &ybar, &yvar);
  sd = sqrt(yvar);

  GetRNGstate();
  for (int j = 0; j < ncol; j++) {
    for (int i = 0; i < nrow; i++) {
      unif  = unif_rand();
      if (unif < eps)
        y[i] = ybar + sd * norm_rand();
    }
    y += ldy;
  }
  PutRNGstate();
}

void
unif_speckle(double *y, int *ny, int *nr, int *nc, double *var)
{ /* add multiplicative (uniform) noise to 'y' matrix */
  const static double sqrt12 = 3.46410161513775438635; /* sqrt(12) */
  int ldy = *ny, nrow = *nr, ncol = *nc;
  double sd = sqrt(*var);

  GetRNGstate();
  for (int j = 0; j < ncol; j++) {
    for (int i = 0; i < nrow; i++) {
      y[i] += sqrt12 * sd * (unif_rand() - 0.5) * y[i];
    }
    y += ldy;
  }
  PutRNGstate();
}

void
gamma_noise(double *y, int *ny, int *nr, int *nc, double *looks)
{ /* add multiplicative (Gamma) noise to 'y' matrix */
  int ldy = *ny, nrow = *nr, ncol = *nc;
  double nlooks = *looks;

  GetRNGstate();
  for (int j = 0; j < ncol; j++) {
    for (int i = 0; i < nrow; i++) {
      y[i] *= rgamma(nlooks, 1.0 / nlooks);
    }
    y += ldy;
  }
  PutRNGstate();
}
