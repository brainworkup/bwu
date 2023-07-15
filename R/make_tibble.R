#' @title Make a tibble for plots
#' @description FUNCTION_DESCRIPTION
#' @param tibb PARAM_DESCRIPTION
#' @param data PARAM_DESCRIPTION, Default: '.'
#' @param pheno PARAM_DESCRIPTION, Default: NULL
#' @param domain PARAM_DESCRIPTION, Default: NULL
#' @param columns PARAM_DESCRIPTION, Default: c("scale", "score", "percentile", "range", "subdomain", "test_name")
#' @param percentile PARAM_DESCRIPTION, Default: NULL
#' @param names PARAM_DESCRIPTION, Default: c("Scale", "Score", "‰ Rank", "Range", "Subdomain", "Test")
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @seealso
#'  [filter][dplyr::filter], [select][dplyr::select], [mutate][dplyr::mutate]
#'  [all_of][tidyselect::all_of]
#'  [set_names][purrr::set_names]
#' @rdname make_tibble
#' @export
#' @importFrom dplyr filter select mutate
#' @importFrom tidyselect all_of
#' @importFrom purrr set_names
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
