library(haven)


#' Load Data from stata .dta file 
#'
#' @description imports data and stores in a tibble
#' @param dtaFile path to dtaFile (str)
#' @export
loadFromDta <- function(dtaFile){
    data <- haven::read_dta(dtaFile)
    return(data)
}

#' Load Data from delimited text file 
#'
#' @description imports data and stores in a tibble
#' @param csv path to pattern delimited textFile (str)
#' @param sep seperator between field (str)
#' @export
loadFromCsv <- function(csvFile, sep = ','){
    data <- read.csv(csvFile, sep = sep)
    return(data)
}