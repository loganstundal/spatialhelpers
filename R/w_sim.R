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


w_sim <- function(n, proportion_one = NULL){
  cords <- cbind(x = runif(n, -1, 1),
                 y = runif(n, -1, 1))
  w <- as.matrix(dist(cords))

  if(is.null(proportion_one)){
    cutoff <- quantile(w, probs = 0.1)
  } else{
    cutoff <- quantile(w, probs = proportion_one)
  }

  w[w <= cutoff] <- 1
  w[w != 1.0]    <- 0

  diag(w) <- 0

  return(w)
}

# Note - does not exactly equal "proportion_one" due to zeros on main diagonal.
# table(w_sim(100, proportion_one = 0.9))
