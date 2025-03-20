# SpatialPack: Tools for assessment the association between two spatial processes

[![CRAN status](http://www.r-pkg.org/badges/version/SpatialPack)](https://cran.r-project.org/package=SpatialPack)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/SpatialPack)](https://cran.r-project.org/package=SpatialPack)

`SpatialPack` provides tools to assess the association between two spatial processes. Currently, several methodologies are implemented: A modified t-test to perform hypothesis testing about the independence between the processes, a suitable nonparametric correlation coefficient, the codispersion coefficient, and an F test for assessing the multiple correlation between one spatial process and several others. Functions for image processing and computing the spatial association between images are also provided. `SpatialPack` gives methods to complement methodologies that are available in `geoR` for one spatial process.

* Tjostheim's Coefficient.
  - Tjostheim, D., 1978. A measure of association for spatial variables. [Biometrika](https://doi.org/10.1093/biomet/65.1.109) 65, 109-114.
* A Modified Correlation Coefficient Test.
  - Clifford, P., Richardson, S., Hemon, D., 1989. Assessing the significance of the correlation between two spatial processes. [Biometrics](https://doi.org/10.2307/2532039) 45, 123-134.
* The Codispersion Coefficient.
  - Matheron, G., 1965. [Les Variables Regionalisees et leur Estimation](http://www.numdam.org/item?id=JSFS_1966__107__263_0). Masson, Paris.
  - Rukhin, A., Vallejos, R., 2008. Codispersion coefficients for spatial and temporal series. [Statistics and Probability Letters](https://doi.org/10.1016/j.spl.2007.11.017) 78, 1290-1300.
* Modified F Test for assessing multiple correlation.
  - Dutilleul, P., Pelletier, B., Alpargu, G., 2008. Modified F test for assessing the multiple correlation between one spatial process and several others. [Journal of Statistical Planning and Inference](https://doi.org/10.1016/j.jspi.2007.06.022) 138, 1402-1415.

A detailed description of each of these techniques is presented in the book:

Vallejos, R., Osorio, F., Bevilacqua, M. (2020). Spatial Relationships Between Two Georeferenced Variables: with Applications in R. Springer, Cham. DOI: [10.1007/978-3-030-56681-4](https://doi.org/10.1007/978-3-030-56681-4)

## Reference Manual

* [SpatialPack.pdf](https://cran.r-project.org/web/packages/SpatialPack/SpatialPack.pdf)

## Resources

Latest binaries and sources can be found at the [CRAN package repository](https://cran.r-project.org/package=SpatialPack):

* [SpatialPack_0.4-1.tar.gz](https://cran.r-project.org/src/contrib/SpatialPack_0.4-1.tar.gz) - Package sources
* [SpatialPack_0.4-1.zip](https://cran.r-project.org/bin/windows/contrib/4.4/SpatialPack_0.4-1.zip) - Windows binaries (R-release)
* [SpatialPack_0.4-1.tgz](https://cran.r-project.org/bin/macosx/big-sur-arm64/contrib/4.4/SpatialPack_0.4-1.tgz) - MacOS binaries (R-release, arm64)
* [SpatialPack_0.4-1.tgz](https://cran.r-project.org/bin/macosx/big-sur-x86_64/contrib/4.4/SpatialPack_0.4-1.tgz) - MacOS binaries (R-release, x86_64)

## Installation

Install `SpatialPack` from CRAN using.

``` r
install.packages("SpatialPack")
```
You can install the latest development version from github with:

``` r
# install.packages("devtools")
devtools::install_github("faosorios/SpatialPack")
```
Alternatively, you can download the source as a tarball or as a zip file. Unpack the tarball or zipfile (thereby creating a directory named, SpatialPack) and install the package source by executing (at the console prompt)
``` r
R CMD INSTALL SpatialPack
```
Next, you can load the package by using the command `library(SpatialPack)`

## Features
-   Computes Tjostheim's coefficient and its asymptotic variance for two spatial sequences defined on the same locations on the plane.
-   Performs an hypothesis testing based on a modified version of the correlation coefficient. The test provides a decision rule to elucidate whether the two processes are spatially correlated or not. The spatial sequences need to be defined on the same locations on the plane.
-   Computes de codispersion coefficient for a specific direction h on the plane.
-   Provides a plot for the codispersion coefficient versus the lag distance *h* for isotropic processes.
-   Functions for image processing and computing the spatial association between images are also provided.

## Citation

To cite package `SpatialPack` in publications use:

``` r
To cite the SpatialPack package in publications use:

  Vallejos, R., Osorio, F., Bevilacqua, M. (2020). Spatial
  Relationships Between Two Georeferenced Variables: with Applications
  in R. Springer, New York. ISBN 978-3-030-56680-7

A BibTeX entry for LaTeX users is

  @Book{,
    title = {Spatial Relationships Between Two Georeferenced Variables: with Applications in R},
    author = {R. Vallejos and F. Osorio and M. Bevilacqua},
    publisher = {Springer},
    address = {New York},
    year = {2020},
    note = {ISBN 978-3-030-56680-7},
    url = {http://srb2gv.mat.utfsm.cl/},
  }
```

## References
- Osorio, F., Vallejos, R., Barraza, W., Ojeda, S.M., Landi, M.A. (2022). Statistical estimation of the structural similarity index for image quality assessment. [Signal, Image and Video Processing](https://doi.org/10.1007/s11760-021-02051-9) 16, 1035-1042.
- Acosta, J., Vallejos, R. (2018). Effective sample size for spatial regression processes. [Electronic Journal of Statistics](https://doi.org/10.1111/stan.12060) 12, 3147-3180.
- Vallejos, R., Osorio, F., Mancilla, D. (2015). The codispersion map: A graphical tool to visualize the association between two spatial variables. [Statistica Neerlandica](https://doi.org/10.1111/stan.12060) 69, 298-314.
- Cuevas, F., Porcu, E., Vallejos, R. (2013). Study of spatial relationships between two sets of variables: A nonparametric approach. [Journal of Nonparametric Statistics](https://doi.org/10.1080/10485252.2013.797091) 25, 695-714.
- Ojeda, S., Vallejos, R., Lamberti, P. (2012). Measure of similarity between images based on the codispersion coefficient. [Journal of Electronic Imaging](https://doi.org/10.1117/1.JEI.21.2.023019) 21, 023019.

## Papers using SpatialPack
- Stephens, P.R., Farrell, M.J., Davies, T.J., Gittleman, J.L., Meiri, S., Moreira, M.O., Roll, U., Wiens, J.J. (2025).  Global diversity patterns are explained by diversification rates and dispersal at ancient, not shallow, timescales. [Systematic Biology](https://doi.org/10.1093/sysbio/syaf018) syaf018.
- Habeeb, R., Almazah, M.M.A., Hussain, I., Al-Ansari, N., Al-Rezami, A.Y., Sammen, S.Sh. (2023). Modified standardized precipitation evapotranspiration index: spatiotemporal analysis of drought. [Geomatics, Natural Hazards and Risk](https://doi.org/10.1080/19475705.2023.2195532) 14 (1), 2195532.
- Moura, M.R., do Nascimento, F.A.O., Paolucci, L.N., Silva, D.P., Santos, B.A. (2023). Pervasive impacts of climate change on the woodiness and ecological generalism of dry forest plant assemblages. [Journal of Ecology](https://doi.org/10.1111/1365-2745.14139) 111, 1762-1776.
- Tehreem, Z., Ali, Z., Al-Ansari, N., Niaz, R., Hussain, I., Sammen, S.Sh. (2022). A novel appraisal protocol for spatiotemporal patterns of rainfall by reconnaissance the precipitation concentration index (PCI) with global warming context. [Mathematical Problems in Engineering](https://doi.org/10.1155/2022/3012100) 2022, ID 3012100.
- Buss, D.L., Hearne, E., Loy, R.H.Y., Manica, A., O'Connell, T.C., Jackson, J.A. (2022). Evidence of resource partitioning between fin and sei whales during the twentieth-century whaling period. [Marine Biology](https://doi.org/10.1007/s00227-022-04131-x) 169, 150.
- Ali, Z., Hussain, I., Faisal, M., Shad, M.Y., Elashkar, E.E., Gani, S. (2019). An ensemble procedure for pattern recognition of regional drought. [The International Journal of Climatology](https://doi.org/10.1002/joc.6196) 40, 94-114.

## Providing Feedback

Please report any bugs/suggestions/improvements to [Felipe Osorio](https://faosorios.github.io/). If you find these routines useful or not then please let me know. Also, acknowledgement of the use of the routines is appreciated.

## About the Authors

Felipe Osorio is an applied statistician and creator of several R packages
* Webpage: [faosorios.github.io](https://faosorios.github.io/)

Ronny Vallejos is Associate Professor at Department of Mathematics of the Universidad Tecnica Federico Santa Maria, Chile.
* Webpage: [rvallejos.mat.utfsm.cl](https://rvallejos.mat.utfsm.cl/)
