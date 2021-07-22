# spatialhelpers
This package contains a variety of convenience functions for working with
spatial data. Presently, these all simplify manipulation of spatial weights
objects:

- \code{w_borders} - constructs spatial weights using border lengths shared 
between units
- \code{w_data} - constructs spatial weights using dyadic data producing a 
symmetric matrix for absolute flows between units or an asymmetric matrix for 
relative flows
- \code{w_report} - reports unit neighbors or neighbor values in a w matrix
- \code{w_sim} - simulates a spatial weights matrix
- \code{w_tidy} - uses an R formula to remove elements of a spatial weights 
matrix corresponding to observations in data with missing values

spatialhelpers can be installed using devtools

\code{
# install.packages("devtools")
devtools::install_github(repo = "loganstundal/spatialhelpers")
}


