/* $ID: stats.h, last updated 2018/08/07, osorio */

#ifndef STATS_H
#define STATS_H

#include "base.h"

/* routines for the computations of sample statistics */
extern void mean_and_var(double *, int, double *, double *);
extern void online_covariance(double *, double *, int, double *, double *, double *, double *, double *);

#endif /* STATS_H */
