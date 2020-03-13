library(HESDataExtracter)

#########
#GLOBALS#
#########
inputFile <- '../../old_data_from_Krystal/APC_2008.dta'
codes <- c('J09','J10','J11','J12',
            'J20','J21','J22') #ICD codes to be extracted
cols <- c('startage','encrypted_hesid','admidate','disdate',
            'epistat','procode','procode3','soal') #relevant columns in APC data to extract

data <- loadFromDta(inputFile, cols)
extractRecords(data, ICDCodes = codes)