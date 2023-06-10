#' Make tibble table for npsych report tables
#'
#' This function constructs a tibble table based on provided data and parameters.
#' The resulting table is designed for reports.
#'
#' @param tibb An initial tibble to which transformations will be applied.
#' @param data Dataframe to be converted into a tibble. Default: '.'
#' @param pheno A vector of phenotypes to be included in the resulting tibble. Default: NULL
#' @param domain A character vector specifying the domain(s) to be included in the filter. Default: NULL
#' @param columns A character vector specifying the columns to be selected from the data. Default: c("scale", "score", "percentile", "range", "subdomain", "test_name")
#' @param percentile Percentile to be used in mutation. Default: NULL
#' @param names Names to be set in the final tibble. Default: c("Scale", "Score", "‰ Rank", "Range", "Subdomain", "Test")
#' @param ... Other arguments to be passed to the function.
#'
#' @return A tibble with selected columns, filtered and mutated based on the parameters.
#'
#' @details This function is part of a set of functions designed for generating reports in npsych. It constructs a tibble based on a variety of parameters, and is designed to work smoothly with other components of the npsych ecosystem.
#'
#' @examples
#' \dontrun{
#' if(interactive()){
#'  # Create a tibble
#'  tibb <- tibble(scale = 1:5, score = 6:10, percentile = 11:15,
#'                 range = 16:20, subdomain = 21:25, test_name = 26:30)
#'  # Create a dataframe
#'  data <- data.frame(scale = 1:5, score = 6:10, percentile = 11:15,
#'                 range = 16:20, subdomain = 21:25, test_name = 26:30)
#'  # Make the report tibble
#'  report <- make_tibble(tibb, data = data, pheno = c(1, 2), domain = c("scale"))
#'  print(report)
#'  }
#' }
#' @seealso
#'  \code{\link[dplyr]{filter}}, \code{\link[dplyr]{select}}, \code{\link[dplyr]{mutate}}
#'  \code{\link[tidyselect]{all_of}}
#'  \code{\link[purrr]{set_names}}
#' @rdname make_tibble
#' @importFrom dplyr filter select mutate
#' @importFrom tidyselect all_of
#' @importFrom purrr set_names
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
