#' Create a Markdown Table for Typst
#' This function creates a table of descriptive statistics for a given dataset.
#' @param data A dataframe containing the columns to be used in the table.
#' @return tbl_md A table of descriptive statistics.
#' @export
#' @rdname markdown_table_typ
markdown_table_typ <- function(data) {
  tbl_md <- tbl_md_typ(data[, c(2, 4, 5, 6)])
  return(tbl_md)
}

#' Write Domain CSV
#' @param data Numeric vector, data frame, or matrix.
#' @param pheno Character vector of strings.
#' @return A csv file containing the data.
#' @importFrom glue glue
#' @importFrom readr write_csv
#' @rdname write_domain_csv
#' @export
write_domain_csv <- function(data, pheno) {
  pheno <- data[, c(2, 4, 5, 6)]
  readr::write_csv(pheno, glue::glue("{pheno}.csv"), col_names = FALSE)
}
