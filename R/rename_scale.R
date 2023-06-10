#' @title Rename neuropsych table scale variable
#' @description Description of this function.
#'
#' @param table Name of table
#' @param scale Name of scale
#' @param name1 Old name
#' @param name2 New name
#' @importFrom dplyr mutate
#' @importFrom stringr str_replace
#'
#'
#' @export
rename_scale <- function(table, scale, name1, name2) {
  table <-
    table %>%
    dplyr::mutate(scale = stringr::str_replace(
      string = scale,
      pattern = name1,
      replacement = name2
    ))
}
