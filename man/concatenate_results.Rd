% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/text.R
\name{concatenate_results}
\alias{concatenate_results}
\title{Concatenate Results}
\usage{
concatenate_results(df)
}
\arguments{
\item{df}{A data frame containing the patient's scores and related information.}
}
\value{
A character vector containing the concatenated summary strings.
}
\description{
This function takes a data frame as input and adds a summary column to it. The summary column contains a concatenated string that describes the patient's score, range, percentile, and classification.
}
\examples{
df <- data.frame(
  scale = c("IQ", "Memory"),
  score = c(100, 80),
  range = c("Above Average", "Below Average"),
  percentile = c(75, 25),
  ci_95 = c("[95, 105]", "[75, 85]"),
  description = c("intelligence", "memory")
)
concatenate_results(df)

}
