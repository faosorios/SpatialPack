/* ID: interface.h, last updated 2024-09-13, F.Osorio */

#include "spatialpack.h"

#ifndef SPATIALPACK_INTERFACE_H
#define SPATIALPACK_INTERFACE_H

/* basic matrix manipulations */
extern void crossprod(double *, double *, int, int, int, double *, int, int, int);
extern double norm_sqr(double *, int, int);
extern void scale(double *, int, int, double);

/* routines for the computations of descriptive statistics */
extern void mean_and_var(double *, int, double *, double *);
extern void online_covariance(double *, double *, int, double *, double *, double *, double *, double *);

/* wrappers to be called by Fortran */
extern double F77_SUB(median)(double *, int *);
extern void F77_SUB(moments)(double *, int *, double *, double *);

/* Pythagorean addition */
extern double pythag(double, double);

/* Misc */
extern void print_mat(double *, int, int, int, char *);

#endif /* SPATIALPACK_INTERFACE_H */
