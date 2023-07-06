#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param table PARAM_DESCRIPTION
#' @param scale PARAM_DESCRIPTION
#' @param name1 PARAM_DESCRIPTION
#' @param name2 PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso 
#'  [mutate][dplyr::mutate]
#'  [str_replace][stringr::str_replace]
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
