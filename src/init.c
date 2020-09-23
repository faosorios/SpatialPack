/* $ID: init.c, last updated 2020-09-11, F.Osorio */

#include "base.h"
#include "spatialpack.h"
#include <R_ext/Rdynload.h>

#define CALLDEF(name, nargs)  {#name, (DL_FUNC) &name, nargs}
#define F77DEF(name, nargs)   {#name, (DL_FUNC) &F77_NAME(name), nargs}

/* routines to assess the correlation between two spatial processes */
extern void codisp_coef(double *, double *, double *, double *, int *, double *, double *, double *);
extern void codisp_direction(double *, double *, int *, int *, int *, double *);
extern void cor_spatial(double *, double *, double *, double *, double *, double *, double *, int *, double *, double *);
extern void modified_ttest(double *, double *, double *, double *, int *, double *, double *, double *, double *, double *);

/* routines to handle images (utilities, add and remove noise) */
extern void add_noise(double *, int *, int *, int *, double *, double *);
extern void clipping_img(double *, int *, int *, int *, double *, double *);
extern void F77_NAME(de_noise)(double *, int *, int *, int *, double *, int *, double *, double *, int *);
extern void gamma_noise(double *, int *, int *, int *, double *);
extern void normalize_img(double *, int *, int *, int *, double *, double *);
extern void RGB2gray_img(double *, int *, double *, double *, double *, int *, int *, double *, int *);
extern void saltnpepper(double *, int *, int *, int *, double *);
extern void sqrt_gamma_noise(double *, int *, int *, int *, double *);
extern void unif_speckle(double *, int *, int *, int *, double *);

/* routines for image quality assessment */
extern void CQ_coef(double *, double *, int *, int *, int *, double *, double *, double *);
extern void SSIM_coef(double *, double *, int *, int *, double *, double *, double *, double *);

static const R_CMethodDef CEntries[]  = {
  CALLDEF(add_noise,        6),
  CALLDEF(clipping_img,     6),
  CALLDEF(codisp_coef,      8),
  CALLDEF(codisp_direction, 6),
  CALLDEF(cor_spatial,     10),
  CALLDEF(CQ_coef,          8),
  CALLDEF(gamma_noise,      5),
  CALLDEF(modified_ttest,  10),
  CALLDEF(normalize_img,    6),
  CALLDEF(RGB2gray_img,     9),
  CALLDEF(saltnpepper,      5),
  CALLDEF(SSIM_coef,        8),
  CALLDEF(unif_speckle,     5),
  {NULL, NULL, 0}
};

static const R_FortranMethodDef F77Entries[] = {
  F77DEF(de_noise, 9),
  F77DEF(hcodisp,  8),
  {NULL, NULL, 0}
};

void R_init_SpatialPack(DllInfo *dll)
{
  R_registerRoutines(dll, CEntries, NULL, F77Entries, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
