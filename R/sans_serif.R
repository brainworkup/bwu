#' @details \code{sans_serif()} applies sans-serif fonts to \code{text}.
#' @rdname tufte_handout
#' @export
sans_serif = function(text) {
  if (is_html_output()) {
    sprintf('<span class="sans">%s</span>', text)
  } else if (is_latex_output()) {
    sprintf('\\textsf{%s}', text)
  } else {
    warning('sans_serif() only works for HTML and LaTeX output', call. = FALSE)
    text
  }
}

template_resources = function(name, ...) {
  system.file('rmarkdown', 'templates', name, 'resources', ..., package = 'tufte')
}

gsub_fixed = function(...) gsub(..., fixed = TRUE)

pandoc2.0 = function() rmarkdown::pandoc_available('2.0')
