#' Import neuropsych csv files/tests that do not have PDFs
#'
#' @param patient Name of patient
#' @param test Name of test
#'
#' @return csv with new column 'result'
#' @export
#'
read_npsych <- function(patient, test) {
  test <-
    readr::read_csv(here::here(patient, "csv", test)) |>
    dplyr::mutate(result = glue::glue("{description} was {range}."))
}
