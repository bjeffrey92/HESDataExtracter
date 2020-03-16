#' auxillary function for getAdmissionsTimeSeries()
splitByAge <- function(data, ageBrackets, ageCol){

    data <- data[!is.na(data[[ageCol]]), ] 
    data[data[[ageCol]] >= 7000,][[ageCol]] <- 0 #greater than 7000 means less than 0, see data dictionary

    if (is.data.frame(data)){
        outList <- vector('list', length = length(ageBrackets))
        names(outList) <- lapply(ageBrackets, paste, collapse = '-')
        for (i in ageBrackets){
            l <- i[[1]]
            u <- i[[2]]
            name <- paste(i, collapse = '-')
            outList[[name]] <- data[which(data[[ageCol]] >= l & 
                                data[[ageCol]] <= u),]
        }
   
    }
    return(outList)
}

#' auxillary function for getAdmissionsTimeSeries()
splitByLocation <- function(data, locCol){
    
    data <- data[!is.na(data[[locCol]]), ] 

    outList <- vector('list', 
                    length = length(unique(data[[locCol]])))
    names(outList) <- unique(data[[locCol]])
    for (loc in unique(data[[locCol]])){
        outList[[loc]] <- data[data[locCol] == loc,]
    }
    return(outList)
}


#' Converts data frames to time series of admissions
#' 
#' @description extracts time series of admission by age brackets 
#' @param data dataframe of APC data
#' @param ageBrackets list of vectors where first item is lower age and second is upper age of age bracket, age brackets will be treated assuming they are inclusive.
#'                    If Null data won't be split by age
#' @param ageCol Field in data in which age is stored, must be supplied with ageBrackets
#' @param locations Field in data to treat as locations to be split by. If Null data won't be split by location
#' @export
getAdmissionsTimeSeries <- function(data, ageBrackets = NULL, 
                                    ageCol = 'startage', locations = NULL,
                                    admittedDateCol = 'admidate'){
    
    if (is.null(locations) & is.null(ageBrackets)){
        allDfs <- list(data)
    }
    else if (is.null(locations) & !is.null(ageBrackets)){
        allDfs <- splitByAge(data, ageBrackets, ageCol)
    }
    else if (!is.null(locations) & is.null(ageBrackets)){
        allDfs <- splitByLocation(data, locations)
    }
    else {
        ageDfs <- splitByAge(data, ageBrackets, ageCol)
        allDfs <- list()
        for (ageName in names(ageDfs)){
            locDfs <- splitByLocation(ageDfs[[ageName]], locations)
            for (locName in names(locDfs)){
                name <- paste(locName, ageName, sep = '_')
                allDfs[[name]] <- locDfs[[locName]] #appending data filtered by location and age bracket
            }
        }
    }

    referenceDate <- "2000-01-01" #will record in weeks starting at this point
    print(paste0('Times are recorded in whole weeks since ',referenceDate))
    outList <- vector('list', length = length(allDfs))
    names(outList) <- names(allDfs)
    for (name in names(allDfs)){
        df <- allDfs[[name]]
        df$weeksSinceRef <- as.integer(difftime(
                                        as.POSIXct(df[[admittedDateCol]]), 
                                        as.POSIXct(referenceDate), 
                                        units = 'weeks')) #calculates number of whole weeks since reference date
        countsTable <- table(df$weeksSinceRef)
        counts <- c()
        for (i in names(countsTable)){
            counts <- c(countsTable[[i]], counts)
        }
        startWeek <- as.integer(difftime(
                                        min(as.POSIXct(df[[admittedDateCol]])), 
                                        as.POSIXct(referenceDate), 
                                        units = 'weeks')) #calculates number of whole weeks since reference date
        countsTS <- ts(counts, startWeek)
        outList[[name]] <- countsTS
    }
    return(outList)
}