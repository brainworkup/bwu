#' Import Neurocognitive Index Scores
#'
#' @param patient Name of patient
#'
#' @return A table
#' @export
#'
gpluck_get_index_score2 <- function(patient) {
  ## Import/Tidy Excel Index Score File

  patient <- patient

  ## Import data

  df <- readxl::read_xlsx(here::here(patient, "index_scores.xlsx")) |>
    janitor::clean_names()

  names <- c("scale", "score", "scaled_score", "t_score", "percentile", "reliability", "ci_95", "composition")

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

  df <- bwu::gpluck_make_score_ranges(table = df, test_type = "npsych_test")

  ## Domains

  df <-
    df |>
    dplyr::mutate(
      domain = dplyr::case_when(
        scale == "General Ability" ~ "Intelligence/General Ability",
        scale == "Cognitive Proficiency" ~ "Intelligence/General Ability",
        scale == "Crystallized Knowledge" ~ "Intelligence/General Ability",
        scale == "Fluid Reasoning" ~ "Intelligence/General Ability",
        scale == "Working Memory" ~ "Intelligence/General Ability",
        scale == "Processing Speed" ~ "Intelligence/General Ability",
        TRUE ~ as.character(domain)
      )
    )

  ## Subdomain

  df <-
    df |>
    dplyr::mutate(
      subdomain = dplyr::case_when(
        scale == "General Ability" ~ "General Intelligence",
        scale == "Cognitive Proficiency" ~ "Cognitive Proficiency",
        scale == "Crystallized Knowledge" ~ "General Intelligence",
        scale == "Fluid Reasoning" ~ "General Intelligence",
        scale == "Working Memory" ~ "Cognitive Proficiency",
        scale == "Processing Speed" ~ "Cognitive Proficiency",
        TRUE ~ as.character(subdomain)
      )
    )

  ## Narrow subdomain

  df <-
    df |>
    dplyr::mutate(
      narrow = dplyr::case_when(
        scale == "General Ability" ~ "General Ability",
        scale == "Cognitive Proficiency" ~ "Cognitive Proficiency",
        scale == "Crystallized Knowledge" ~ "Crystallized Knowledge",
        scale == "Fluid Reasoning" ~ "Fluid Reasoning",
        scale == "Working Memory" ~ "Working Memory",
        scale == "Processing Speed" ~ "Processing Speed",
        TRUE ~ as.character(narrow)
      )
    )

  ## PASS model

  df <-
    df |>
    dplyr::mutate(
      pass = dplyr::case_when(
        scale == "General Ability" ~ "",
        scale == "Cognitive Proficiency" ~ "",
        scale == "Crystallized Knowledge" ~ "",
        scale == "Fluid Reasoning" ~ "",
        scale == "Working Memory" ~ "",
        scale == "Processing Speed" ~ "",
        TRUE ~ as.character(pass)
      )
    )

  ## Verbal vs Nonverbal

  df <-
    df |>
    dplyr::mutate(
      verbal = dplyr::case_when(
        scale == "General Ability" ~ "",
        scale == "Cognitive Proficiency" ~ "",
        scale == "Crystallized Knowledge" ~ "Verbal",
        scale == "Fluid Reasoning" ~ "Nonverbal",
        scale == "Working Memory" ~ "Verbal",
        scale == "Processing Speed" ~ "Nonverbal",
        TRUE ~ as.character(verbal)
      )
    )

  ## Timed vs Untimed

  df <-
    df |>
    dplyr::mutate(
      timed = dplyr::case_when(
        scale == "General Ability" ~ "",
        scale == "Cognitive Proficiency" ~ "",
        scale == "Crystallized Knowledge" ~ "Untimed",
        scale == "Fluid Reasoning" ~ "Timed",
        scale == "Working Memory" ~ "Untimed",
        scale == "Processing Speed" ~ "Timed",
        TRUE ~ as.character(timed)
      )
    )

  ## Scale descriptions

  df <-
    df |>
    dplyr::mutate(
      description = dplyr::case_when(
        scale ==
          "General Ability" ~
          "An estimate of higher cognitive reasoning and acquired knowledge (*g*)",
        scale ==
          "Cognitive Proficiency" ~
          "A composite estimate of working memory^[(ref:working-memory)] and processing speed^[(ref:processing-speed)] (i.e., *attentional fluency*)",
        scale ==
          "Crystallized Knowledge" ~
          "Crystallized intelligence (*G*c)",
        scale ==
          "Fluid Reasoning" ~
          "An estimate of fluid intelligence (*G*f)",
        scale ==
          "Working Memory" ~
          "A composite estimate of short-term working memory^[(ref:working-memory)]",
        scale ==
          "Processing Speed" ~
          "A composite estimate of complex processing speed and efficiency^[(ref:processing-speed)]",
        TRUE ~ as.character(description)
      )
    )

  ## Glue result

  df <-
    df |>
    dplyr::mutate(
      result = dplyr::case_when(
        scale == "General Ability" ~ glue::glue(
          "{description} was {range} and ranked at the {percentile}th percentile, indicating performance as good as or better than {percentile}% of same-age peers from the general population.\n"
        ),
        scale == "Cognitive Proficiency" ~ glue::glue(
          "{description} was {range} and a relative strength|weakness.\n"
        ),
        scale == "Crystallized Knowledge" ~ glue::glue(
          "{description} was classified as {range} and ranked at the {percentile}th percentile.\n"
        ),
        scale == "Fluid Reasoning" ~ glue::glue(
          "{description} was classified as {range}.\n"
        ),
        scale == "Working Memory" ~ glue::glue("{description} fell in the {range} range and was and a relative strength|weakness.\n"
        ),
        scale == "Processing Speed" ~ glue::glue(
          "{description} was {range} and a relative strength|weakness.\n"
        ),
        TRUE ~ as.character(result)
      )
    )

  ## Relocate variables

  g <-
    df |>
    dplyr::relocate(
      c(raw_score, score, percentile, range, ci_95), .before = test) |>
    dplyr::relocate(
      c(scaled_score, t_score, reliability, composition), .after = result) |>
    dplyr::filter(scale %in% c("General Ability", "Cognitive Proficiency", "Crystallized Knowledge", "Fluid Reasoning", "Working Memory", "Processing Speed"))

  ## Write out CSV

  readr::write_csv(g, here::here(patient, "csv", "g.csv"), append = FALSE, col_names = TRUE)
}
