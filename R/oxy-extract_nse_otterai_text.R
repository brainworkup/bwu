#' @title Extract OtterAI Text
#' @description FUNCTION_DESCRIPTION
#' @param patient Name of patient
#' @param file_path Path to .txt/.md file
#' @param start_pattern First anchor
#' @param end_pattern Second anchor
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[stringr]{str_match}}, \code{\link[stringr]{str_trim}}
#' @rdname extract_text
#' @export
#' @importFrom stringr str_match_all str_squish
extract_text <- function(patient, file_path, start_pattern, end_pattern) {
  # Read the entire file as a single string
  file_content <- readChar(file_path, file.info(file_path)$size)

  # Define the patterns to search for
  start_pattern <- start_pattern
  end_pattern <- end_pattern

  # Extract the text between the patterns
  extracted_text <- stringr::str_match_all(
    file_content,
    paste0("(?s)", start_pattern, "(.*?)(?=", end_pattern, ")")
  )[[1]][, 2] |>
    stringr::str_squish()

  # Specify the path for the output markdown file
  output_path <- "./extract_nse.md"

  # Save the extracted text as a markdown file
  save_as_markdown(extracted_text, output_path)

  return(extracted_text)
}

# Function to save extracted text as a markdown file
#' @title Save extracted text as markdown.
#' @description FUNCTION_DESCRIPTION
#' @param text Name of file.
#' @param output_path Where to save outoput.
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname save_as_markdown
#' @export
save_as_markdown <- function(text, output_path) {
  # Add line breaks to separate paragraphs (optional)
  formatted_text <- paste(text, collapse = "\n\n")

  # Write the formatted text to a markdown file
  writeLines(formatted_text, output_path)
}
