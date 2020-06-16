/* $ID: utils.c, last updated 2020-05-05, F.Osorio */

#include "base.h"

double
find_quantile(double *a, int n, int k)
{ /* for an array with n elements, find the element which would be a[k] if
   * the array were sorted from smallest to largest (without the need to do
   * a full sort) */
   double w, x;
   int l = 0;
   int r = n - 1;
   int i, j;

   while (l < r) {
     x = a[k];
     i = l;
     j = r;
     while (j >= i) {
       while (a[i] < x) i++;
       while (x < a[j]) j--;
       if (i <= j) {
         w = a[i];
         a[i++] = a[j];
         a[j--] = w;
       }
     }
     if (j < k) l = i;
     if (k < i) r = j;
  }

  return a[k];
}

void
F77_SUB(shellsort)(double *x, int *n)
{ /* sort real (double) data */
  R_rsort(x, *n);
}
