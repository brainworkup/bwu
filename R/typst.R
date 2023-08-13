#' @title make_g_csv
#'
#' @description Gets index scores for given patient path
#' @param patient Root directory of patient
#' @return Returns g index score
#' @rdname make_g_csv
#' @export
make_g_csv <- function(patient) {
  g <- bwu::gpluck_get_index_scores(patient = patient)
}

#' Reads data from a csv file.
#' @param pheno Character vector for phenotype. Options are "adhd" or "emotion".
#' @return A tibble containing the data.
#' @export
#' @importFrom readr read_csv
#' @importFrom dplyr filter arrange distinct desc mutate
#' @rdname read_data
read_data <- function(pheno) {
  if (pheno == "adhd" || pheno == "emotion") {
    csv <- "neurobehav.csv"
  } else {
    csv <- "neurocog.csv"
  }
  file_path <- file.path(csv)
  data <- readr::read_csv(file_path)
  return(data)
}

#' @title Filters data by domain and scale
#' @param data A dataframe or tibble
#' @param domain The domain name that the user wants to filter by
#' @param filter_file A text file containing a list of scales
#' @return Returns a filtered data frame
#' @export
#' @importFrom dplyr filter
#' @rdname filter_domain
filter_domain <- function(data, domain, filter_file) {
  # filter by broad domain
  data <-
    dplyr::filter(data, domain == !!domain) |>
    dplyr::filter(!is.na(percentile))

  # filter by scale
  filter_file <- filter_file
  data <- dplyr::filter(data, scale %in% filter_file)
  return(data)
}

#' @title Flatten concatenated text for each neuropsych scale
#' @description This function sorts the data by percentile, removes duplicates and converts the data to text. Finally, it appends the converted data to a file.
#' @param data A dataframe containing the data
#' @param file A character string specifying the name of the file
#' @return A file containing the flattened and scaled text
#' @importFrom dplyr filter arrange distinct desc mutate
#' @export
#' @rdname flatten_scale_text
flatten_scale_text <- function(data, file) {
  # Sorting the data by percentile and removing duplicates
  data_text <- data |>
    dplyr::arrange(dplyr::desc(percentile)) |>
    dplyr::distinct(.keep_all = FALSE)

  # Convert the data to text and append to the file
  cat(
    paste0(data_text$result),
    file = file,
    sep = "\n",
    append = TRUE
  )
}

#' Create a gt table and save as a .png and .pdf file
#' @param data Data frame with at least two columns, one for the names of each variable and one for its values.
#' @param pheno Name of phenotype of interest for output files
#' @param index_score Character string indicating that the index scores have a mean of 100 and standard deviation of 15.
#' @param table_name The name of the table to be generated
#' @return Generates the .png and .pdf file of the gt table
#' @export
#' @importFrom gt gt md gtsave
make_tbl_gt <- function(data, pheno, index_score, table_name) {
  # source note
  source_note <- gt::md(index_score)

  # make gt table
  gt_table <- bwu::tbl_gt(data,
    table_name = table_name,
    source_note = source_note,
    title = NULL
  )
  return(gt_table)

  # save
  gt::gtsave(gt_table, glue("table_{pheno}", ".png"), expand = 10)
  gt::gtsave(gt_table, glue("table_{pheno}", ".pdf"), expand = 10)
}


#' Make a dotplot for cognitive domain scores
#' This function creates a dotplot figure for a given dataset.
#' @param data Dataframe containing the input data
#' @param x Variable plotted on the x-axis, by default data_dotplot$z_mean_narrow
#' @param y Variable plotted on the y-axis, by default data_dotplot$narrow
#' @param pheno Phenotype of interest
#' @param colors A vector of colors to be used for the plot
#' @return an object of class figure object
#' @importFrom ggplot2 ggsave
#' @importFrom xfun pkg_attach2
#' @importFrom glue glue
#' @export
#' @rdname make_fig
make_fig <- function(data, x, y, pheno, colors = NULL) {
  # will need to change these for each domain
  fig <- bwu::dotplot(
    data = data,
    x = x,
    y = y,
    colors = colors
  )
  fig
  ggplot2::ggsave(glue::glue("fig_{pheno}.png"))
  ggplot2::ggsave(glue::glue("fig_{pheno}.pdf"))
}

#' Create a Table for Typst
#' This function creates a table of descriptive statistics for a given dataset.
#' @param data A dataframe containing the columns to be used in the table.
#' @return tbl_md A table of descriptive statistics.
#' @export
#' @rdname make_tbl_md_typ
make_tbl_md_typ <- function(data) {
  tbl_md <- bwu::tbl_md_typ(data[, c(2, 4, 5, 6)])
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
