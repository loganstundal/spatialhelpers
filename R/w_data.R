#' w_data
#'
#' Construct a spatial weights matrix using observations in a data frame
#'
#' @description \code{w_data} constructs spatial weights using dyadic
#' data recorded in a data frame. These weights may be symmetric or
#' asymmetric depending on user preference.
#'
#' @param data A data frame containing dyadic flows
#' @param id1 Variable identifying unit 1
#' @param id2 Variable identifying unit 2
#' @param flow1 Flows into unit 1 from unit 2
#' @param flow2 Flows into unit 2 from unit 1
#' @param flow Total flows between dyads. This will override \code{flow1} and
#' \code{flow2} if supplied and return a symmetric matrix
#' @param missing_list For instances where the data contains dyads with no
#' reported flows, the returned weights matrix will contain NAs. Setting this
#' argument to TRUE returns a list of these observations
#' @param quitetly Suppress warning messages
#'
#' @return A matrix consisting of weights derived from data
#' @export
#'
#' @importFrom dplyr rename bind_rows arrange select %>%
#' @importFrom rlang .data
#' @importFrom tidyr pivot_wider
#'
#' @examples
#' data(trade)
#' head(trade)
#' # Construct a symmetric dyadic matrix
#' w_symmetric <- w_data(data = trade, id1 = importer1, id2 = importer2,
#'                       flow = total_trade)
#'
#' # Recode missing values to 0 if these correspond to cases with no flows:
#' w_symmetric[is.na(w_symmetric)] <- 0
#'
#' # Verify symmetry:
#' isSymmetric(w_symmetric)
#' w_symmetric["Canada", "Mexico"]
#' w_symmetric["Mexico", "Canada"]
#'
#' # Return list of dyads with no flows to explore whether these are missing data
#' w_missing <- w_data(data = trade, id1 = importer1, id2 = importer2,
#'                     flow = total_trade, missing_list = TRUE)
#'
#' w_missing$France # Dyads not reporting trade with France
#'
#'
#' # Construct an asymmetric dyadic matrix
#' head(trade)
#' w_asymmetric <- w_data(data  = trade, id1 = importer1, id2 = importer2,
#'                        flow1 = flow1, flow2 = flow2)
#'
#' # Verify asymmetric
#' isSymmetric(w_asymmetric)
#'
#' w_asymmetric["Canada", "Mexico"] # Imports of Canada from Mexico in current US millions $
#' w_asymmetric["Mexico", "Canada"] # Imports of Mexico from Canada in current US millions $

w_data <- function(data, id1, id2, flow1, flow2, flow,
                   missing_list = FALSE, quitetly = FALSE){

  id1   <- rlang::ensym(id1)
  id2   <- rlang::ensym(id2)
  flow1 <- rlang::ensym(flow1)
  flow2 <- rlang::ensym(flow2)
  flow  <- rlang::ensym(flow)

  a <- b <- ida <- idb <- val <- NULL

  if(!missing(flow)){
    data  <- data %>% rename(a = !!id1, b = !!id2, flow = !!flow) %>%
      select(a,b,flow)
    data2 <- data %>% rename(b=a, a=b)
    data  <- bind_rows(data,data2)

    data  <- data %>%
      pivot_wider(.data, id_cols = a, names_from = b, values_from = flow) %>%
      arrange(a)

    data <- data %>%
      select(order(colnames(data)))

    data <- as.data.frame(data)
    rownames(data) <- data$a
    data$a <- NULL
    data <- as.matrix(data)

    diag(data) <- 0
  } else{
    data <- data %>%
      rename(a = 1, b = 2) %>%
      mutate(ida = paste0(a,b),
             idb = paste0(b,a))

    data1 <- data %>%
      select(ida, flow1, a, b) %>%
      rename(id = 1, val = 2)

    data2 <- data %>%
      select(idb, flow2, a, b) %>%
      rename(id = 1, val = 2, a = b, b = a)

    data <- bind_rows(data1, data2) %>% arrange(a, b) %>%
      pivot_wider(.data,
                  id_cols     = a,
                  names_from  = b,
                  values_from = val) %>%
      select(-a)

    data <- data %>%
      select(order(colnames(data)))

    data           <- as.matrix(data)
    rownames(data) <- colnames(data)
  }

  if(table(is.na(data))["TRUE"]>0 & !missing_list){
    x <- "

There are missing values in your matrix. These may correspond to
observations in your data with no dyadic flows in which case you can
recode these values to 0 using:

      my_matrix[is.na(my_matrix)] <- 0

Otherwise, you can rerun this command with argument `missing_list = TRUE`
to return a list of dyads with NA values."
    warning(x)
  } else if(missing_list){
    data <- apply(data, 1, function(x){names(x[is.na(x)])})
  }
  return(data)
}

