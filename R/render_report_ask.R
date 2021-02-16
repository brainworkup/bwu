#' Render neuropsychological reports with rmarkdown and pagedown
#'
#' \code{render_report_ask} creates an npsych report.
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
#' 
#' @author Joey W Trampush, \email{trampush@usc.edu}
#'
#'
#' @export
render_report_ask <- function(input, patient, ...) {
  
  output <- rmarkdown::render(
    input = input,
    output_format = "pagedown::book_crc",
    params = "ask")

  pagedown::chrome_print(
    output,
    paste0("npsych-report", "_", patient, "_", Sys.Date(), ".pdf"))

}
