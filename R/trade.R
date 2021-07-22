#' Bilateral trade data
#'
#' A dataset containing the bilateral trade between countries in 2001.
#'
#' @format A data frame with 13728 rows and 5 variables:
#' \describe{
#'   \item{importer1}{Name of country A}
#'   \item{importer2}{Name of country B}
#'   \item{flow1}{Country A imports from country B in current USD (millions)}
#'   \item{flow2}{Country B imports from Country A in current USD (millions)}
#'   \item{total_trade}{Total trade (millions current usd) between country A and B}
#' }
#' @source \url{https://data.world/cow/bilateral-trade}
#'
#' @examples
#' data(trade)
#' head(trade)
"trade"
