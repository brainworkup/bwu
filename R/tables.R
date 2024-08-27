#' @title Make Table Using `gt` Package for Neurocognitive Domains
#' @description Create a table of domain counts using dplyr and gt packages.
#' @importFrom dplyr across mutate group_by summarize arrange select if_else
#' @importFrom gt gt cols_label tab_stub_indent tab_header sub_missing tab_options cols_align tab_source_note gtsave tab_style tab_stubhead tab_caption tab_spanner cell_text cells_source_notes md tab_footnote opt_vertical_padding cells_row_groups
#' @importFrom gtExtras gt_theme_538
#' @importFrom tidyr replace_na
#' @importFrom glue glue
#' @param data File or path to data.
#' @param pheno Phenotype name.
#' @param table_name Name of the table to be saved.
#' @param source_note Source note to be added to the table.
#' @param names Names of the columns.
#' @param title Title of the table.
#' @param tab_stubhead Stubhead of the table.
#' @param caption Caption of the table.
#' @param process_md Process markdown.
#' @param fn_scaled_score Footnote for scaled score.
#' @param fn_standard_score Footnote for standard score.
#' @param fn_t_score Footnote for t score.
#' @param fn_z_score Footnote for z score.
#' @param fn_raw_score Footnote for raw scores.
#' @param grp_standard_score Groups for standard score.
#' @param grp_t_score Groups for t score.
#' @param grp_scaled_score Groups for scaled score.
#' @param grp_z_score Groups for z score.
#' @param grp_raw_score Groups for raw scores.
#' @param dynamic_grp Generalized grouping parameter.
#' @param vertical_padding Vertical padding.
#' @param multiline Multiline footnotes, Default = TRUE.
#' @param ... Additional arguments to be passed to the function.
#' @return A formatted table with domain counts.
#' @rdname tbl_gt
#' @export
tbl_gt <-
  function(data,
           pheno = NULL,
           table_name = NULL,
           source_note = NULL,
           names = NULL,
           title = NULL,
           tab_stubhead = NULL,
           caption = NULL,
           process_md = FALSE,
           fn_scaled_score = NULL,
           fn_standard_score = NULL,
           fn_t_score = NULL,
           fn_z_score = NULL,
           fn_raw_score = NULL,
           grp_scaled_score = NULL,
           grp_standard_score = NULL,
           grp_t_score = NULL,
           grp_z_score = NULL,
           grp_raw_score = NULL,
           dynamic_grp = NULL,
           vertical_padding = NULL,
           multiline = TRUE,
           ...) {
    # Create data counts
    data_counts <- data |>
      dplyr::select(test_name, scale, score, percentile, range) |>
      dplyr::mutate(across(c(score, percentile), ~ tidyr::replace_na(., replace = 0)))

    # Create table
    table <- data_counts |>
      dplyr::mutate(
        score = if_else(score == 0, NA_integer_, score),
        percentile = if_else(percentile == 0, NA_integer_, percentile),
        test_name = as.character(paste0(test_name)),
        scale = as.character(scale)
      ) |>
      # gt table formatting
      gt::gt(
        rowname_col = "scale",
        groupname_col = "test_name",
        process_md = process_md,
        caption = caption,
        rownames_to_stub = FALSE,
        id = paste0("table_", pheno)
      ) |>
      gt::cols_label(
        test_name = md("**Test**"),
        scale = md("**Scale**"),
        score = md("**Score**"),
        percentile = md("**‰ Rank**"),
        range = md("**Range**")
      ) |>
      gt::tab_header(title = title) |>
      gt::tab_stubhead(label = tab_stubhead) |>
      gt::sub_missing(missing_text = "--") |>
      gt::tab_stub_indent(rows = scale, indent = 2) |>
      gt::cols_align(
        align = "center",
        columns = c("score", "percentile", "range")
      )

    # Extract unique row groups from the data to check against the groups we want to apply footnotes to
    existing_row_groups <- unique(data$test_name)

    # Filter out non-existent groups
    grp_scaled_score <- intersect(grp_scaled_score, existing_row_groups)
    grp_standard_score <- intersect(grp_standard_score, existing_row_groups)
    grp_t_score <- intersect(grp_t_score, existing_row_groups)
    grp_z_score <- intersect(grp_z_score, existing_row_groups)
    grp_raw_score <- intersect(grp_raw_score, existing_row_groups)

    # Concatenate footnotes
    fn_combined <- list(
      scaled_score = fn_scaled_score,
      standard_score = fn_standard_score,
      t_score = fn_t_score,
      z_score = fn_z_score,
      raw_score = fn_raw_score
    )

    # Add footnotes
    for (score_type in names(fn_combined)) {
      fn <- fn_combined[[score_type]]
      groups <- get(paste0("grp_", score_type))
      if (!is.null(fn) && any(groups %in% dynamic_grp[[score_type]])) {
        table <- table |>
          tab_footnote(
            footnote = glue::glue_collapse(fn, sep = " "),
            locations = cells_row_groups(groups = groups)
          )
      }
    }

    # Adding source note
    table <- table |>
      gt::tab_style(style = cell_text(size = "small"), locations = cells_source_notes()) |>
      gt::tab_source_note(source_note = source_note) |>
      gtExtras::gt_theme_538() |>
      gt::tab_options(
        row_group.font.weight = "bold",
        footnotes.multiline = multiline,
        footnotes.font.size = "small"
      ) |>
      gt::opt_vertical_padding(scale = vertical_padding)

    gt::gtsave(table, glue::glue("table_{pheno}.png"))
    gt::gtsave(table, glue::glue("table_{pheno}.pdf"))

    return(table)
  }

#' @title Create Kable Table from Data
#' @description This function creates a kable table from a given data frame.
#' @param data The data frame to be used for creating the kable table.
#' @return A kable table in LaTeX format.
#' @details This function uses the kableExtra package to create the kable table with the following specifications: lightable_options = "basic", latex_options = c("scale_down", "HOLD_position", "striped"), width of the first column is set to 8cm, rows are packed based on a table of the data's Test column, and the first row is set to bold. Additionally, a footnote is added at the end of the table.
#' @rdname tbl_kbl
#' @export
#' @importFrom kableExtra kbl kable_paper kable_styling column_spec pack_rows row_spec footnote
tbl_kbl <- function(data) {
  # kable
  kableExtra::kbl(
    data[, 1:4],
    "latex",
    longtable = FALSE,
    booktabs = TRUE,
    linesep = "",
    align = c("lccc")
  ) |>
    kableExtra::kable_paper(lightable_options = "basic") |>
    kableExtra::kable_styling(latex_options = c("scale_down", "HOLD_position", "striped")) |>
    kableExtra::column_spec(1, width = "8cm") |>
    kableExtra::pack_rows(index = table(data$Test)) |>
    kableExtra::row_spec(row = 0, bold = TRUE) |>
    kableExtra::footnote("Note: Standard scores have a mean of 50 and a standard deviation of 10, and higher scores reflect reduced functioning. Standard scores have a mean of 100 and a standard deviation of 15, and lower scores reflect reduced functioning.",
      general_title = "", threeparttable = TRUE,
      escape = F, footnote_as_chunk = TRUE
    )
}

#' @title Create Markdown Table for Typst
#' @description Create a markdown table from a data frame for Typst.
#' @param data A data frame.
#' @param caption A caption for the table.
#' @return A markdown table.
#' @details This function creates a markdown table from a data frame.
#' @rdname tbl_md_typ
#' @export
#' @importFrom kableExtra kbl
tbl_md_typ <- function(data, caption = NULL) {
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
      col.names = c(
        "**Scale**",
        "**Score**",
        "**\u2030 Rank**",
        "**Range**"
      ),
      caption = caption
    )

  data
}

#' @title Make a Tibble for Plots
#' @description Create a tibble with columns specified in 'columns', and set column names to 'names'.
#' @param data A data.frame/dataset, Default: '.'
#' @param domain A character string indicating the domain of interest, Default: NULL
#' @param columns A character vector of column names to be included in the tibble, Default: c("scale", "score", "percentile", "range", "subdomain", "test_name")
#' @param percentile A numeric vector indicating the percentile values to be truncated, Default: NULL
#' @param round A numeric vector indicating the number of digits to round to, Default: 0
#' @param names A character vector of column names to be set in the tibble, Default: NULL
#' @param ... Additional arguments to be passed to the function.
#' @return A tibble with columns specified in 'columns', and set column names to 'names'.
#' @rdname make_tibble
#' @export
#' @importFrom dplyr filter select mutate
#' @importFrom tidyselect all_of
#' @importFrom purrr set_names
make_tibble <- function(data,
                        domain,
                        columns = c(
                          "scale",
                          "score",
                          "percentile",
                          "range",
                          "subdomain",
                          "test_name"
                        ),
                        percentile = NULL,
                        round = 0,
                        names = c(
                          "Scale",
                          "Score",
                          "\u2030 Rank",
                          "Range",
                          "Subdomain",
                          "Test"
                        ),
                        ...) {
  # Filter data based on the phenotype of interest
  tibb <-
    dplyr::filter(data, domain == domain) |>
    dplyr::select(tidyselect::all_of(columns)) |>
    dplyr::mutate(percentile = round(percentile, digits = round)) |>
    purrr::set_names(names)

  return(tibb)
}

#' @title Use Excel Index Scores to Create "g.csv"
#' @description Get 'g' from index scores
#' @param data Dataset
#' @param patient Patient name
#' @param scales A character vector of scale names
#' @param index_score_file Index score file
#' @return A csv file of g
#' @rdname generate_g
#' @export
#' @importFrom readxl read_xlsx
#' @importFrom here here
#' @importFrom janitor clean_names
#' @importFrom glue glue
#' @importFrom readr write_csv
generate_g <- function(data, patient, scales, index_score_file) {
  # Scales to include
  scales <- c(
    "Academic Skills",
    "Attention",
    "Attention/Executive",
    "Attentional Fluency",
    "Cognitive Efficiency",
    "Cognitive Proficiency",
    "Crystallized Knowledge",
    "Delayed Recall",
    "Executive Functions",
    "Verbal Fluency",
    "Fluid Reasoning",
    "General Ability",
    "Learning Efficiency",
    "Memory",
    "Planning",
    "Processing Speed",
    "Psychomotor Speed",
    "Verbal/Language",
    "Visual Perception/Construction",
    "Working Memory",
    "Full Scale IQ (FSIQ)",
    "General Ability (GAI)",
    "Verbal Comprehension (VCI)",
    "Perceptual Reasoning (PRI)",
    "Working Memory (WMI)",
    "Processing Speed (PSI)"
  )

  data <-
    data.frame(
      readxl::read_excel(index_score_file) |>
        janitor::clean_names() |>
        dplyr::mutate(z = (index - 100) / 15) |>
        dplyr::filter(composite_name %in% scales) |>
        dplyr::filter(!is.na(z))
    )

  names <-
    c(
      "scale",
      "score",
      "scaled_score",
      "t_score",
      "percentile",
      "reliability",
      "ci_95",
      "composition"
    )
  names(data) <- names

  ## Mutate columns
  data <- gpluck_make_columns(
    data,
    test = "index",
    test_name = "Composite Scores",
    raw_score = "",
    range = "",
    domain = "General Cognitive Ability",
    subdomain = "",
    narrow = "",
    pass = "",
    verbal = "",
    timed = "",
    test_type = "npsych_test",
    score_type = "standard_score",
    absort = "",
    description = "",
    result = ""
  )

  ## Test score ranges
  data <- gpluck_make_score_ranges(data, test_type = "npsych_test")

  ## Subdomains
  data <-
    dplyr::mutate(
      data,
      subdomain = dplyr::case_when(
        scale == "General Ability" ~ "General Intelligence",
        scale == "Crystallized Knowledge" ~ "General Intelligence",
        scale == "Fluid Reasoning" ~ "General Intelligence",
        scale == "Cognitive Proficiency" ~ "Cognitive Proficiency",
        scale == "Working Memory" ~ "Cognitive Proficiency",
        scale == "Processing Speed" ~ "Cognitive Proficiency",
        TRUE ~ as.character(subdomain)
      )
    )

  ## Narrow subdomain

  data <-
    data |>
    dplyr::mutate(
      narrow = dplyr::case_when(
        scale == "General Ability" ~ "General Intelligence",
        scale == "Crystallized Knowledge" ~ "Crystallized Intelligence",
        scale == "Fluid Reasoning" ~ "Fluid Intelligence",
        scale == "Cognitive Proficiency" ~ "Cognitive Proficiency",
        scale == "Working Memory" ~ "Working Memory",
        scale == "Processing Speed" ~ "Processing Speed",
        TRUE ~ as.character(narrow)
      )
    )

  ## PASS model

  data <-
    data |>
    dplyr::mutate(
      pass = dplyr::case_when(
        scale == "General Ability" ~ "",
        scale == "Crystallized Knowledge" ~ "",
        scale == "Fluid Reasoning" ~ "",
        scale == "Cognitive Proficiency" ~ "",
        scale == "Working Memory" ~ "",
        scale == "Processing Speed" ~ "",
        TRUE ~ as.character(pass)
      )
    )

  ## Verbal vs Nonverbal

  data <-
    data |>
    dplyr::mutate(
      verbal = dplyr::case_when(
        scale == "General Ability" ~ "",
        scale == "Crystallized Knowledge" ~ "Verbal",
        scale == "Fluid Reasoning" ~ "Nonverbal",
        scale == "Cognitive Proficiency" ~ "",
        scale == "Working Memory" ~ "Verbal",
        scale == "Processing Speed" ~ "Nonverbal",
        TRUE ~ as.character(verbal)
      )
    )

  ## Timed vs Untimed

  data <-
    data |>
    dplyr::mutate(
      timed = dplyr::case_when(
        scale == "General Ability" ~ "",
        scale == "Crystallized Knowledge" ~ "Untimed",
        scale == "Fluid Reasoning" ~ "Timed",
        scale == "Cognitive Proficiency" ~ "",
        scale == "Working Memory" ~ "Untimed",
        scale == "Processing Speed" ~ "Timed",
        TRUE ~ as.character(timed)
      )
    )

  ## Scale descriptions

  data <-
    data |>
    dplyr::mutate(
      description = dplyr::case_when(
        scale == "General Ability" ~ "An estimate of higher cognitive reasoning and acquired knowledge (*g*)",
        scale == "Crystallized Knowledge" ~ "Crystallized intelligence (*G*c)",
        scale ==
          "Fluid Reasoning" ~
          "An estimate of fluid intelligence (*G*f)",
        scale ==
          "Cognitive Proficiency" ~
          "A composite estimate of working memory and processing speed (i.e., cognitive proficiency)",
        scale ==
          "Working Memory" ~
          "An estimate of working memory capacity",
        scale ==
          "Processing Speed" ~
          "Collective performance across measures of processing speed and cognitive efficiency",
        scale ==
          "Full Scale IQ (FSIQ)" ~
          "General Intelligence (*g*)",
        scale ==
          "General Ability (GAI)" ~
          "General Intelligence (*g*)",
        scale ==
          "Verbal Comprehension (VCI)" ~
          "An estimate of crystallized knowledge (*G*c)",
        scale ==
          "Perceptual Reasoning (PRI)" ~
          "An estimate of fluid intelligence (*G*f)",
        scale ==
          "Working Memory (WMI)" ~
          "An estimate of working memory",
        scale ==
          "Processing Speed (PSI)" ~
          "Collective performance across measures of processing speed and cognitive efficiency",
        TRUE ~ as.character(description)
      )
    )

  ## Glue result

  data <-
    data |>
    dplyr::mutate(
      result = dplyr::case_when(
        scale == "General Ability" ~ glue::glue(
          "{description} was {range} and ranked at the {percentile}th percentile, indicating performance as good as or better than {percentile}% of same-age peers from the general population.\n"
        ),
        scale == "Crystallized Knowledge" ~ glue::glue(
          "{description} was classified as {range} and ranked at the {percentile}th percentile.\n"
        ),
        scale == "Fluid Reasoning" ~ glue::glue("{description} was classified as {range}.\n"),
        scale == "Cognitive Proficiency" ~ glue::glue("{description} was {range}.\n"),
        scale == "Working Memory" ~ glue::glue("{description} fell in the {range} range.\n"),
        scale == "Processing Speed" ~ glue::glue("{description} was {range}.\n")
      )
    )

  ## Relocate variables

  data <-
    dplyr::relocate(data,
      c(raw_score, score, ci_95, percentile, range),
      .after = scale
    ) |>
    dplyr::relocate(c(scaled_score, t_score, reliability, composition), .after = result) |>
    dplyr::filter(
      scale %in% c(
        "General Ability",
        "Crystallized Knowledge",
        "Fluid Reasoning",
        "Cognitive Proficiency",
        "Working Memory",
        "Processing Speed"
      )
    )

  ## Write out CSV

  readr::write_csv(
    data,
    here::here(patient, "data", "csv", "g.csv"),
    append = FALSE,
    col_names = TRUE
  )
  return(data)
}

# footnotes
fn_scaled_score <- gt::md("Scaled score: Mean = 10 [50th\u2030], SD \u00B1 3 [16th\u2030, 84th\u2030]")
fn_standard_score <- gt::md("Standard score: Mean = 100 [50th\u2030], SD \u00B1 15 [16th\u2030, 84th\u2030]")
fn_t_score <- gt::md("_T_-score: Mean = 50 [50th\u2030], SD \u00B1 10 [16th\u2030, 84th\u2030]")
fn_z_score <- gt::md("_z_-score: Mean = 0 [50th\u2030], SD \u00B1 1 [16th\u2030, 84th\u2030]")
fn_raw_score <- gt::md("Raw score: Range = 1-4")
