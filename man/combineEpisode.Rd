% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/extractData.R
\name{combineEpisode}
\alias{combineEpisode}
\title{Get CIPS from episodes}
\usage{
combineEpisode(
  data,
  idCol = "encrypted_hesid",
  startCol = "admidate",
  endCol = "disdate"
)
}
\description{
combines episodes from each patient to get CIPS
}
