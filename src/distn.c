/* $ID: distn.c, last updated 2020-06-24, F.Osorio */

#include "spatialpack.h"

double
rng_chi(double df)
{ /* random number generation from the chi family of distributions with
   * degrees of freedom parameter df >= 1, using the ratio of uniforms
   * method as described in:
   * Monahan, J.F. (1987). ACM Transactions on Mathematical Software 13, 168-172,
   * Monahan, J.J. (1988). ACM Transactions on Mathematical Software 14, 111. */

  /* Constants : */
  const static double S_EXP_M05    = 0.60653065971263342426; /* exp(-1/2)      */
  const static double S_2_EXP_025  = 2.56805083337548278877; /* 2 * exp(1/4)   */
  const static double S_4_EXP_M135 = 1.03696104258356602834; /* 4 * exp(-1.35) */

  double a, b, c, eta, h, r, u, v, z;

  /* Setup: */
  eta = sqrt(df - 1.0);
  a = S_EXP_M05 * (M_SQRT1_2 + eta) / (0.5 + eta);
  b = -S_EXP_M05 * (1.0 - 0.25 / (SQR(eta) + 1.0));
  c = MAX(-eta, b);

  repeat {
    u = unif_rand();
    v = a + (c - a) * unif_rand();
    z = v / u;

    /* Immediate rejection */
    if (z < -eta)
      continue;

    /* Quick acceptance */
    r = 2.5 - SQR(z);
    if (z < 0.0)
      r += z * SQR(z) / (3.0 * (z + eta));
    if (u < r / S_2_EXP_025)
      return z + eta;

    /* Quick rejection */
    if (SQR(z) > S_4_EXP_M135 / u + 1.4)
      continue;

    /* Regular test */
    h = SQR(eta) * log(1.0 + z / eta) - 0.5 * SQR(z) - z * eta;
    if (2 * log(u) < h)
      return z + eta;
  }
}

double
rng_sqrt_gamma(double a, double scale)
{ /* random deviates from the square root of gamma distribution */
  return rng_chi(2.0 * a) / sqrt(2.0 * scale);
}
