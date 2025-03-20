/* $ID: weights.c, last updated 2024-09-28, F.Osorio */

#include "spatialpack.h"

/* static functions.. */
static double weight_unif(double);
static double weight_epan(double);
static double weight_gauss(double);
static double weight_biwt(double);
static double weight_trian(double);
/* ..end declarations */

double
do_weight(double z, KERNEL kind)
{ /* weights dispatcher */
  double c0 = 0.5, c1 = 0.33541019662497, c2 = 0.9375;
  double wts;

  switch (kind) {
    case UNIFORM:
      wts = c0 * weight_unif(z);
      break;
    case EPANECHNIKOV:
      wts = c1 * weight_epan(z);
      break;
    case GAUSSIAN:
      wts = weight_gauss(z);
      break;
    case BIWEIGHT:
      wts = c2 * weight_biwt(z);
      break;
    case TRIANGULAR:
      wts = weight_trian(z);
      break;
    default:
      wts = 1.0;
      break;
  }
  return wts;
}

static double
weight_unif(double z) 
{ /* uniform kernel */
  double ans;

  ans = (fabs(z) < 1.0) ? 1.0 : 0.0;
  return ans;
}

static double
weight_epan(double z) 
{ /* Epanechnikov kernel */
  double ans, EPA_SQRT5 = 2.2360679775;

  ans = (fabs(z) < EPA_SQRT5) ? (1.0 - 0.2 * SQR(z)) : 0.0;
  return ans;
}

static double
weight_gauss(double z)
{ /* gaussian kernel */
  return dnorm(z, 0.0, 1.0, 0);
}

static double
weight_biwt(double z)
{ /* biweight kernel */
  double ans;

  ans = (fabs(z) < 1.0) ? (1.0 - SQR(z)) : 0.0;
  return SQR(ans);
}

static double
weight_trian(double z)
{ /* triangular kernel */
  double ans;

  ans = (fabs(z) < 1.0) ? (1.0 - fabs(z)) : 0.0;
  return ans;
}
