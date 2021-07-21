#' Tidy a pre-specified spatial weights matrix
#'
#' @description  This function tidies a pre-specified spatial weights matrix. Using a unique ID
#' from a data frame as well as a model formula, this function subsets an existing W-matrix
#' by dropping rows and columns which correspond to missing values in the data.
#'
#' @param formula A model formula to identify appropriate observations for subsetting
#' @param data A data frame containing variables to be used in a spatial model
#' @param panel_id A unique ID variable that correpsonds to row and column names in W
#' @param w A spatial weights matrix containing observations that
#' correspond to data rows with missing values
#'
#' @return A subset w which has dropped rows and columns that have missing values on variables
#' in the supplied formula.
#' @export
#'
#' @examples
#' n   <- 20
#'
#' dat <- data.frame(obs_id = 1:n, x1 = rnorm(n))
#' dat$x1[sample(1:20, size = 3)] <- NA
#'
#' w   <- gen_w(n)
#' rownames(w) <- colnames(w) <- dat$obs_id
#'
#' w2 <- tidy_w(formula = ~x1,
#'              data    = dat,
#'              id      = "obs_id",
#'              w       = w)

tidy_w <- function(formula, data, id, w){
  dat     <- model.frame(formula, data)
  bad_idx <- as.numeric(na.action(dat))
  bad_ids <- data[[id]][bad_idx]
  w_sub <- w[
    !rownames(w) %in% bad_ids,
    !colnames(w) %in% bad_ids
  ]
  return(w_sub)
}
