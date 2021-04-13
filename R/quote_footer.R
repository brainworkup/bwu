#' @details \code{quote_footer()} formats text as the footer of a quote. It puts
#'   \code{text} in \samp{<footer></footer>} for HTML output, and
#'   after \samp{\\hfill} for LaTeX output (to right-align text).
#' @rdname tufte_handout
#' @export
quote_footer = function(text) {
  if (is_html_output()) {
    sprintf('<footer>%s</footer>', text)
  } else if (is_latex_output()) {
    sprintf('\\hfill %s', text)
  } else {
    warning('quote_footer() only works for HTML and LaTeX output', call. = FALSE)
    text
  }
}

template_resources = function(name, ...) {
  system.file('rmarkdown', 'templates', name, 'resources', ..., package = 'tufte')
}

gsub_fixed = function(...) gsub(..., fixed = TRUE)

pandoc2.0 = function() rmarkdown::pandoc_available('2.0')
