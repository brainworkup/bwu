#' Extracts text from the neuropsych data
#' and writes it to a file.
#'
#' @param df The data frame of results
#' @param filter The vector of filters to apply
#' @param result The resulting string
#' @param file The name of the output file, default "_raw_text.qmd"
#' @return The name of the output file
#' @export
extract_and_glue_neuro_text <- function(df, filter, result, file = "_raw_text.qmd") {
  # Create a new dataframe that only includes the
  # rows that match the filter
  df_filtered <-
    df |>
    dplyr::filter(scale %in% filter) |>
    dplyr::arrange(desc(percentile)) |>
    dplyr::distinct(.keep_all = FALSE)

  # Use the glue package to concatenate all of the
  # columns in the dataframe into a single string
  result <-
    df_filtered |>
    glue::glue_data() |>
    purrr::modify(as_mapper(~ paste0(.x)))

  # Write the result to a file
  cat(result, file = "_raw_text.qmd", fill = TRUE, append = TRUE)

  # Return the name of the file. This is useful for
  # passing the file to other functions.
  return("_raw_text.qmd")
}
