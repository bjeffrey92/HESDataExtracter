library(HESDataExtracter)

#########
#GLOBALS#
#########
inputFile <- '../../old_data_from_Krystal/APC_2008.dta'
codes <- c('J09','J10','J11','J12',
            'J20','J21','J22') #ICD codes to be extracted
ageBrackets <- list(c(0,4), c(5,14), 
                    c(15,24), c(25,44),
                    c(45,64),c(65,Inf)) #age brackets are inclusive, these are same as those used by Dorigatti et al
#########

data <- loadFromDta(inputFile) #functions also exist to load from csv

dataPerCode <- extractRecords(data, ICDCodes = codes) #extracts relevant records for each ICD code
#to combine data of different codes use rbind()

#split by age bracket
timeSeriesPerCode <- vector('list', length(dataPerCode))
names(timeSeriesPerCode) <- names(dataPerCode)
for (code in names(dataPerCode)){
    df <- dataPerCode[[code]]    
    timeSeriesPerCode[[code]] <- getAdmissionsTimeSeries(df, 
                                                    ageBrackets) #get time series of weekly admissions per ICD code
}

