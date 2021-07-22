#' US monthly unemployment data (state level)
#'
#' A dataset containing measures of unemployment in the states.
#'
#' @format A data frame with 1500 rows and 5 variables:
#' \describe{
#'   \item{fips}{Unique state FIPS code}
#'   \item{name}{State name}
#'   \item{year}{Year}
#'   \item{month}{Month}
#'   \item{unemp_rate}{Seasonally adjusted unemployment rate}
#'   ...
#' }
#' @source \url{https://www.bls.gov/web/laus/ststdsadata.zip}
#'
#' @examples
#' data(unemp)
#' head(unemp)
"unemp"
