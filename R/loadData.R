library(haven)


#' Load Data from stata .dta file 
#'
#' @description imports data and stores in a tibble
#' @param dtaFile path to dtaFile (str)
#' @param cols vector of column names to keep in addition to diag_x columns, if NULL returns all columns
#' @export
loadFromDta <- function(dtaFile, cols = NULL){
    print('Reading in APC data, this may take a while')
    
    data <- haven::read_dta(dtaFile)
    
    print('Filtering columns')
    cols <- c('startage','encrypted_hesid','admidate','disdate',
            'epistat','procode','procode3','soal') #relevant columns in APC data to extract
    df <- data[cols]
    diagCols <- data[,grepl('diag_', names(data))] #gets diagnosis columns
    df$allDiagnoses <- apply(diagCols[ ,names(diagCols)],
                            1,paste,collapse = "-") #pastes all diagnoses to one column so it can be efficiently searched
    df <- df[,names(df) %in% c(cols, "allDiagnoses")] #drop unnesecary columns
        
    return(df)
}


#' Load Data from delimited text file 
#'
#' @description imports data and stores in a tibble
#' @param csv path to pattern delimited textFile (str)
#' @param cols vector of column names to keep in addition to diag_x columns, if NULL returns all columns
#' @param sep seperator between field (str)
#' @export
loadFromCsv <- function(csvFile, cols = NULL, sep = ','){
    print('Reading in APC data, this may take a while')
    
    data <- read.csv(csvFile, sep = sep, 
                    stringsAsFactors = FALSE)
    
    print('Filtering columns')
    cols <- c('startage','encrypted_hesid','admidate','disdate',
            'epistat','procode','procode3','soal') #relevant columns in APC data to extract
    df <- data[cols]
    diagCols <- data[,grepl('diag_', names(data))] #gets diagnosis columns
    df$allDiagnoses <- apply(diagCols[ ,names(diagCols)],
                            1,paste,collapse = "-") #pastes all diagnoses to one column so it can be efficiently searched
    df <- df[,names(df) %in% c(cols, "allDiagnoses")] #drop unnesecary columns
    
    return(df)
}