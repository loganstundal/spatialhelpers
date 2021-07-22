#' w_sim
#'
#' Simulate a symmetric binary spatial weights matrix
#'
#' @param n The number of observations to include
#' @param cutoff A threshold above which observations are no longer considered
#' neighbors. Observations are sampled in a (-1, 1) grid space. The default
#' cutoff is a distance of 0.2
#'
#' @return A simulated symmetric spatial weights matrix based on sampled
#' observations from a unit-grid.
#' @export
#'
#' @importFrom stats runif model.frame na.action runif dist
#'
#' @examples
#' w_sim(20)


w_sim <- function(n, cutoff = 0.2){
  cords <- cbind(x = runif(n, -1, 1),
                 y = runif(n, -1, 1))
  w <- as.matrix(dist(cords))
  w[w <= cutoff] <- 1
  w[w != 1.0]    <- 0

  diag(w) <- 0

  return(w)
}
