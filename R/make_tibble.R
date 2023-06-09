#' @title Make tibble table for npsych report tables
#'
#' @description Make a tibble table for reports.
#'
#' @param tibb Name of tibble to make
#' @param data Dataset to use
#' @param pheno Which phenotype/cog trait
#' @param domain Which cognitive domain
#' @param columns Columns to keep
#' @param percentile Percentile score
#' @param names Names of variables/columns
#' @param ... Additional arguments
#'
#' @return A tibble for plotting
#' @examples
#' make_tibble(
#'   tibb = iq,
#'   data = neurocog,
#'   pheno = "Intelligence/General Ability"
#' )
#'
#' @export
make_tibble <- function(tibb,
                        data = ".",
                        pheno = NULL,
                        domain = NULL,
                        columns = c(
                          "scale",
                          "score",
                          "percentile",
                          "range",
                          "subdomain",
                          "test_name"
                        ),
                        percentile = NULL,
                        names = c(
                          "Scale",
                          "Score",
                          "\u2030 Rank",
                          "Range",
                          "Subdomain",
                          "Test"
                        ),
                        ...) {
  data <- as.data.frame(data)

  tibb <-
    data |>
    dplyr::filter(domain %in% pheno) |>
    dplyr::select(tidyselect::all_of(columns)) |>
    dplyr::mutate(percentile = trunc(percentile)) |>
    purrr::set_names(names)
}
