#' Render neuropsychological reports with rmarkdown and bookdown child
#'
#' \code{render_report_child} creates an neuropsych report.
#'
#' This is a generic function: methods can be defined for it directly or via the
#' \code{\link{Summary}} group generic. For this to work properly, the arguments
#' \code{...} should be unnamed, and dispatch is on the first argument.
#'
#' @section Warning:
#' Do not operate heavy machinery within 8 hours of using this function.
#'
#' @param input Rmd index file to use per patient.
#' @param patient Name of patient quoted.
#' @param ... Numeric, complex, or logical vectors.
#' @return A report for the \code{patient} who has this index \code{input}.
#' @import rmarkdown bookdown
#' @author Joey W Trampush, \email{trampush@usc.edu}
#'
#'
#' @export
render_report_child <- function(input, patient, ...) {

  output <- rmarkdown::render(
    input = input,
    output_format = "bwu::neuropsych_report_child",
    params = "ask")

  bookdown::pdf_document2(
    output,
    paste0("npsych-report", "_", patient, "_", Sys.Date(), ".pdf"))

}
