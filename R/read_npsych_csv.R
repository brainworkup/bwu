#' Import neuropsych csv files/tests that do not have PDFs
#'
#' @param patient Name of patient
#' @param test Name of test
#'
#' @return CSV file with new column 'result'
#' @export
#'
read_npsych_csv <- function(patient, test) {
  table <-
    test |>
    readr::read_csv(here::here(patient, "csv", test))

  return(table)
}
