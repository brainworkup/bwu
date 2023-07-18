#' @title Make GT table per domain
#' @description Create a table of domain counts using dplyr and gt packages.
#' @param data File or path to data.
#' @param table_name Name of the table to be saved.
#' @param source_note Source note to be added to the table.
#' @param title Title of the table.
#' @param tab_stubhead Stubhead of the table.
#' @param caption Caption of the table.
#' @param process_md Process markdown.
#' @return A formatted table with domain counts.
#' @details This function creates a table of domain counts from a data frame using the dplyr and gt packages. It also saves the table with the specified name.
#' @rdname tbl_gt
#' @export
#' @importFrom dplyr mutate group_by summarise arrange select
#' @importFrom gt gt cols_label tab_stub_indent tab_header sub_missing tab_options cols_align tab_source_note gtsave
#' @importFrom gtExtras gt_theme_538
tbl_gt <- function(data, table_name = NULL, source_note = NULL, title = NULL, tab_stubhead = NULL, caption = NULL, process_md = TRUE) {
  # create data counts
  data_counts <- data |>
    dplyr::select(test_name, scale, score, percentile, range) |>
    dplyr::mutate(scale = as.character(scale)) |>
    dplyr::group_by(test_name, scale, score, percentile, range) |>
    dplyr::summarise(n = dplyr::n(), .groups = "drop")

  # widen data
  data_counts_wider <- data_counts |>
    dplyr::mutate(dplyr::across(.cols = (3:4), .fns = ~ tidyr::replace_na(., replace = 0))) |>
    dplyr::arrange(test_name) |>
    dplyr::select(-n)

  # create table
  table <- data_counts_wider |>
    dplyr::mutate(dplyr::across(.cols = (3:4), ~ dplyr::if_else(. == 0, NA_integer_, .))) |>
    dplyr::mutate(
      test_name = as.factor(test_name),
      scale = as.character(scale),
      test_name = paste0(test_name)
    ) |>
    gt::gt(
      rowname_col = "scale",
      groupname_col = "test_name",
      process_md = process_md,
      caption = caption,
      rownames_to_stub = FALSE
    ) |>
    gt::cols_label(
      test_name = gt::md("**Test**"),
      scale = gt::md("**Scale**"),
      score = gt::md("**Score**"),
      percentile = gt::md("**‰ Rank**"),
      range = gt::md("**Range**")
    ) |>
    gt::tab_header(
      title = title
    ) |>
    gt::tab_stubhead(
      label = tab_stubhead
    ) |>
    gt::sub_missing(missing_text = "--") |>
    gt::tab_options(
      row_group.font.weight = "bold"
    ) |>
    gt::tab_stub_indent(
      rows = scale,
      indent = 2
    ) |>
    gt::cols_align(
      align = "center",
      columns = c("score", "percentile", "range")
    ) |>
    gt::tab_source_note(
      source_note = source_note
    ) |>
    gt::tab_style(
      style = cell_text(
        size = "small"
      ),
      locations = cells_source_notes()
    ) |>
    gtExtras::gt_theme_538()

  return(table)
}


#' @title Create Kable Table from Data
#' @description This function creates a kable table from a given data frame.
#' @param data The data frame to be used for creating the kable table.
#' @return A kable table in LaTeX format.
#' @details This function uses the kableExtra package to create the kable table with the following specifications: lightable_options = "basic", latex_options = c("scale_down", "HOLD_position", "striped"), width of the first column is set to 8cm, rows are packed based on a table of the data's Test column, and the first row is set to bold. Additionally, a footnote is added at the end of the table.
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   df_adhd_ef <- read.csv("data/df_adhd_ef.csv")
#'   tbl_kbl(df_adhd_ef)
#' }
#' }
#' @seealso
#'  \code{\link[kableExtra]{kbl}}, \code{\link[kableExtra]{kable_classic}}, \code{\link[kableExtra]{kable_styling}}, \code{\link[kableExtra]{column_spec}}, \code{\link[kableExtra]{group_rows}}, \code{\link[kableExtra]{row_spec}}, \code{\link[kableExtra]{footnote}}
#' @rdname tbl_kbl
#' @export
#' @importFrom kableExtra kbl kable_paper kable_styling column_spec pack_rows row_spec footnote
tbl_kbl <- function(data) {
  # kable
  kableExtra::kbl(
    df_adhd_ef[, 1:4],
    "latex",
    longtable = FALSE,
    booktabs = TRUE,
    linesep = "",
    align = c("lccc")
  ) |>
    kableExtra::kable_paper(lightable_options = "basic") |>
    kableExtra::kable_styling(latex_options = c("scale_down", "HOLD_position", "striped")) |>
    kableExtra::column_spec(1, width = "8cm") |>
    kableExtra::pack_rows(index = table(df_adhd_ef$Test)) |>
    kableExtra::row_spec(row = 0, bold = TRUE) |>
    kableExtra::footnote("Note: CAARS Standard scores have a mean of 50 and a standard
  deviation of 10, and higher scores reflect reduced functioning. CEFI Standard
  scores have a mean of 100 and a standard deviation of 15, and lower scores
  reflect reduced functioning.",
      general_title = "", threeparttable = TRUE,
      escape = F, footnote_as_chunk = TRUE
    )
}


#' @title tbl_md
#' @description Create a markdown table from a data frame.
#' @param data A data frame.
#' @return A markdown table.
#' @details This function creates a markdown table from a data frame.
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # Create example data
#'   data <- data.frame(
#'     Scale = c("Scale 1", "Scale 2", "Scale 3"),
#'     Score = c(1, 2, 3),
#'     "‰ Rank" = c(0.01, 0.02, 0.03),
#'     Range = c("1-10", "11-20", "21-30")
#'   )
#'
#'   # Create the markdown table
#'   tbl_md(data)
#' }
#' }
#' @seealso
#'  \code{\link[kableExtra]{kbl}}
#' @rdname tbl_md
#' @export
#' @importFrom kableExtra kbl
tbl_md <- function(data) {
  data.frame(
    data
  ) |>
    kableExtra::kbl(
      format = "markdown",
      table.envir = "figure",
      longtable = TRUE,
      booktabs = TRUE,
      linesep = "",
      align = c("lccc"),
      col.names = c("**Scale**", "**Score**", "**‰ Rank**", "**Range**"),
      caption = caption
    )
}


#' @title Make a tibble for plots
#'
#' @description Create a tibble with columns specified in 'columns', and set column names to 'names'.
#'
#' @param tibb A data frame containing the data, Default: NULL
#' @param data A character string indicating the name of the dataset, Default: '.'
#' @param pheno A character vector indicating the domain of interest, Default: NULL
#' @param domain A character string indicating the domain of interest, Default: NULL
#' @param columns A character vector of column names to be included in the tibble, Default: c("scale", "score", "percentile", "range", "subdomain", "test_name")
#' @param percentile A numeric vector indicating the percentile values to be truncated, Default: NULL
#' @param names A character vector of column names to be set in the tibble, Default: c("Scale", "Score", "‰ Rank", "Range", "Subdomain", "Test")
#' @param ... Additional arguments to be passed to the function.
#'
#' @return A tibble with columns specified in 'columns', and set column names to 'names'.
#'
#' @details The function filters the data by 'domain', selects columns from 'columns', and sets the column names to 'names'. It then truncates the values of 'percentile' column.
#'
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#'
#' @seealso
#'  [filter][dplyr::filter], [select][dplyr::select], [mutate][dplyr::mutate]
#'  [all_of][tidyselect::all_of]
#'  [set_names][purrr::set_names]
#'
#' @rdname make_tibble
#'
#' @export
#'
#' @importFrom dplyr filter select mutate
#' @importFrom tidyselect all_of
#' @importFrom purrr set_names
make_tibble <- function(data,
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
                          "‰ Rank",
                          "Range",
                          "Subdomain",
                          "Test"
                        ),
                        tibb = NULL,
                        ...) {
  tibb <-
    data %>%
    dplyr::filter(domain %in% pheno) %>%
    dplyr::select(tidyselect::all_of(columns)) %>%
    dplyr::mutate(percentile = trunc(percentile)) %>%
    purrr::set_names(names)

  return(tibb)
}
