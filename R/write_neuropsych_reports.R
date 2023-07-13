#' BWU Neuropsych Report Adult Version
#' @param fig_width Numeric giving width of each figure; default \code{fig_width = 4}
#' @param fig_height Numeric giving height of each figure; default \code{fig_height = 2.5}
#' @param fig_crop Logical determining whether figures will be cropped; default \code{fig_crop = TRUE}
#' @param dev Device used, e.g.,"png", "pdf"; default \code{dev = "pdf"}
#' @param highlight Formatting of code chunks; default \code{"default"}
#' @param ... Other arguments to be passed to [pdf_document2()] or [html_document()] (note you cannot use the `template` argument in `tufte_handout` or the `theme` argument in `tufte_html()`; these arguments have been set internally)
#' @return No formal returns, outputs neuropsychological report documents
#' @seealso \code{\link[bookdown]{pdf_document2}}
#' @references See <https://rstudio.github.io/tufte/> for an example.
#' @export
adult_report <- function(fig_width = 4, fig_height = 2.5, fig_crop = TRUE, dev = "pdf", highlight = "default", ...) {
  neuropsych_report("adult-report", fig_width, fig_height, fig_crop, dev, highlight, ...)
}

#' BWU Neuropsych Report Child Version
#' @description Need to write
#' @param fig_width Numeric giving width of each figure; default \code{fig_width = 4}
#' @param fig_height Numeric giving height of each figure; default \code{fig_height = 2.5}
#' @param fig_crop Logical determining whether figures will be cropped; default \code{fig_crop = TRUE}
#' @param dev Device used, e.g.,"png", "pdf"; default \code{dev = "pdf"}
#' @param highlight Formatting of code chunks; default \code{"default"}
#' @param ... Other arguments to be passed to [pdf_document2()] or [html_document()] (note you cannot use the `template` argument in `tufte_handout` or the `theme` argument in `tufte_html()`; these arguments have been set internally)
#' @return No formal returns, outputs neuropsychological report documents
#' @seealso \code{\link[bookdown]{pdf_document2}}
#' @references See <https://rstudio.github.io/tufte/> for an example.
#' @export
child_report <- function(fig_width = 4, fig_height = 2.5, fig_crop = TRUE, dev = "pdf", highlight = "default", ...) {
  neuropsych_report("child-report", fig_width, fig_height, fig_crop, dev, highlight, ...)
}


#' Main Report
#'
#' Create a neuropsychological report in pdf format.
#'
#' @param documentclass Specify either "adult-report" or "child-report" as the document class.
#'                      Defaults to "adult-report".
#' @param fig_width The width of figures. Defaults to 4 in.
#' @param fig_height The height of figures. Defaults to 2.5in.
#' @param fig_crop Whether to crop figures with extra white space. Defaults to `TRUE`.
#' @param dev The graphical device used to create plots. Defaults to "pdf".
#' @param highlight Syntax highlighting method for code chunks. Defaults to "pygments".
#' @param template Name of LaTeX template file. Defaults to "neuro-report.tex".
#' @param ... Other arguments passed down to \code{\link{bookdown::pdf_document2}}.
#' @export
#' @rdname neuropsych_report
neuropsych_report <- function(documentclass = c("adult-report", "child-report"), fig_width = 4, fig_height = 2.5, fig_crop = TRUE, dev = "pdf", highlight = "default", template = template_resources("neuropsych_report", "neuro-report.tex"), ...) {
  # resolve default highlight
  if (identical(highlight, "default")) highlight <- "pygments"
  # call the base pdf_document format with the appropriate options
  format <- bookdown::pdf_document2(
    fig_width = fig_width, fig_height = fig_height, fig_crop = fig_crop,
    dev = dev, highlight = highlight, template = template, ...
  )
  # LaTeX document class
  documentclass <- match.arg(documentclass)
  format$pandoc$args <- c(
    format$pandoc$args, "--variable", paste0("documentclass:", documentclass),
    if (documentclass == "child-report") {
      if (pandoc2.0()) "--top-level-division=chapter" else "--chapters"
    }
  )
  knitr::knit_engines$set(marginfigure = function(options) {
    options$type <- "marginfigure"
    eng_block <- knitr::knit_engines$get("block")
    eng_block(options)
  })

  # create knitr options (ensure opts and hooks are non-null)
  knitr_options <- rmarkdown::knitr_options_pdf(fig_width, fig_height, fig_crop, dev)
  if (is.null(knitr_options$opts_knit)) knitr_options$opts_knit <- list()
  if (is.null(knitr_options$knit_hooks)) knitr_options$knit_hooks <- list()

  # set options
  knitr_options$opts_knit$width <- 45

  # set hooks for special plot output
  knitr_options$knit_hooks$plot <- function(x, options) {
    # determine figure type
    if (isTRUE(options$fig.margin)) {
      options$fig.env <- "marginfigure"
      if (is.null(options$fig.cap)) options$fig.cap <- ""
    } else if (isTRUE(options$fig.fullwidth)) {
      options$fig.env <- "figure*"
      if (is.null(options$fig.cap)) options$fig.cap <- ""
    }
    knitr::hook_plot_tex(x, options)
  }
  # override the knitr settings of the base format and return the format
  format$knitr <- knitr_options
  format$inherits <- "pdf_document2"
  format
}
