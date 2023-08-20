#' @title Extract and Save NSE Transcript from Otter.ai
#' @description This function extracts the text between given beginning and ending patterns from a file and saves the transcript to another file.
#' @importFrom stringr str_match_all str_squish
#' @param x A character string specifying the path to the input file.
#' @param file A character string specifying the path to the output file where the extracted transcript will be saved.
#' @param begin A character string specifying the pattern that marks the beginning of the transcript in the input file.
#' @param end A character string specifying the pattern that marks the end of the transcript in the input file.
#' @param eol A character string specifying the line ending to be used in the output file, default is '\\n'.
#' @return NULL, as this function is primarily used for its side effect of writing a file.
#' @details This function uses regular expressions to extract text between specified patterns. It is useful for extracting structured text data, such as transcripts, from files.
#' @rdname read_write_transcript_otterai
#' @export
read_write_transcript_otterai <- function(x, file, begin, end, eol = "\\n") {
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
  return(writeLines(transcript, file))
}

#' @title Concatenate and Flatten Neuropsych Results by Scale
#' @description This function sorts the data by percentile, removes duplicates and converts the data to text. Finally, it appends the converted data to a file.
#' @param data A dataframe containing the data
#' @param file A character string specifying the name of the file
#' @param ... Additional arguments passed to other functions
#' @return A file containing the flattened and scaled text
#' @importFrom dplyr filter arrange distinct desc mutate
#' @export
#' @rdname cat_neuropsych_results
cat_neuropsych_results <- function(data, file, ...) {
  # Sorting the data by percentile and removing duplicates
  sorted_data <- data |>
    dplyr::arrange(dplyr::desc(percentile)) |>
    dplyr::distinct(.keep_all = FALSE)

  # Convert the data to text and append to the file
  cat(
    paste0(sorted_data$result),
    file = file,
    sep = "\n",
    append = TRUE
  )
}


#' @title Extract and glue neuropsych text
#' @description This function filters a dataframe based on a specified condition, concatenates all of the columns into a single string, and writes the result to a file.
#' @importFrom dplyr filter arrange desc distinct
#' @importFrom glue glue_data
#' @importFrom purrr modify as_mapper
#' @param df A dataframe from which data is to be filtered and concatenated.
#' @param filter A character vector or list specifying the filter condition for the 'scale' column of the dataframe.
#' @param result This parameter appears to be unused and can potentially be removed.
#' @param file A character string specifying the path to the output file where the concatenated text will be saved, default is '_raw_text.qmd'.
#' @return The name of the file to which the result was written, useful for passing the file to other functions.
#' @details This function uses dplyr for data manipulation, glue for data concatenation, and purrr for functional programming.
#' @rdname glue_neuropsych_results
#' @export
glue_neuropsych_results <- function(df, filter, result, file) {
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
