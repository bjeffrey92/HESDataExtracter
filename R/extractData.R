#' Extract relevant records from dataframe/tibble of APC data
#'
#' @description extracts data and returns as list of dataframes one for each ICD code
#' @param data tibble/dataframe of APC data
#' @param ICDCodes ICD codes to include
#' @export
extractRecords <- function(data, ICDCodes){
    data <- data[data$epistat == 3,] #select all finished episodes
    
    outList <- vector("list", length = length(ICDCodes))
    names(outList) <- ICDCodes
    for (code in ICDCodes){
        outList[[code]] <- df[grep(code, df$allDiagnoses),] #select all rows for that code
    }

    totalRecords <- Reduce('+', lapply(outList, nrow)) #counts total number of records in each item of the list (i.e. records per ICD code)
    if (totalRecords != nrow(data)){
        warning('Some records are recorded under multiple diagnosis codes')
    }

    return(outList)
}

#' 

convertToTimeSeries <- function(data, locations = NULL){

}