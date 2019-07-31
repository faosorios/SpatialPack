/* $ID: base.h, last updated 2019/06/14, F.Osorio */

#ifndef BASE_H
#define BASE_H

#include <R.h>
#include <Rmath.h>
#include <Rinternals.h>
#include <R_ext/Print.h>
#include <R_ext/BLAS.h>
#include <R_ext/Lapack.h>
#include <R_ext/Linpack.h>
#include <R_ext/Applic.h>

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

/* basic routines */
extern DIMS dimension(int *);
extern void dimension_free(DIMS);
extern double distance_max(double *, double *, int);
extern void set_bounds(DIMS, double, int, double *);
extern int find_interval(double *, int, double);
extern DATA data_init(double *, double *, double *, double *, int *, int, double *, double *);
extern void data_free(DATA);

#endif /* BASE_H */
