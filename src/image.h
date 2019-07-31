/* $ID: image.h, last updated 2019/06/22, F.Osorio */

#ifndef IMAGE_H
#define IMAGE_H

#include "base.h"

/* utility routines */
extern void RGB2gray(double *, int *, double *, double *, double *, int *, int *, double *, int *);
extern void clipping(double *, int *, int *, int *, double *, double *);
extern void normalize(double *, int *, int *, int *, double *, double *);

/* routines to add noise to image */
extern void add_noise(double *, int *, int *, int *, double *, double *);
extern void gamma_noise(double *, int *, int *, int *, double *);
extern void saltnpepper(double *, int *, int *, int *, double *);
extern void sqrtgamma_noise(double *, int *, int *, int *, double *);
extern void unif_speckle(double *, int *, int *, int *, double *);

#endif /* IMAGE_H */
