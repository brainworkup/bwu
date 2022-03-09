#' Rmarkdown Template for Neuropsych Child Report
#'
#'
#' @inheritParams bookdown::pdf_document2
#' @param ... arguments passed down to [bookdown::pdf_document2()]
#' @param csl bibliography style in the `.csl` format
#' @param colorlinks should cross-references and links be
#'   colored?
#'
#' @return R Markdown output format to pass to [rmarkdown::render()]
#' @export
neuropsych_report_child <- function(...,
                                number_sections = TRUE,
                                md_extensions = c("-autolink_bare_uris"),
                                csl = NULL,
                                colorlinks = TRUE)
{
  pdf_document_format(...,
                      number_sections = number_sections,
                      md_extensions = md_extensions,
                      format = "neuropsych_report_child",
                      template = "style_tufte.tex",
                      csl = NULL,
                      colorlinks = TRUE)
}
