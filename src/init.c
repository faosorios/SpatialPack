/* $ID: init.c, last updated 2019/07/31, F.Osorio */

#include <R_ext/Rdynload.h>
#include "image.h"
#include "similarity.h"
#include "spatialpack.h"

static const R_CMethodDef CEntries[]  = {
  {"add_noise",           (DL_FUNC) &add_noise,           6},
  {"clipping",            (DL_FUNC) &clipping,            6},
  {"codisp",              (DL_FUNC) &codisp,              8},
  {"codisp_direction",    (DL_FUNC) &codisp_direction,    6},
  {"cor_spatial",         (DL_FUNC) &cor_spatial,         10},
  {"CQ",                  (DL_FUNC) &CQ,                  8},
  {"gamma_noise",         (DL_FUNC) &gamma_noise,         5},
  {"modified_ttest",      (DL_FUNC) &modified_ttest,      10},
  {"normalize",           (DL_FUNC) &normalize,           6},
  {"RGB2gray",            (DL_FUNC) &RGB2gray,            9},
  {"saltnpepper",         (DL_FUNC) &saltnpepper,         5},
  {"SSIM",                (DL_FUNC) &SSIM,                8},
  {"unif_speckle",        (DL_FUNC) &unif_speckle,        5},
  {NULL, NULL, 0}
};

static const R_FortranMethodDef FortEntries[] = {
  {"denoise",             (DL_FUNC) &F77_NAME(denoise),   9},
  {"hcodisp",             (DL_FUNC) &F77_NAME(hcodisp),   8},
  {NULL, NULL, 0}
};

void R_init_spatialpack(DllInfo *dll)
{
  R_registerRoutines(dll, CEntries, NULL, FortEntries, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
