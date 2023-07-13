#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param x PARAM_DESCRIPTION
#' @param file PARAM_DESCRIPTION
#' @param begin PARAM_DESCRIPTION
#' @param end PARAM_DESCRIPTION
#' @param eol PARAM_DESCRIPTION, Default: '\n'
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
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


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param df PARAM_DESCRIPTION
#' @param filter PARAM_DESCRIPTION
#' @param result PARAM_DESCRIPTION
#' @param file PARAM_DESCRIPTION, Default: '_raw_text.qmd'
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso 
#'  [filter][dplyr::filter], [arrange][dplyr::arrange], [desc][dplyr::desc], [distinct][dplyr::distinct]
#'  [glue_data][glue::glue_data]
#'  [modify][purrr::modify], [as_mapper][purrr::as_mapper]
#' @rdname extract_and_glue_neuro_text
#' @export 
#' @importFrom dplyr filter arrange desc distinct
#' @importFrom glue glue_data
#' @importFrom purrr modify as_mapper
extract_and_glue_neuro_text <- function(df, filter, result, file = "_raw_text.qmd") {
  # Create a new dataframe that only includes the
  # rows that match the filter
  df_filtered <-
    df |>
    dplyr::filter(scale %in% filter) |>
    dplyr::arrange(dplyr::desc(percentile)) |>
    dplyr::distinct(.keep_all = FALSE)

  # Use the glue package to concatenate all of the
  # columns in the dataframe into a single string
  result <-
    df_filtered |>
    glue::glue_data() |>
    purrr::modify(purrr::as_mapper(~ paste0(.x)))

  # Write the result to a file
  cat(result, file = "_raw_text.qmd", fill = TRUE, append = TRUE)

  # Return the name of the file. This is useful for
  # passing the file to other functions.
  return("_raw_text.qmd")
}
