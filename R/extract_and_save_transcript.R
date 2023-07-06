#' @title Extract text
#' @description FUNCTION_DESCRIPTION
#' @param x PARAM_DESCRIPTION
#' @param file PARAM_DESCRIPTION
#' @param begin PARAM_DESCRIPTION
#' @param end PARAM_DESCRIPTION
#' @param eol PARAM_DESCRIPTION, Default: '\\n'
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname extract_and_save_transcript
#' @export
#' @importFrom stringr str_match_all str_squish
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
