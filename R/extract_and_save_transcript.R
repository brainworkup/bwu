#' @title Extract transcribed text and save as text/md file.
#' @description Extracts text between defined patterns from a specified file and saves the extracted text as a markdown file.
#' @param x A character vector
#' @param file File or connection to write to.
#' @param begin First anchor
#' @param end Second anchor
#' @param eol The line separator. Defaults to ⁠\\.c
#' @return returns x, invisibly.
#' @details DETAILS
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @rdname extract_and_save_transcript
#' @importFrom stringr str_match_all str_squish
#' @export
extract_and_save_transcript <- function(x, file, begin, end, eol = "\\n") {
  # Read the entire file as a single string
  content <- readChar(x, file.info(x)$size)

  # Extract the text between the patterns
  transcript <- stringr::str_match_all(
    content,
    paste0("(?s)", begin, "(.*?)(?=", end, ")")
  )[[1]][, 2] |>
    stringr::str_squish()

  # Add line breaks to separate paragraphs (optional)
  transcript <- paste(transcript, eol = "\n\n")

  # Write the formatted text to a markdown file
  writeLines(transcript, file)
}
