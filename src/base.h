/* $ID: base.h, last updated 2020-09-10, F.Osorio */

#ifndef SPATIALPACK_BASE_H
#define SPATIALPACK_BASE_H

#include <R.h>
#include <Rmath.h>
#include <Rinternals.h>
#include <R_ext/Print.h>
#include <R_ext/BLAS.h>
#include <R_ext/Lapack.h>
#include <R_ext/Linpack.h>
#include <R_ext/Applic.h>
#include <R_ext/Utils.h>

/* some definitions */
#define MAX(a,b)    (((a)>(b)) ? (a) : (b))
#define MIN(a,b)    (((a)<(b)) ? (a) : (b))
#define EQUAL(a,b)  (((a)!=(b)) ? (0) : (1))
#define SQR(x)      R_pow_di(x, 2)
#define repeat      for(;;)

/* available methods */
typedef enum {
  AVERAGE, BT240, BRIGHTER, DARKER, ITU, LIGHTNESS, LUMA, RMY, WEIGHTED
} method;

/* dims structure */
typedef struct DIMS_struct {
  int
    n,              /* number of observations */
    p,              /* number of variables */
    nclass;         /* total of classes */
} DIMS_struct, *DIMS;

/* data structure */
typedef struct DATA_struct {
  DIMS dims;        /* dimension data info */
  double
    *x,             /* vector of x values */
    *y,             /* vector of y values */
    *xpos,          /* x locations */
    *ypos,          /* y locations */
    *upper_bounds,  /* classes offsets */
    *card,          /* cardinality */
    maxdist;        /* maximum of computed distances */
} DATA_struct, *DATA;

/* modified t-test structure */
typedef struct TTEST_struct {
  DATA data;        /* data structure */
  double
    *cor,           /* Pearson's correlation */
    *imoran,        /* Moran's index */
    *stats;         /* association t-test */
} TTEST_struct, *TTEST;

/* codispersion structure */
typedef struct CODISP_struct {
  DATA data;        /* data structure */
  double
    *coef;          /* association coefficient */
} CODISP_struct, *CODISP;

#endif /* SPATIALPACK_BASE_H */
