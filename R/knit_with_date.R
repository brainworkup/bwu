#' Custom Knit function for RStudio
#' @param input An input
#' @param ... Additional arguments
#' @rdname knit_with_date
#' @importFrom rmarkdown render
#' @importFrom xfun sans_ext file_ext
#' @export
knit_with_date <- function(input, ...) {
  rmarkdown::render(
    input,
    output_file = paste0(
      xfun::sans_ext(input), "-", Sys.Date(), ".",
      xfun::file_ext(input)
    ),
    envir = globalenv()
  )
}
