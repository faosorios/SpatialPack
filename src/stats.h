/* $ID: stats.h, last updated 2020-09-11, F.Osorio */

#ifndef SPATIALPACK_STATS_H
#define SPATIALPACK_STATS_H

/* routines for the computations of sample statistics */
extern void mean_and_var(double *, int, double *, double *);
extern void online_covariance(double *, double *, int, double *, double *, double *, double *, double *);

/* wrappers to be called by Fortran */
extern void F77_SUB(moments)(double *, int *, double *, double *);
extern double F77_SUB(median)(double *, int *);

#endif /* SPATIALPACK_STATS_H */
