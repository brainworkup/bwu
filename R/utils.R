#' Pipe operator
#'
#' See \code{magrittr::\link[magrittr:pipe]{\%>\%}} for details.
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
#' @param lhs A value or the magrittr placeholder.
#' @param rhs A function call using the magrittr semantics.
#' @return The result of calling `rhs(lhs)`.
NULL

# These functions are (mostly) verbatim copies of functions from
# the rticles package, which is copyrighted to RStudio and licensed under
# GPL-3.
# Directly borrowed/stole from komadown package

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param template PARAM_DESCRIPTION
#' @param file PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @rdname find_file
#' @export
find_file <- function(template, file) {
  template <- system.file("rmarkdown",
                          "templates",
                          template,
                          file,
                          package = "bwu"
  )
  if (template == "") {
    stop("Couldn't find template file ", template, "/", file, call. = FALSE)
  }
  template
}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param template PARAM_DESCRIPTION
#' @param file PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @rdname find_resource
#' @export
find_resource <- function(template, file) {
  find_file(template, file.path("resources", file))
}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @seealso
#'  \code{\link[bookdown]{html_document2}}
#' @rdname inherit_pdf_document
#' @export
#' @importFrom bookdown pdf_document2
inherit_pdf_document <- function(...) {
  fmt <- bookdown::pdf_document2(...)
  fmt$inherits <- "pdf_document"
  fmt
}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @param format PARAM_DESCRIPTION
#' @param template PARAM_DESCRIPTION
#' @param csl PARAM_DESCRIPTION, Default: NULL
#' @param colorlinks PARAM_DESCRIPTION, Default: TRUE
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @seealso
#'  \code{\link[rmarkdown]{pandoc_path_arg}}
#' @rdname pdf_document_format
#' @export
#' @importFrom rmarkdown pandoc_path_arg
pdf_document_format <- function(...,
                                format,
                                template,
                                csl = NULL,
                                colorlinks = TRUE) {
  # base format
  fmt <- inherit_pdf_document(...,
                              template = find_resource(format, template)
  )

  # add csl to pandoc_args
  if (!is.null(csl)) {
    fmt$pandoc$args <- c(
      fmt$pandoc$args,
      "--csl",
      rmarkdown::pandoc_path_arg(csl)
    )
  }

  if (isTRUE(colorlinks)) {
    fmt$pandoc$args <- c(fmt$pandoc$args, "--variable", "colorlinks=yes")
  }

  # # use pandoc-citeproc-preamble to add stuff before bibliography
  # fmt$pandoc$args <- c(
  #   fmt$pandoc$args,
  #   "--filter pandoc-citeproc-preamble -M citeproc-preamble=",
  #   rmarkdown::pandoc_path_arg("citeproc-preamble.tex")
  # )
  # # return format
  fmt
}

### These copied from tufte package
### These copied from tufte package
### These copied from tufte package
### These copied from tufte package

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param text PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @rdname newthought
#' @export
newthought <- function(text) {
  if (is_html_output()) {
    sprintf('<span class="newthought">%s</span>', text)
  } else if (is_latex_output()) {
    sprintf("\\newthought{%s}", text)
  } else {
    sprintf('<span style="font-variant:small-caps;">%s</span>', text)
  }
}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param text PARAM_DESCRIPTION
#' @param icon PARAM_DESCRIPTION, Default: '&#8853;'
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @rdname margin_note
#' @export
margin_note <- function(text, icon = "&#8853;") {
  if (is_html_output()) {
    marginnote_html(sprintf('<span class="marginnote">%s</span>', text), icon)
  } else if (is_latex_output()) {
    sprintf("\\marginnote{%s}", text)
  } else {
    warning("marginnote() only works for HTML and LaTeX output", call. = FALSE)
    text
  }
}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param text PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @rdname quote_footer
#' @export
quote_footer <- function(text) {
  if (is_html_output()) {
    sprintf("<footer>%s</footer>", text)
  } else if (is_latex_output()) {
    sprintf("\\hfill %s", text)
  } else {
    warning("quote_footer() only works for HTML and LaTeX output", call. = FALSE)
    text
  }
}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param text PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @rdname sans_serif
#' @export
sans_serif <- function(text) {
  if (is_html_output()) {
    sprintf('<span class="sans">%s</span>', text)
  } else if (is_latex_output()) {
    sprintf("\\textsf{%s}", text)
  } else {
    warning("sans_serif() only works for HTML and LaTeX output", call. = FALSE)
    text
  }
}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param name PARAM_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @rdname template_resources
#' @export
template_resources <- function(name, ...) {
  system.file("rmarkdown", "templates", name, "resources", ..., package = "bwu") # was tufte
}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @rdname gsub_fixed
#' @export
gsub_fixed <- function(...) gsub(..., fixed = TRUE)

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION

#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @seealso
#'  \code{\link[rmarkdown]{pandoc_available}}
#' @rdname pandoc2.0
#' @export
#' @importFrom rmarkdown pandoc_available
pandoc2.0 <- function() rmarkdown::pandoc_available("2.0")


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION

#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @seealso
#'  \code{\link[sinew]{makeOxyFile}}
#'  \code{\link[here]{here}}
#' @rdname sinewOxy
#' @export
#' @importFrom sinew makeOxyFile
#' @importFrom here here
sinewOxy <- function() sinew::makeOxyFile(here::here("R", file))
