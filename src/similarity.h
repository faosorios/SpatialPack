/* $ID: similarity.h, last updated 2019/06/17, F.Osorio */

#ifndef SIMILARITY_H
#define SIMILARITY_H

#include "base.h"

/* routines for image quality assessment */
extern void SSIM(double *, double *, int *, int *, double *, double *, double *, double *);
extern void CQ(double *, double *, int *, int *, int *, double *, double *, double *);

#endif /* SIMILARITY_H */
