#' @rdname gpluck_extract_areas
#' @title gpluck_extract_areas
#' @description Interactively identify areas and extract
#' @param file A character string specifying the path to a PDF file. This can also be a URL, in which case the file will be downloaded to the R temporary directory using \code{download.file}.
#' @param pages An optional integer vector specifying pages to extract from. To extract multiple tables from a given page, repeat the page number (e.g., \code{c(1,2,2,3)}).
#' @param \dots Other arguments passed to \code{\link{extract_tables}}.
#' @author Joey W Trampush, \email{trampush@usc.edu}
#'
#' @examples
#' \dontrun{
#' # simple demo file
#' f <- system.file("examples", "data.pdf", package = "tabulizer")
#'
#' # locate areas only, using Shiny app
#' locate_areas(f)
#'
#' # locate areas only, using native graphics device
#' locate_areas(f, widget = "shiny")
#'
#' # locate areas and extract
#' extract_areas(f)
#' }
#' @import tabulizer
#' @importFrom tools file_path_sans_ext
#' @importFrom rJava J new
#' @importFrom png readPNG
#' @importFrom grDevices dev.capabilities dev.off
#' @importFrom graphics par rasterImage locator plot
#'
#' @export
gpluck_locate_areas <- function(file, pages = NULL, ...) {
  tabulizer::locate_areas(
    file = file,
    pages = pages,
    ...
    )
}
