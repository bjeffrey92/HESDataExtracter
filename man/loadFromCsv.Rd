% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/loadData.R
\name{loadFromCsv}
\alias{loadFromCsv}
\title{Load Data from delimited text file}
\usage{
loadFromCsv(csvFile, cols = NULL, sep = ",")
}
\arguments{
\item{cols}{vector of column names to keep in addition to diag_x columns, if NULL returns all columns}

\item{sep}{seperator between field (str)}

\item{csv}{path to pattern delimited textFile (str)}
}
\description{
imports data and stores in a tibble
}
