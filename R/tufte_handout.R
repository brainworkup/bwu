#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param fig_width PARAM_DESCRIPTION, Default: 4
#' @param fig_height PARAM_DESCRIPTION, Default: 2.5
#' @param fig_crop PARAM_DESCRIPTION, Default: TRUE
#' @param dev PARAM_DESCRIPTION, Default: 'pdf'
#' @param highlight PARAM_DESCRIPTION, Default: 'default'
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @rdname tufte_handout
#' @export
tufte_handout <- function(fig_width = 4, fig_height = 2.5, fig_crop = TRUE, dev = "pdf", highlight = "default", ...) {
  tufte_pdf("tufte-handout", fig_width, fig_height, fig_crop, dev, highlight, ...)
}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param fig_width PARAM_DESCRIPTION, Default: 4
#' @param fig_height PARAM_DESCRIPTION, Default: 2.5
#' @param fig_crop PARAM_DESCRIPTION, Default: TRUE
#' @param dev PARAM_DESCRIPTION, Default: 'pdf'
#' @param highlight PARAM_DESCRIPTION, Default: 'default'
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @rdname tufte_book
#' @export
tufte_book <- function(fig_width = 4, fig_height = 2.5, fig_crop = TRUE, dev = "pdf",
                       highlight = "default", ...) {
  tufte_pdf("tufte-book", fig_width, fig_height, fig_crop, dev, highlight, ...)
}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param documentclass PARAM_DESCRIPTION, Default: c("tufte-handout", "tufte-book")
#' @param fig_width PARAM_DESCRIPTION, Default: 4
#' @param fig_height PARAM_DESCRIPTION, Default: 2.5
#' @param fig_crop PARAM_DESCRIPTION, Default: TRUE
#' @param dev PARAM_DESCRIPTION, Default: 'pdf'
#' @param highlight PARAM_DESCRIPTION, Default: 'default'
#' @param template PARAM_DESCRIPTION, Default: template_resources("tufte_handout", "tufte-handout.tex")
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @rdname tufte_pdf
#' @export
#' @importFrom rmarkdown pdf_document knitr_options_pdf
#' @importFrom knitr knit_engines hook_plot_tex
tufte_pdf <- function(documentclass = c("tufte-handout", "tufte-book"), fig_width = 4, fig_height = 2.5, fig_crop = TRUE, dev = "pdf", highlight = "default", template = template_resources("tufte_handout", "tufte-handout.tex"), ...) {
  # resolve default highlight
  if (identical(highlight, "default")) highlight <- "pygments"

  # call the base pdf_document format with the appropriate options
  format <- rmarkdown::pdf_document(
    fig_width = fig_width, fig_height = fig_height, fig_crop = fig_crop,
    dev = dev, highlight = highlight, template = template, ...
  )

  # LaTeX document class
  documentclass <- match.arg(documentclass)
  format$pandoc$args <- c(
    format$pandoc$args, "--variable", paste0("documentclass:", documentclass),
    if (documentclass == "tufte-book") {
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
  format$inherits <- "pdf_document"
  format
}
