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
