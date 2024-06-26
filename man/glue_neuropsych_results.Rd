% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/text.R
\name{glue_neuropsych_results}
\alias{glue_neuropsych_results}
\title{Extract and glue neuropsych text}
\usage{
glue_neuropsych_results(df, filter, result, file)
}
\arguments{
\item{df}{A dataframe from which data is to be filtered and concatenated.}

\item{filter}{A character vector or list specifying the filter condition for the 'scale' column of the dataframe.}

\item{result}{This parameter appears to be unused and can potentially be removed.}

\item{file}{A character string specifying the path to the output file where the concatenated text will be saved, default is '_raw_text.qmd'.}
}
\value{
The name of the file to which the result was written, useful for passing the file to other functions.
}
\description{
This function filters a dataframe based on a specified condition, concatenates all of the columns into a single string, and writes the result to a file.
}
\details{
This function uses dplyr for data manipulation, glue for data concatenation, and purrr for functional programming.
}
