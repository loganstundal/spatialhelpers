#' w_report
#'
#' Report neighbors for an index in a spatial weights matrix
#'
#' @param id Index identifier for unit to report neighbors
#' @param w A spatial weights index
#' @param value Whether to report weight value, default is False
#'
#' @return A vector of neighbor names or recorded neighbor values
#' @export
#'
#' @examples
#' data(us)
#' w <- w_borders(data = us, id = name)
#' w_report(id = "Minnesota", w = w, value = TRUE)

w_report <- function(id, w, value = FALSE){
  if(value){
    neighbors <- w[id,][w[id,]>0]
  } else{
    neighbors <- rownames(subset(w,w[, id]!=0))
  }
  return(neighbors)
}
