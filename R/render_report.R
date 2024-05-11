#' @title Render REport
#' @description Not sure
#' @param input Input.
#' @param patient Patient name.
#' @param output_format adult or child.
#' @param params Parameters or "ask".
#' @param ... Patient name, etc.
#' @return RMarkdown report
#' @seealso
#'  [render][rmarkdown::render]
#'  [pdf_document2][bookdown::pdf_document2]
#' @rdname render_report
#' @export
#' @importFrom rmarkdown render
#' @importFrom bookdown pdf_document2
render_report <- function(patient = "Biggie", input, output_format = NULL, params = NULL, ...) {
  report_pdf <- rmarkdown::render(
    input = "input",
    output_format = "output_format",
    params = "params"
  )

  bookdown::pdf_document2(
    report_pdf,
    paste0("npsych-report", "_", patient, "_", Sys.Date(), ".pdf")
  )
}
