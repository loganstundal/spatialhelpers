#' A simple feature collection of 48 contiguous states
#'
#' @description A dataset containing geometry for 48 contiguous US states.
#'
#' @format A data frame with 48 rows and 1 variable:
#' \describe{
#'   \item{fips}{Unique state FIPS code}
#'   \item{name}{State name}
#'   \item{geometry}{Spatial geometry}
#' }
#' @source \url{https://www.census.gov/geographies/mapping-files/time-series/geo/carto-boundary-file.html}
#'
#' @examples
#' data(trade)
#' head(trade)
"us"
