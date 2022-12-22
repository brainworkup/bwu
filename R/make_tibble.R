#' @title Make tibble table for npsych report tables
#'
#' @description This is the description.
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
#' @return A dotplot using ggplot2
#' @examples
#' make_tibble(
#'   tibb = iq,
#'   data = neurocog,
#'   pheno = "Intelligence/General Ability"
#' )
#'
#' @export
make_tibble <- function(tibb = NULL,
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
  tibb <- as.data.frame(tibb)

  tibb <-
    data |>
    dplyr::filter(domain == pheno) |>
    dplyr::select(tidyselect::all_of(columns)) |>
    dplyr::mutate(percentile = trunc(percentile)) |>
    purrr::set_names(names)
}
