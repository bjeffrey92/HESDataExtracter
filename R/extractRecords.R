#' Extract relevant data from dataframe/tibble of APC data
#'
#' @description extracts data and returns as a dataframe
#' @param data tibble/dataframe of APC data
#' @param ICDCodes ICD codes to include
#' @export
extractData <- function(data, ICDCodes){
    data <- data[data$epistat == 3,] #select all finished episodes
    
}