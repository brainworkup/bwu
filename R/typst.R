#' Create a `gt` Table and Save as .png and .pdf for Typst
#' This function creates a gt table for a given dataset.
#' @importFrom gt gt md gtsave
#' @importFrom glue glue
#' @param data Data frame with at least two columns, one for the names of each variable and one for its values.
#' @param pheno Name of phenotype of interest for output files
#' @param source_note Character string indicating that the index scores have a mean of 100 and standard deviation of 15.
#' @param table_name The name of the table to be generated
#' @return Generates the .png and .pdf file of the gt table
#' @export
#' @rdname make_tbl_gt_typ
make_tbl_gt_typ <- function(data, pheno, source_note = NULL, table_name = NULL) {
  # make source note
  source_note <- gt::md(source_note)

  # make gt table
  table <- tbl_gt(data,
    source_note = source_note,
    table_name = table_name,
    pheno = pheno
  )

  gt::gtsave(table, glue::glue("table_{pheno}.pdf"))
  gt::gtsave(table, glue::glue("table_{pheno}.png"))

  return(table)
}

#' Make a Dotplot for Neurocognitive Domains in Typst
#' This function creates a dotplot figure for a given dataset.
#' @param data Data.frame containing the input data
#' @param pheno Phenotype of interest
#' @param x Variable plotted on the x-axis, by default data$z_mean_subdomain
#' @param y Variable plotted on the y-axis, by default data$subdomain
#' @param colors A vector of colors to be used for the plot
#' @param return_plot Plot that is generated
#' @param filename Filename extension
#' @param z_score_label Label for the z-score
#' @param ... Additional arguments passed to other functions
#' @return A dotplot formatted for Typst
#' @importFrom ggplot2 ggsave
#' @importFrom glue glue
#' @export
#' @rdname make_dotplot_typ
make_dotplot_typ <- function(data, pheno, x = data$z_mean_subdomain, y = data$subdomain, colors = NULL, return_plot = TRUE, filename = c("pdf", "png", "svg"), z_score_label, ...) {
  # will need to change these for each domain
  fig <- dotplot(
    data = data,
    pheno = pheno,
    x = x,
    y = y,
    colors = colors,
    return_plot = return_plot,
    filename = filename,
    z_score_label = z_score_label
  )

  # Save the plot to specified file types
  for (ext in filename) {
    if (ext %in% c("pdf", "png", "svg")) {
      ggplot2::ggsave(filename = glue::glue("fig_{pheno}.{ext}"), plot = fig, device = ext)
    } else {
      warning(glue::glue("File extension '{ext}' not recognized. Supported extensions are 'pdf', 'png', and 'svg'."))
    }
  }

  # Return the plot if return_plot is TRUE
  if (return_plot) {
    return(fig)
  }
}

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
