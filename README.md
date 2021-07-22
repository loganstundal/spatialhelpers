
<!-- README.md is generated from README.Rmd. Please edit that file -->

# spatialhelpers

<!-- badges: start -->
<!-- badges: end -->

`spatialhelpers` provides a variety of convenience functions for working
with spatial data. Presently, these all simplify manipulation of spatial
weights objects:

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("loganstundal/spatialhelpers")
```

## Convenience functions included here

-    - constructs spatial weights using border lengths shared between
    units
-    - constructs spatial weights using dyadic data producing a
    symmetric matrix for absolute flows between units or an asymmetric
    matrix for relative flows
-    - reports unit neighbors or neighbor values in a w matrix
-    - simulates a spatial weights matrix
-    - uses an R formula to remove elements of a spatial weights matrix
    corresponding to observations in data with missing values
