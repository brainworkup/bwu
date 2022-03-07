#' @details \code{newthought()} can be used in inline R expressions in R
#'   Markdown (e.g. \samp{`r newthought('Some text')`}), and it works for both
#'   HTML (\samp{<span class="newthought">text</span>}) and PDF
#'   (\samp{\\newthought{text}}) output.
#' @param text A character string to be presented as a \dQuote{new thought}
#'   (using small caps), or a margin note, or a footer of a quote
#' @rdname tufte_handout
#' @export
#' @examples newthought('In this section')
newthought = function(text) {
  if (is_html_output()) {
    sprintf('<span class="newthought">%s</span>', text)
  } else if (is_latex_output()) {
    sprintf('\\newthought{%s}', text)
  } else {
    sprintf('<span style="font-variant:small-caps;">%s</span>', text)
  }
}

template_resources = function(name, ...) {
  system.file('rmarkdown', 'templates', name, 'resources', ..., package = 'tufte')
}

gsub_fixed = function(...)
  gsub(..., fixed = TRUE)

pandoc2.0 = function()
  rmarkdown::pandoc_available('2.0')
