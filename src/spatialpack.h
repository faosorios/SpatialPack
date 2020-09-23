/* $ID: spatialpack.h, last updated 2020-06-15, F.Osorio */

#ifndef SPATIALPACK_H
#define SPATIALPACK_H

#include "base.h"

/* basic routines */
extern DIMS dimension(int *);
extern void dimension_free(DIMS);
extern double distance_max(double *, double *, int);
extern void set_bounds(DIMS, double, int, double *);
extern int find_interval(double *, int, double);
extern DATA data_init(double *, double *, double *, double *, int *, int, double *, double *);
extern void data_free(DATA);

/* random variate generation for chi and square root of gamma distribution */
extern double rng_chi(double);
extern double rng_sqrt_gamma(double, double);

/* codispersion coefficient for a direction h */
extern void F77_NAME(hcodisp)(double *, int *, int *, int *, double *, int *, int *, double *);

#endif /* SPATIALPACK_H */
