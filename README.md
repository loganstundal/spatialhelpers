
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

-   `w_borders` - constructs spatial weights using border lengths shared
    between units
-   `w_data` - constructs spatial weights using dyadic data producing a
    symmetric matrix for absolute flows between units or an asymmetric
    matrix for relative flows
-   `w_report` - reports unit neighbors or neighbor values in a w matrix
-   `w_sim` - simulates a spatial weights matrix
-   `w_tidy` - uses an R formula to remove elements of a spatial weights
    matrix corresponding to observations in data with missing values
