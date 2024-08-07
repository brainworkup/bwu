% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/neuropsych_test_scoring.R
\name{pegboard_dominant_hand}
\alias{pegboard_dominant_hand}
\title{Grooved Pegboard, Dominant Hand}
\usage{
pegboard_dominant_hand(age, raw_score)
}
\arguments{
\item{age}{A numeric value of the age of the participant. Must be between 16 and 89 years old.}

\item{raw_score}{A numeric value of the raw score from the Rey Complex Figure, Copy trial.}
}
\value{
Returns a numeric value of the T-score for the Rey Complex Figure, Copy trial.
}
\description{
Calculates a Rey Complex Figure, Copy trial score (T-score) from a raw score and age. The predicted score and standard deviation are also calculated.
}
