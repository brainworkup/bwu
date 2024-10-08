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


comma <- function(x) format(x, digits = 2, big.mark = ",")


find_resource <- function(template, file) {
  find_file(template, file.path("resources", file))
}

inherit_pdf_document <- function(...) {
  fmt <- bookdown::pdf_document2(...)
  fmt$inherits <- "pdf_document"
  fmt
}

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
  # fmt$pandoc$args <- c(fmt$pandoc$args,
  #                      "--filter pandoc-citeproc-preamble -M citeproc-preamble=",
  #                      rmarkdown::pandoc_path_arg("citeproc-preamble.tex"))
  # return format

  fmt
}

### These copied from tufte package
### These copied from tufte package
### These copied from tufte package
### These copied from tufte package

#' @details `newthought()` can be used in inline R expressions in R
#'   Markdown
#'   ```r
#'   `r newthought(Some text)`
#'   ```
#'   and it works for both
#'   HTML (\samp{<span class="newthought">text</span>}) and PDF
#'   (\samp{\\newthought{text}}) output.
#' @param text A character string to be presented as a \dQuote{new thought}
#'   (using small caps), or a margin note, or a footer of a quote
#' @rdname tufte_handout
#' @export
#' @examples newthought("In this section")
newthought <- function(text) {
  if (is_html_output()) {
    sprintf('<span class="newthought">%s</span>', text)
  } else if (is_latex_output()) {
    sprintf("\\newthought{%s}", text)
  } else {
    sprintf('<span style="font-variant:small-caps;">%s</span>', text)
  }
}



#' @details `margin_note()` can be used in inline R expressions to write a
#'   margin note (like a sidenote but not numbered).
#' @param icon A character string to indicate there is a hidden margin note when
#'   the page width is too narrow (by default it is a circled plus sign)
#' @rdname tufte_handout
#' @importFrom knitr is_html_output is_latex_output
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

#' @details `quote_footer()` formats text as the footer of a quote. It puts
#'   `text` in \samp{<footer></footer>} for HTML output, and
#'   after \samp{\\hfill} for LaTeX output (to right-align text).
#' @rdname tufte_handout
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

#' @details `sans_serif()` applies sans-serif fonts to `text`.
#' @rdname tufte_handout
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

template_resources <- function(name, ...) {
  system.file("rmarkdown", "templates", name, "resources", ..., package = "bwu")
}

gsub_fixed <- function(...) gsub(..., fixed = TRUE)

pandoc2.0 <- function() rmarkdown::pandoc_available("2.0")

# add --wrap=preserve to pandoc args for pandoc 2.0
# https://github.com/rstudio/bookdown/issues/504
# https://github.com/rstudio/tufte/issues/115
add_wrap_preserve <- function(args, pandoc2 = pandoc2.0) {
  if (pandoc2 && !length(grep("--wrap", args))) {
    c("--wrap", "preserve", args)
  } else {
    args
  }
}


NULL
#' @importFrom tibble as_tibble
#' @importFrom rlang !!
#' @importFrom rlang !!!
#' @importFrom rlang syms .data
required_package <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    stop(
      pkg, " package needed to be installed before using this function. ",
      "Type this in R: install.packages('", pkg, "')"
    )
  }
}

# Unnesting, adapt to tidyr 1.0.0
unnest <- function(data, cols = "data", ...) {
  if (is_pkg_version_sup("tidyr", "0.8.3")) {
    results <- tidyr::unnest(data, cols = cols, ...)
  } else {
    results <- tidyr::unnest(data, ...)
  }
  results
}

# Check if an installed package version is superior to a specified version
# Version, pkg: character vector
is_pkg_version_sup <- function(pkg, version) {
  vv <- as.character(utils::packageVersion(pkg))
  cc <- utils::compareVersion(vv, version) > 0
  cc
}

keep_only_tbl_df_classes <- function(x) {
  toremove <- setdiff(class(x), c("tbl_df", "tbl", "data.frame"))
  if (length(toremove) > 0) {
    class(x) <- setdiff(class(x), toremove)
  }
  x
}
