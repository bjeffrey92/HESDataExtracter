library(haven)
library(stringr)

#' Load Data from stata .dta file 
#'
#' @description imports data and stores in a tibble
#' @param dtaFile path to dtaFile (str)
#' @param cols vector of column names to keep in addition to diag_x columns, if NULL returns all columns
#' @export
loadFromDta <- function(dtaFile, cols = NULL){
    print('Reading in APC data, this may take a while')
    
    data <- haven::read_dta(dtaFile)
    
    validateFile(data)

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
    
    validateFile(data)

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

#' Validate File
#'
#' @description checks that file is in appropriate format for analysis with rest of functions in package
#' @param data APC data loaded from file
#' @param date.format format the dates must be in
#' @param dateCols vector of column names that should incude only dates in format of date.format
#' @param patterns vector of patterns that match other columns which are to be extracted
#' @export
validateFile <- function(data, date.format = '%y/%m/%d',
                        dateCols = c('admidate', 'disdate'),
                        patterns = c('diag_')){

    #check date columns are in the correct format
    #throw error if not
    for (col in dateCols){
        data[[col]] <- str_replace_all(data[[col]], '-', '/')
        count <- 0
        for (i in is.na(as.Date(data[[col]], date.format))){
            if (i == FALSE){
                count <- count + 1
            }
        }
        if (count > 0){
            stop(paste0(as.character(count), ' records in column ', col, ' are in incorrect format'))
        }
    }

    #how many columns include pattern
    for (pattern in patterns){
        count <- sum(grepl(pattern, names(data)), na.rm = TRUE)
        if (count == 0){
            stop(paste0('No columns matching pattern: ', pattern))
        }
    }
}