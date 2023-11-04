#' @title Rename Scale
#' @description Change the name of a npsych scale.
#' @param table PARAM_DESCRIPTION
#' @param scale PARAM_DESCRIPTION
#' @param name1 PARAM_DESCRIPTION
#' @param name2 PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @rdname rename_scale
#' @export
#' @importFrom dplyr mutate
#' @importFrom stringr str_replace
rename_scale <- function(table, scale, name1, name2) {
  table <-
    table %>%
    dplyr::mutate(scale = stringr::str_replace(
      string = scale,
      pattern = name1,
      replacement = name2
    ))
}
