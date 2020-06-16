/* $ID: utils.h, last updated 2020-05-05, F.Osorio */

#ifndef UTILS_H
#define UTILS_H

#include "base.h"

/* routine for sorting observations */
extern double find_quantile(double *, int, int);
extern void F77_SUB(shellsort)(double *, int *);

#endif /* UTILS_H */
