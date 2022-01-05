
#' Make tibble for npsych report tables
#'
#' @param tibb name of tibble to make
#' @param data dataset
#' @param pheno which phenotype/cog trait
#' @param domain which cognitive domain
#' @param columns columns to keep
#' @param percentile percentile score
#' @param digits how many digits to round
#' @param names names of variables/columns
#' @param ... additional arguments
#'
#' @return A dotplot using ggplot2
#' @export
#' @examples
#' require(magrittr)
#' make_tibble(tibb = iq, data = neurocog, pheno = "Intelligence")
make_tibble <- function(tibb,
                        data = c("neurocog", "neurobehav"),
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
                        digits = 0,
                        names = c(
                          "Scale",
                          "Score",
                          "‰ Rank",
                          "Range",
                          "Subdomain",
                          "Test"
                        ),
                        ...) {
  tibb <-
    data %>%
    dplyr::filter(domain == pheno) %>%
    dplyr::select(tidyselect::all_of(columns)) %>%
    dplyr::mutate(percentile = base::round(percentile, digits)) %>%
    purrr::set_names(names)
}
