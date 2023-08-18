#' @title Extract and save NSE transcript
#' @description This function extracts the text between given beginning and ending patterns from a file and saves the transcript to another file.
#' @param x A character string specifying the path to the input file.
#' @param file A character string specifying the path to the output file where the extracted transcript will be saved.
#' @param begin A character string specifying the pattern that marks the beginning of the transcript in the input file.
#' @param end A character string specifying the pattern that marks the end of the transcript in the input file.
#' @param eol A character string specifying the line ending to be used in the output file, default is '\\n'.
#' @return NULL, as this function is primarily used for its side effect of writing a file.
#' @details This function uses regular expressions to extract text between specified patterns. It is useful for extracting structured text data, such as transcripts, from files.
#' @seealso
#'  [str_match_all][stringr::str_match_all], [str_squish][stringr::str_squish]
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

#' @title Extract and glue neuropsych text
#' @description This function filters a dataframe based on a specified condition, concatenates all of the columns into a single string, and writes the result to a file.
#' @param df A dataframe from which data is to be filtered and concatenated.
#' @param filter A character vector or list specifying the filter condition for the 'scale' column of the dataframe.
#' @param result This parameter appears to be unused and can potentially be removed.
#' @param file A character string specifying the path to the output file where the concatenated text will be saved, default is '_raw_text.qmd'.
#' @return The name of the file to which the result was written, useful for passing the file to other functions.
#' @details This function uses dplyr for data manipulation, glue for data concatenation, and purrr for functional programming.
#' @rdname extract_and_glue_neuro_text
#' @export
#' @importFrom dplyr filter arrange desc distinct
#' @importFrom glue glue_data
#' @importFrom purrr modify as_mapper
extract_and_glue_neuro_text <- function(df, filter, result, file) {
  # Create a new dataframe that only includes the
  # rows that match the filter
  df_filtered <-
    df |>
    dplyr::filter(scale %in% filter) |>
    dplyr::arrange(dplyr::desc(percentile)) |>
    dplyr::distinct(.keep_all = FALSE)

  # Use the glue package to concatenate all of the
  # columns in the dataframe into a single string
  df_glued <-
    df_filtered |>
    glue::glue_data() |>
    purrr::modify(purrr::as_mapper(~ paste0(.x)))

  # Write the result to a file
  cat(result, file = file, fill = TRUE, append = TRUE)

  # Return the name of the file. This is useful for
  # passing the file to other functions.
  return(df_glued)
}


#' @title Filter lines in a PDF file
#'
#' @description Filter lines from text extracted from a PDF for given words.
#'
#' @param extracted_text A \code{list} of strings, containing text extracted from the PDF file.
#' @param pdf_file Path to the PDF file.
#' @param page Optional \code{integer}: Page number in the PDF used for extraction, defaults to \code{NULL}.
#' @param scale The word which is searched in lines and then filtered.
#'
#' @return A \code{vector} of strings, for all lines that contains the word in \code{scale}.
#'
#' @export
filter_lines <- function(extracted_text, pdf_file, page = NULL, scale) {
  scale_text <- extracted_text[[page]]

  # Convert the string into a vector of lines
  lines <- strsplit(scale_text, "\n")[[1]]

  # Filter lines that contain the word in scale
  scale_text_filtered <- lines[grepl(scale, lines)]

  return(scale_text_filtered)
}
