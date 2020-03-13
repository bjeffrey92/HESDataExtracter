library(haven)


#' Load Data from stata .dta file 
#'
#' @description imports data and stores in a tibble
#' @param dtaFile path to dtaFile (str)
#' @param cols vector of column names to keep in addition to diag_x columns, if NULL returns all columns
#' @export
loadFromDta <- function(dtaFile, cols = NULL){
    data <- haven::read_dta(dtaFile)
    if (!is.null(cols)){
        outData <- data[cols]
        outData <- cbind(outData, 
                    data[,grepl('diag_', names(data))]) #adds diagnosis columns

    }
    return(data)
}


#' Load Data from delimited text file 
#'
#' @description imports data and stores in a tibble
#' @param csv path to pattern delimited textFile (str)
#' @param cols vector of column names to keep in addition to diag_x columns, if NULL returns all columns
#' @param sep seperator between field (str)
#' @export
loadFromCsv <- function(csvFile, cols = NULL, sep = ','){
    data <- read.csv(csvFile, sep = sep)
    if (!is.null(cols)){
        data <- data[cols]
        outData <- cbind(outData, 
                    data[,grepl('diag_', names(data))]) #adds diagnosis columns
    }
    return(data)
}