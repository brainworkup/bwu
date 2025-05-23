% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plots.R
\name{pass}
\alias{pass}
\title{Drilldown on Neuropsych PASS
This function uses the R Highcharter package and drilldown function to
"drilldown" on neuropsychological domains and test scores. \code{drilldown}
Creates a highcharter drilldown interactive plot.}
\usage{
pass(
  data,
  patient,
  neuro_domain = c("Neuropsychological Test Scores", "Behavioral Rating Scales",
    "Effort/Validity Test Scores"),
  theme
)
}
\arguments{
\item{data}{Dataset to use.}

\item{patient}{Name of patient.}

\item{neuro_domain}{Name of neuropsych domain to add to HC series.}

\item{theme}{The highcharter theme to use.}
}
\value{
A drilldown plot
}
\description{
Drilldown on Neuropsych PASS
This function uses the R Highcharter package and drilldown function to
"drilldown" on neuropsychological domains and test scores. \code{drilldown}
Creates a highcharter drilldown interactive plot.
}
