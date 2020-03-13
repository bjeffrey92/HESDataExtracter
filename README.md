# HESDataExtracter
R package to extract relevant time series of ILI from retrospective HES Data

## Contents
Package contains functions for:<br/>
              1.Loading HES data and extracting the relevant fields.<br/>
              2.Filtering data by ICD code.<br/>
              3.Creating time series of weekly hospital admissions, which can optionally be organised by user-specified age bracket and/or hospital trust.
              
Still to incorporate:<br/>
              Functions for creating weekly time series of other outcomes (deaths, pneumonia, ventilation).
              
              
## Installation 
```R
devtools::install_github(https://github.com/bjeffrey92/HESDataExtracter)
```
