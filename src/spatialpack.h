/* $ID: spatialpack.h, last updated 2018/08/07, osorio */

#ifndef SPATIALPACK_H
#define SPATIALPACK_H

#include "base.h"

/* routines to assess the correlation between two spatial processes (to be called from R) */
extern void codisp(double *, double *, double *, double *, int *, double *, double *, double *);
extern void codisp_direction(double *, double *, int *, int *, int *, double *);
extern void cor_spatial(double *, double *, double *, double *, double *, double *, double *, int *, double *, double *);
extern void modified_ttest(double *, double *, double *, double *, int *, double *, double *, double *, double *, double *);

#endif /* SPATIALPACK_H */
