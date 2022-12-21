#' Import/Tidy Excel Index Score File
#'
#' @param patient
#'
#' @return
#' @export
#'
#' @examples
bwu_import_index_score <- function(patient) {
  patient <- patient
  
  ## Import data
  
  df <-
    readxl::read_xlsx(here::here(patient, paste0(patient, "_", "index_scores.xlsx"))) |>
    janitor::clean_names()
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
  names(df) <- names
  df <- as.data.frame(df)
  
  ## Mutate columns
  
  df <- bwu::gpluck_make_columns(
    table = df,
    raw_score = "",
    range = "",
    test = "index",
    test_name = "Composite Scores",
    domain = "",
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
  
  df <-
    bwu::gpluck_make_score_ranges(table = df, test_type = "npsych_test")
  
  ## Domains
  
  df <-
    df |>
    tidytable::mutate(
      domain = tidytable::case_when(
        scale == "General Intelligence" ~ "Intelligence/General Ability",
        scale == "General Ability" ~ "Intelligence/General Ability",
        scale == "Cognitive Proficiency" ~ "Intelligence/General Ability",
        scale == "Crystallized Knowledge" ~ "Intelligence/General Ability",
        scale == "Fluid Reasoning" ~ "Intelligence/General Ability",
        scale == "Working Memory" ~ "Attention/Executive",
        scale == "Cognitive Efficiency" ~ "Attention/Executive",
        TRUE ~ as.character(domain)
      )
    )
  
  ## Subdomain
  
  df <-
    df |>
    tidytable::mutate(
      subdomain = tidytable::case_when(
        scale == "Crystallized Knowledge" ~ "Crystallized Intelligence",
        scale == "Fluid Reasoning" ~ "Fluid Intelligence",
        scale == "Working Memory" ~ "Working Memory",
        scale == "Cognitive Efficiency" ~ "Processing Speed",
        scale == "General Intelligence" ~ "General Intelligence",
        scale == "General Ability" ~ "General Intelligence",
        scale == "Cognitive Proficiency" ~ "General Intelligence",
        TRUE ~ as.character(subdomain)
      )
    )
  
  ## Narrow subdomain
  
  df <-
    df |>
    tidytable::mutate(
      narrow = tidytable::case_when(
        scale == "Crystallized Knowledge" ~ "Crystallized Intelligence",
        scale == "Fluid Reasoning" ~ "Fluid Intelligence",
        scale == "Working Memory" ~ "Working Memory",
        scale == "Cognitive Efficiency" ~ "Cognitive Efficiency",
        scale == "General Intelligence" ~ "General Intelligence",
        scale == "General Ability" ~ "General Intelligence",
        scale == "Cognitive Proficiency" ~ "General Intelligence",
        TRUE ~ as.character(narrow)
      )
    )
  
  ## PASS model
  
  df <-
    df |>
    tidytable::mutate(
      pass = tidytable::case_when(
        scale == "Crystallized Knowledge" ~ "",
        scale == "Fluid Reasoning" ~ "",
        scale == "Working Memory" ~ "",
        scale == "Cognitive Efficiency" ~ "",
        scale == "General Intelligence" ~ "",
        scale == "General Ability" ~ "",
        scale == "Cognitive Proficiency" ~ "",
        TRUE ~ as.character(pass)
      )
    )
  
  ## Verbal vs Nonverbal
  
  df <-
    df |>
    tidytable::mutate(
      verbal = tidytable::case_when(
        scale == "Crystallized Knowledge" ~ "Verbal",
        scale == "Fluid Reasoning" ~ "Nonverbal",
        scale == "Working Memory" ~ "Verbal",
        scale == "Cognitive Efficiency" ~ "Nonverbal",
        scale == "General Intelligence" ~ "",
        scale == "General Ability" ~ "",
        scale == "Cognitive Proficiency" ~ "",
        TRUE ~ as.character(verbal)
      )
    )
  
  ## Timed vs Untimed
  
  df <-
    df |>
    tidytable::mutate(
      timed = tidytable::case_when(
        scale == "Crystallized Knowledge" ~ "Untimed",
        scale == "Fluid Reasoning" ~ "Timed",
        scale == "Working Memory" ~ "Untimed",
        scale == "Cognitive Efficiency" ~ "Timed",
        scale == "General Intelligence" ~ "",
        scale == "General Ability" ~ "",
        scale == "Cognitive Proficiency" ~ "",
        TRUE ~ as.character(timed)
      )
    )
  
  ## Scale descriptions
  
  df <-
    df |>
    tidytable::mutate(
      description = tidytable::case_when(
        scale ==
          "General Intelligence" ~
          "General Intelligence (*G*)",
        scale ==
          "General Ability" ~
          "An estimate of general cognitive ability (*g*)",
        scale ==
          "Cognitive Proficiency" ~
          "A composite estimate of attentional fluency, working memory, and processing speed",
        scale ==
          "Crystallized Knowledge" ~
          "An estimate of crystallized intelligence (*G*c)",
        scale ==
          "Fluid Reasoning" ~
          "An estimate of fluid intelligence (*G*f)",
        scale ==
          "Working Memory" ~
          "A composite estimate of short-term working memory^[(ref:working-memory)]",
        scale ==
          "Cognitive Efficiency" ~
          "A composite estimate of complex processing speed and efficiency^[(ref:efficiency)]",
        TRUE ~ as.character(description)
      )
    )
  
  ## Glue result
  
  df <-
    df |>
    tidytable::mutate(
      result = tidytable::case_when(
        scale == "General Intelligence" ~ glue::glue("{description} was {range} overall.\n"),
        scale == "General Ability" ~ glue::glue(
          "{description} was {range} and ranked at the {percentile}th percentile, indicating performance as good as or better than {percentile}% of same-age peers from the general population.\n"
        ),
        scale == "Crystallized Knowledge" ~ glue::glue(
          "{description} was classified as {range} and ranked at the {percentile}th percentile.\n"
        ),
        scale == "Fluid Reasoning" ~ glue::glue(
          "{description} was classified as {range} and ranked at the {percentile}th percentile.\n"
        ),
        scale == "Working Memory" ~ glue::glue("{description} fell in the {range} range.\n"),
        scale == "Cognitive Efficiency" ~ glue::glue(
          "{description} was {range} and a relative strength|weakness.\n"
        ),
        scale == "Cognitive Proficiency" ~ glue::glue(
          "{description} was {range} and ranked at the {percentile}th percentile, indicating performance as good as or better than {percentile}% of same-age peers from the general population.\n"
        ),
        TRUE ~ as.character(result)
      )
    )
  
  ## Relocate variables
  
  g <-
    df |> tidytable::relocate(c(raw_score, score, percentile, range, ci_95), .before = test) |>
    tidytable::relocate(c(scaled_score, t_score, reliability, composition), .after = result)
  
  ## Write out CSV
  
  readr::write_csv(g,
                   here::here(patient, "csv", "g.csv"),
                   append = TRUE,
                   col_names = TRUE)
  
  
}
