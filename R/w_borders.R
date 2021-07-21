

#' Compute distance based spatial weights
#'
#' @param data Spatial data of class sf
#' @param id A variable in the data uniquely identifying observations
#'
#' @return
#' @export
#'
#' @importFrom rlang ensym
#' @importFrom dplyr %>%
#'
#' @examples
#' data(us)
#' w <- w_borders(data = us, id = name)

w_borders <- function(data, id){

  if(!"sf" %in% class(data)){
    stop("This function requires sf class spatial data")
  }

  if(!any(c("MULTIPOLYGON", "POLYGON") %in% unique(st_geometry_type(data)))){
    stop("Computing border length requires polygon spatial data")
  }

  id    <- rlang::ensym(id)
  touch <- suppressMessages(st_touches(data))
  res   <- data.frame()
  done  <- c()

  for(x in 1:length(touch)){

    nbs <- touch[[x]]
    nbs <- nbs[!nbs %in% done]

    if(length(nbs) == 0){next}

    tmp <- suppressWarnings({
      suppressMessages({st_intersection(x = data[x,],
                                        y = data[nbs,])})
    })

    done <- c(done, x)

    tmp <- tmp %>%
      select(!!id, !!paste0(id, ".1")) %>%
      rename(id_row = !!id,
             id_col = !!paste0(id, ".1")) %>%
      mutate(border_dist = as.numeric(st_length(.)) / 1e3) %>%
      st_drop_geometry() %>%
      tibble::remove_rownames()

    res <- bind_rows(res, tmp)
  }

  uid <- unique(c(res$id_row, res$id_col))

  dm <- sapply(uid, function(row){
    sapply(uid, function(col){
      res[res$id_row %in% c(row, col) &
            res$id_col %in% c(row, col), "border_dist"][1]
    })
  })

  diag(dm)      <- 0
  dm[is.na(dm)] <- 0

  return(dm)
}

