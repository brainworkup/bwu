#' @title Pluck tables from PDFs
#' @description Extract tables from a file
#' @param file A character string specifying the path or URL to a PDF file.
#' @param pages An optional integer vector specifying pages to extract from.
#' @param area An optional list, of length equal to the number of pages specified, where each entry contains a four-element numeric vector of coordinates (top,left,bottom,right) containing the table for the corresponding page. As a convenience, a list of length 1 can be used to extract the same area from all (specified) pages. Only specify \code{area} xor \code{columns}.
#' @param guess A logical indicating whether to guess the locations of tables on each page. If \code{FALSE}, \code{area} or \code{columns} must be specified; if \code{TRUE}, columns is ignored.
#' @param method A string identifying the prefered method of table extraction.
#' \itemize{
#'   \item \code{method = "decide"} (default) automatically decide (for each page) whether spreadsheet-like formatting is present and "lattice" is appropriate
#'   \item \code{method = "lattice"} use Tabula's spreadsheet extraction algorithm
#'   \item \code{method = "stream"} use Tabula's basic extraction algorithm
#' }
#' @param output A function to coerce the Java response object (a Java ArrayList of Tabula Tables) to some output format. The default method, \dQuote{matrices}, returns a list of character matrices. See Details for other options.
#' @param \dots These are additional arguments passed to the internal functions dispatched by \code{method}.
#' @details This function mimics the behavior of the Tabula command line utility. It returns a list of R character matrices containing tables extracted from a file by default. This response behavior can be changed by using the following options.
#' \itemize{
#'   \item \code{output = "character"} returns a list of single-element character vectors, where each vector is a tab-delimited, line-separate string of concatenated table cells.
#'   \item \code{output = "data.frame"} attempts to coerce the structure returned by \code{method = "character"} into a list of data.frames and returns character strings where this fails.
#'   \item \code{output = "csv"} writes the tables to comma-separated (CSV) files using Tabula's CSVWriter method in the same directory as the original PDF. \code{method = "tsv"} does the same but with tab-separated (TSV) files using Tabula's TSVWriter and \code{method = "json"} does the same using Tabula's JSONWriter method. Any of these three methods return the path to the directory containing the extract table files.
#'   \item \code{output = "asis"} returns the Java object reference, which can be useful for debugging or for writing a custom parser.
#' }
#' @return By default, a list of character matrices. This can be changed by specifying an alternative value of \code{method} (see Details).
#' @references \href{http://tabula.technology/}{Tabula}
#' @examples
#' \dontrun{
#' # simple demo file
#' f <- system.file("examples", "data.pdf", package = "tabulizer")
#'
#' # extract all tables
#' extract_tables(f)
#'
#' # extract tables from only second page
#' extract_tables(f, pages = 2)
#'
#' # extract areas from a page
#' ## full table
#' extract_tables(f, pages = 2, area = list(c(126, 149, 212, 462)))
#' ## part of the table
#' extract_tables(f, pages = 2, area = list(c(126, 284, 174, 417)))
#'
#' # return data.frames
#' extract_tables(f, pages = 2, output = "data.frame")
#' }
#' @importFrom tabulizer extract_tables
#' @importFrom utils read.delim download.file
#' @importFrom tools file_path_sans_ext
#' @importFrom rJava J new .jfloat
#' @export
gpluck_extract_table <-
  function(
    file,
    pages = NULL,
    area = NULL,
    guess = FALSE,
    method = c("decide", "lattice", "stream"),
    output = c("matrix", "data.frame", "character", "asis", "csv", "tsv", "json"),
           ...) {
    tabulizer::extract_tables(
      file = file,
      pages = pages,
      area = area,
      guess = match.arg(guess),
      method = match.arg(method),
      output = match.arg(output)
    )
  }
