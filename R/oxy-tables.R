#' @title tbl_gt
#' @description Create a table of domain counts using dplyr and gt packages.
#' @param file_path Path to the data frame.
#' @param filter Filter for the data frame.
#' @param domain Domain to be used in the data frame.
#' @param table_name Name of the table.
#' @return A formatted table with domain counts.
#' @details This function creates a table of domain counts from a data frame using the dplyr and gt packages. It also saves the table with the specified name.
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#'   df_domain <- read.csv("data/domain_counts.csv")
#'   tbl_gt(df_domain, filter = TRUE, domain = "test", table_name = "table_domain")
#' }
#' }
#' @seealso
#'  \code{\link[dplyr]{mutate}}, \code{\link[dplyr]{group_by}}, \code{\link[dplyr]{summarise}}, \code{\link[dplyr]{arrange}}, \code{\link[dplyr]{select}}
#'  \code{\link[gt]{gt}}, \code{\link[gt]{cols_label}}, \code{\link[gt]{tab_stub_indent}}, \code{\link[gt]{tab_header}}, \code{\link[gt]{sub_missing}}, \code{\link[gt]{tab_options}}, \code{\link[gt]{cols_align}}, \code{\link[gt]{tab_source_note}}, \code{\link[gt]{character(0)}}, \code{\link[gt]{gtsave}}
#' @rdname tbl_gt
#' @export
#' @importFrom dplyr mutate group_by summarise arrange select
#' @importFrom gt gt cols_label tab_stub_indent tab_header sub_missing tab_options cols_align tab_source_note gtsave
#' @importFrom gtExtras gt_theme_538
tbl_gt <- function(file_path, filter, domain, table_name) {
  domain_counts <- df_domain |>
    dplyr::mutate(scale = as.character(scale)) |>
    dplyr::group_by(test_name, scale, score, percentile, range, subdomain) |>
    dplyr::summarise(n = dplyr::n(), .groups = "drop")

  domain_counts_wider <- domain_counts |>
    dplyr::mutate(dplyr::across(.cols = (3:4), .fns = ~ tidyr::replace_na(., replace = 0))) |>
    dplyr::arrange(test_name) |>
    dplyr::select(-subdomain, -n)

  # create table
  table_domain <- domain_counts_wider |>
    dplyr::mutate(dplyr::across(.cols = (3:4), ~ dplyr::if_else(. == 0, NA_integer_, .))) |>
    dplyr::mutate(
      test_name = as.factor(test_name),
      scale = as.character(scale),
      test_name = paste0(test_name)
    ) |>
    gt::gt(
      groupname_col = "test_name",
      rowname_col = "scale"
    ) |>
    gt::cols_label(
      test_name = gt::md("**Test**"),
      scale = gt::md("**Scale**"),
      score = gt::md("**Score**"),
      percentile = gt::md("**‰ Rank**"),
      range = gt::md("**Range**")
    ) |>
    gt::tab_stub_indent(
      rows = scale
    ) |>
    gt::tab_header(
      title = "Battery/Subtest"
    ) |>
    gt::sub_missing(missing_text = "--") |>
    gt::tab_options(
      data_row.padding = gt::px(1),
      summary_row.padding = gt::px(2),
      row_group.padding = gt::px(3),
      row_group.font.weight = "bold"
    ) |>
    gt::cols_align(
      align = "center",
      columns = c(score, percentile, range)
    ) |>
    # Adding a source note to the table
    gt::tab_source_note(
      source_note = "Note: T-scores have a mean of 50 and a standard deviation of 10. Scaled scores have a mean of 10 and a standard deviation of 3."
    ) |>
    gtExtras::gt_theme_538()

  return(table_domain)

  # save the table
  table_domain |> gt::gtsave(table_name, expand = 10)
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
