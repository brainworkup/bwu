#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param file PARAM_DESCRIPTION
#' @param pages PARAM_DESCRIPTION, Default: NULL
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @seealso
#'  \code{\link[tabulizer]{locate_areas}}
#' @rdname gpluck_locate_areas
#' @export
#' @importFrom tabulizer locate_areas
gpluck_locate_areas <- function(file, pages = NULL, ...) {
  tabulizer::locate_areas(
    file = file,
    pages = pages,
    ...
  )
}


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param file PARAM_DESCRIPTION
#' @param pages PARAM_DESCRIPTION, Default: NULL
#' @param area PARAM_DESCRIPTION, Default: NULL
#' @param guess PARAM_DESCRIPTION, Default: FALSE
#' @param method PARAM_DESCRIPTION, Default: c("decide", "lattice", "stream")
#' @param output PARAM_DESCRIPTION, Default: c("matrix", "data.frame", "character", "asis", "csv", "tsv",
#'    "json")
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @seealso
#'  \code{\link[tabulizer]{extract_tables}}
#' @rdname gpluck_extract_table
#' @export
#' @importFrom tabulizer extract_tables
gpluck_extract_table <-
  function(file,
           pages = NULL,
           area = NULL,
           guess = FALSE,
           method = c("decide", "lattice", "stream"),
           output = c(
             "matrix",
             "data.frame",
             "character",
             "asis",
             "csv",
             "tsv",
             "json"
           ),
           ...) {
    tabulizer::extract_tables(
      file = file,
      pages = pages,
      area = area,
      guess = match.arg(guess),
      method = match.arg(method),
      output = match.arg(output)
    )
  }


#' @title Make columns.
#' @description Make columns.
#' @param table PARAM_DESCRIPTION
#' @param test PARAM_DESCRIPTION
#' @param test_name PARAM_DESCRIPTION
#' @param scale PARAM_DESCRIPTION, Default: NULL
#' @param raw_score PARAM_DESCRIPTION, Default: NULL
#' @param score PARAM_DESCRIPTION, Default: NULL
#' @param range PARAM_DESCRIPTION, Default: NULL
#' @param percentile PARAM_DESCRIPTION, Default: NULL
#' @param ci_95 PARAM_DESCRIPTION, Default: NULL
#' @param domain PARAM_DESCRIPTION, Default: c("Intelligence/General Ability", "Academic Skills", "Verbal/Language",
#'    "Visual Perception/Construction", "Attention/Executive",
#'    "Memory", "Motor", "Social Cognition", "Behavioral/Emotional/Social",
#'    "Personality Disorders", "Psychiatric Disorders", "Substance Use Disorders",
#'    "Psychosocial Problems", "ADHD", "Executive Dysfunction",
#'    "Effort/Validity", "")
#' @param subdomain PARAM_DESCRIPTION, Default: NULL
#' @param narrow PARAM_DESCRIPTION, Default: NULL
#' @param pass PARAM_DESCRIPTION, Default: c("Planning", "Attention", "Sequential", "Simultaneous", "Knowledge",
#'    NA)
#' @param verbal PARAM_DESCRIPTION, Default: c("Verbal", "Nonverbal", NA)
#' @param timed PARAM_DESCRIPTION, Default: c("Timed", "Untimed", NA)
#' @param test_type PARAM_DESCRIPTION, Default: c("npsych_test", "rating_scale", "validity_indicator", "item",
#'    NA)
#' @param score_type PARAM_DESCRIPTION, Default: c("raw_score", "scaled_score", "t_score", "standard_score", "z_score",
#'    "percentile", "base_rate", "beta_coefficient", NA)
#' @param absort PARAM_DESCRIPTION, Default: NULL
#' @param description PARAM_DESCRIPTION, Default: NULL
#' @param result PARAM_DESCRIPTION, Default: NULL
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @rdname gpluck_make_columns
#' @export
gpluck_make_columns <- function(table,
                                test,
                                test_name,
                                scale = NULL,
                                raw_score = NULL,
                                score = NULL,
                                range = NULL,
                                percentile = NULL,
                                ci_95 = NULL,
                                domain = c(
                                  "Intelligence/General Ability",
                                  "Academic Skills",
                                  "Verbal/Language",
                                  "Visual Perception/Construction",
                                  "Attention/Executive",
                                  "Memory",
                                  "Motor",
                                  "Social Cognition",
                                  "Behavioral/Emotional/Social",
                                  "Personality Disorders",
                                  "Psychiatric Disorders",
                                  "Substance Use Disorders",
                                  "Psychosocial Problems",
                                  "ADHD",
                                  "Executive Dysfunction",
                                  "Effort/Validity",
                                  ""
                                ),
                                subdomain = NULL,
                                narrow = NULL,
                                pass = c(
                                  "Planning",
                                  "Attention",
                                  "Sequential",
                                  "Simultaneous",
                                  "Knowledge",
                                  NA
                                ),
                                verbal = c(
                                  "Verbal",
                                  "Nonverbal",
                                  NA
                                ),
                                timed = c(
                                  "Timed",
                                  "Untimed",
                                  NA
                                ),
                                test_type = c(
                                  "npsych_test",
                                  "rating_scale",
                                  "validity_indicator",
                                  "item",
                                  NA
                                ),
                                score_type = c(
                                  "raw_score",
                                  "scaled_score",
                                  "t_score",
                                  "standard_score",
                                  "z_score",
                                  "percentile",
                                  "base_rate",
                                  "beta_coefficient",
                                  NA
                                ),
                                absort = NULL,
                                description = NULL,
                                result = NULL,
                                ...) {
  table <-
    dplyr::mutate(
      table,
      scale = scale,
      raw_score = raw_score,
      score = score,
      range = range,
      percentile = percentile,
      ci_95 = ci_95,
      test = test,
      test_name = test_name,
      domain = domain,
      subdomain = subdomain,
      narrow = narrow,
      pass = pass,
      verbal = verbal,
      timed = timed,
      test_type = test_type,
      score_type = score_type,
      absort =
        paste0(
          tolower(test),
          "_", tolower(scale),
          "_", seq_len(nrow(table))
        ),
      description = description,
      result = result,
      ...
    )
}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param table PARAM_DESCRIPTION
#' @param score PARAM_DESCRIPTION, Default: NULL
#' @param percentile PARAM_DESCRIPTION, Default: NULL
#' @param range PARAM_DESCRIPTION, Default: range
#' @param test_type PARAM_DESCRIPTION, Default: c("npsych_test", "rating_scale", "validity_indicator", "basc3")
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @rdname gpluck_make_score_ranges
#' @export
gpluck_make_score_ranges <-
  function(table,
           score = NULL,
           percentile = NULL,
           range = range,
           test_type = c(
             "npsych_test",
             "rating_scale",
             "validity_indicator",
             "basc3"
           ),
           ...) {
    if (test_type == "npsych_test") {
      table <-
        table %>%
        dplyr::mutate(
          range = dplyr::case_when(
            percentile >= 98 ~ "Exceptionally High",
            percentile %in% 91:97 ~ "Above Average",
            percentile %in% 75:90 ~ "High Average",
            percentile %in% 25:74 ~ "Average",
            percentile %in% 9:24 ~ "Low Average",
            percentile %in% 2:8 ~ "Below Average",
            percentile < 2 ~ "Exceptionally Low",
            TRUE ~ as.character(range)
          )
        )
    } else if (test_type == "rating_scale") {
      table <-
        table %>%
        dplyr::mutate(
          range = dplyr::case_when(
            percentile >= 98 ~ "Exceptionally High",
            percentile %in% 91:97 ~ "Above Average",
            percentile %in% 75:90 ~ "High Average",
            percentile %in% 25:74 ~ "Average",
            percentile %in% 9:24 ~ "Low Average",
            percentile %in% 2:8 ~ "Below Average",
            percentile < 2 ~ "Exceptionally Low",
            TRUE ~ as.character(range)
          )
        )
    } else if (test_type == "performance_validity") {
      table <-
        table %>%
        dplyr::mutate(
          range = dplyr::case_when(
            percentile >= 25 ~ "Within Normal Limits Score",
            percentile %in% 9:24 ~ "Low Average Score",
            percentile %in% 2:8 ~ "Below Average Score",
            percentile < 2 ~ "Exceptionally Low Score",
            TRUE ~ as.character(range)
          )
        )
    } else if (test_type == "symptom_validity") {
      table <-
        table %>%
        dplyr::mutate(
          range = dplyr::case_when(
            percentile >= 98 ~ "Exceptionally High Score",
            percentile %in% 91:97 ~ "Above Average Score",
            percentile %in% 75:90 ~ "High Average Score",
            percentile %in% 25:74 ~ "Within Normal Limits Score",
            percentile %in% 9:24 ~ "Low Average Score",
            percentile %in% 2:8 ~ "Below Average Score",
            percentile < 2 ~ "Exceptionally Low Score",
            TRUE ~ as.character(range)
          )
        )
    } else if (test_type == "basc3") {
      table <-
        table %>%
        dplyr::mutate(
          range = dplyr::case_when(
            score >= 60 & subdomain %in% c("Adaptive Skills", "Personal Adjustment") ~ "Strength",
            score %in% 40:59 & subdomain %in% c("Adaptive Skills", "Personal Adjustment") ~ "Within Normal Limits",
            score %in% 30:39 &
              subdomain %in% c("Adaptive Skills", "Personal Adjustment") ~ "Mildly Elevated",
            score %in% 20:29 &
              subdomain %in% c("Adaptive Skills", "Personal Adjustment") ~ "Significantly Elevated",
            score <= 29 &
              subdomain %in% c("Adaptive Skills", "Personal Adjustment") ~ "Markedly Elevated",
            score >= 80 &
              subdomain != c("Adaptive Skills", "Personal Adjustment") ~ "Markedly Elevated",
            score %in% 70:79 &
              subdomain != c("Adaptive Skills", "Personal Adjustment") ~ "Significantly Elevated",
            score %in% 60:69 &
              subdomain != c("Adaptive Skills", "Personal Adjustment") ~ "Mildly Elevated",
            score %in% 40:59 &
              subdomain != c("Adaptive Skills", "Personal Adjustment") ~ "Within Normal Limits",
            score <= 39 &
              subdomain != c("Adaptive Skills", "Personal Adjustment") ~ "Strength",
            TRUE ~ as.character(range)
          )
        )
    }
  }

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param .x PARAM_DESCRIPTION
#' @param .score PARAM_DESCRIPTION, Default: NA
#' @param .score_type PARAM_DESCRIPTION, Default: c("z_score", "scaled_score", "t_score", "standard_score")
#' @param percentile PARAM_DESCRIPTION, Default: NA
#' @param range PARAM_DESCRIPTION, Default: NA
#' @param pct1 PARAM_DESCRIPTION, Default: NA
#' @param pct2 PARAM_DESCRIPTION, Default: NA
#' @param pct3 PARAM_DESCRIPTION, Default: NA
#' @param z PARAM_DESCRIPTION, Default: NA
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @rdname gpluck_compute_percentile_range
#' @export
#' @importFrom stats pnorm
gpluck_compute_percentile_range <-
  function(.x,
           .score = NA,
           .score_type =
             c("z_score", "scaled_score", "t_score", "standard_score"),
           percentile = NA,
           range = NA,
           pct1 = NA,
           pct2 = NA,
           pct3 = NA,
           z = NA,
           ...) {
    if (.score_type == "z_score") {
      .x <-
        .x |>
        dplyr::mutate(z = (.score - 0) / 1) %>%
        dplyr::mutate(pct1 = round(stats::pnorm(z) * 100, 1)) %>%
        dplyr::mutate(pct2 = dplyr::case_when(
          pct1 < 1 ~ ceiling(pct1),
          pct1 > 99 ~ floor(pct1),
          TRUE ~ round(pct1)
        )) %>%
        dplyr::mutate(pct3 = pct2) %>%
        dplyr::mutate(
          range = dplyr::case_when(
            pct3 >= 98 ~ "Exceptionally High",
            pct3 %in% 91:97 ~ "Above Average",
            pct3 %in% 75:90 ~ "High Average",
            pct3 %in% 25:74 ~ "Average",
            pct3 %in% 9:24 ~ "Low Average",
            pct3 %in% 2:8 ~ "Below Average",
            pct3 < 2 ~ "Exceptionally Low",
            TRUE ~ as.character(range)
          )
        ) %>%
        dplyr::mutate(percentile = pct1) %>%
        dplyr::select(-c(pct1, pct2, pct3))
    } else if (.score_type == "scaled_score") {
      .x <-
        .x |>
        dplyr::mutate(z = (.score - 10) / 3) %>%
        dplyr::mutate(pct1 = round(stats::pnorm(z) * 100, 1)) %>%
        dplyr::mutate(pct2 = dplyr::case_when(
          pct1 < 1 ~ ceiling(pct1),
          pct1 > 99 ~ floor(pct1),
          TRUE ~ round(pct1)
        )) %>%
        dplyr::mutate(pct3 = pct2) %>%
        dplyr::mutate(
          range = dplyr::case_when(
            pct3 >= 98 ~ "Exceptionally High",
            pct3 %in% 91:97 ~ "Above Average",
            pct3 %in% 75:90 ~ "High Average",
            pct3 %in% 25:74 ~ "Average",
            pct3 %in% 9:24 ~ "Low Average",
            pct3 %in% 2:8 ~ "Below Average",
            pct3 < 2 ~ "Exceptionally Low",
            TRUE ~ as.character(range)
          )
        ) %>%
        dplyr::mutate(percentile = pct1) %>%
        dplyr::select(-c(pct1, pct2, pct3))
    } else if (.score_type == "t_score") {
      .x <-
        .x |>
        dplyr::mutate(z = (.score - 50) / 10) %>%
        dplyr::mutate(pct1 = round(stats::pnorm(z) * 100, 1)) %>%
        dplyr::mutate(pct2 = dplyr::case_when(
          pct1 < 1 ~ ceiling(pct1),
          pct1 > 99 ~ floor(pct1),
          TRUE ~ round(pct1)
        )) %>%
        dplyr::mutate(pct3 = pct2) %>%
        dplyr::mutate(
          range = dplyr::case_when(
            pct3 >= 98 ~ "Exceptionally High",
            pct3 %in% 91:97 ~ "Above Average",
            pct3 %in% 75:90 ~ "High Average",
            pct3 %in% 25:74 ~ "Average",
            pct3 %in% 9:24 ~ "Low Average",
            pct3 %in% 2:8 ~ "Below Average",
            pct3 < 2 ~ "Exceptionally Low",
            TRUE ~ as.character(range)
          )
        ) %>%
        dplyr::mutate(percentile = pct1) %>%
        dplyr::select(-c(pct1, pct2, pct3))
    } else if (.score_type == "standard_score") {
      .x <-
        .x |>
        dplyr::mutate(z = (.score - 100) / 15) %>%
        dplyr::mutate(pct1 = round(stats::pnorm(z) * 100, 1)) %>%
        dplyr::mutate(pct2 = dplyr::case_when(
          pct1 < 1 ~ ceiling(pct1),
          pct1 > 99 ~ floor(pct1),
          TRUE ~ round(pct1)
        )) %>%
        dplyr::mutate(pct3 = pct2) %>%
        dplyr::mutate(
          range = dplyr::case_when(
            pct3 >= 98 ~ "Exceptionally High",
            pct3 %in% 91:97 ~ "Above Average",
            pct3 %in% 75:90 ~ "High Average",
            pct3 %in% 25:74 ~ "Average",
            pct3 %in% 9:24 ~ "Low Average",
            pct3 %in% 2:8 ~ "Below Average",
            pct3 < 2 ~ "Exceptionally Low",
            TRUE ~ as.character(range)
          )
        ) %>%
        dplyr::mutate(percentile = pct1) %>%
        dplyr::select(-c(pct1, pct2, pct3))
    }
  }


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param .x PARAM_DESCRIPTION
#' @param .score PARAM_DESCRIPTION, Default: NA
#' @param .score_type PARAM_DESCRIPTION, Default: c("z_score", "scaled_score", "t_score", "standard_score", "raw_score")
#' @param percentile PARAM_DESCRIPTION, Default: NA
#' @param range PARAM_DESCRIPTION, Default: NA
#' @param pct1 PARAM_DESCRIPTION, Default: NA
#' @param pct2 PARAM_DESCRIPTION, Default: NA
#' @param pct3 PARAM_DESCRIPTION, Default: NA
#' @param z PARAM_DESCRIPTION, Default: NA
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @rdname compute_pctile_range
#' @export
#' @importFrom stats pnorm
compute_pctile_range <-
  function(.x,
           .score = NA,
           .score_type =
             c("z_score", "scaled_score", "t_score", "standard_score", "raw_score"),
           percentile = NA,
           range = NA,
           pct1 = NA,
           pct2 = NA,
           pct3 = NA,
           z = NA,
           ...) {
    if (.score_type == "z_score") {
      .x <-
        .x |>
        dplyr::mutate(z = (.score - 0) / 1) %>%
        dplyr::mutate(pct1 = round(stats::pnorm(z) * 100, 1)) %>%
        dplyr::mutate(pct2 = dplyr::case_when(
          pct1 < 1 ~ ceiling(pct1),
          pct1 > 99 ~ floor(pct1),
          TRUE ~ round(pct1)
        )) %>%
        dplyr::mutate(pct3 = pct2) %>%
        dplyr::mutate(
          range = dplyr::case_when(
            pct3 >= 98 ~ "Exceptionally High",
            pct3 %in% 91:97 ~ "Above Average",
            pct3 %in% 75:90 ~ "High Average",
            pct3 %in% 25:74 ~ "Average",
            pct3 %in% 9:24 ~ "Low Average",
            pct3 %in% 2:8 ~ "Below Average",
            pct3 < 2 ~ "Exceptionally Low",
            TRUE ~ as.character(range)
          )
        ) %>%
        dplyr::mutate(percentile = pct1) %>%
        dplyr::select(-c(pct1, pct2, pct3))
    } else if (.score_type == "scaled_score") {
      .x <-
        .x |>
        dplyr::mutate(z = (.score - 10) / 3) %>%
        dplyr::mutate(pct1 = round(stats::pnorm(z) * 100, 1)) %>%
        dplyr::mutate(pct2 = dplyr::case_when(
          pct1 < 1 ~ ceiling(pct1),
          pct1 > 99 ~ floor(pct1),
          TRUE ~ round(pct1)
        )) %>%
        dplyr::mutate(pct3 = pct2) %>%
        dplyr::mutate(
          range = dplyr::case_when(
            pct3 >= 98 ~ "Exceptionally High",
            pct3 %in% 91:97 ~ "Above Average",
            pct3 %in% 75:90 ~ "High Average",
            pct3 %in% 25:74 ~ "Average",
            pct3 %in% 9:24 ~ "Low Average",
            pct3 %in% 2:8 ~ "Below Average",
            pct3 < 2 ~ "Exceptionally Low",
            TRUE ~ as.character(range)
          )
        ) %>%
        dplyr::mutate(percentile = pct1) %>%
        dplyr::select(-c(pct1, pct2, pct3))
    } else if (.score_type == "t_score") {
      .x <-
        .x |>
        dplyr::mutate(z = (.score - 50) / 10) %>%
        dplyr::mutate(pct1 = round(stats::pnorm(z) * 100, 1)) %>%
        dplyr::mutate(pct2 = dplyr::case_when(
          pct1 < 1 ~ ceiling(pct1),
          pct1 > 99 ~ floor(pct1),
          TRUE ~ round(pct1)
        )) %>%
        dplyr::mutate(pct3 = pct2) %>%
        dplyr::mutate(
          range = dplyr::case_when(
            pct3 >= 98 ~ "Exceptionally High",
            pct3 %in% 91:97 ~ "Above Average",
            pct3 %in% 75:90 ~ "High Average",
            pct3 %in% 25:74 ~ "Average",
            pct3 %in% 9:24 ~ "Low Average",
            pct3 %in% 2:8 ~ "Below Average",
            pct3 < 2 ~ "Exceptionally Low",
            TRUE ~ as.character(range)
          )
        ) %>%
        dplyr::mutate(percentile = pct1) %>%
        dplyr::select(-c(pct1, pct2, pct3))
    } else if (.score_type == "standard_score") {
      .x <-
        .x |>
        dplyr::mutate(z = (.score - 100) / 15) %>%
        dplyr::mutate(pct1 = round(stats::pnorm(z) * 100, 1)) %>%
        dplyr::mutate(pct2 = dplyr::case_when(
          pct1 < 1 ~ ceiling(pct1),
          pct1 > 99 ~ floor(pct1),
          TRUE ~ round(pct1)
        )) %>%
        dplyr::mutate(pct3 = pct2) %>%
        dplyr::mutate(
          range = dplyr::case_when(
            pct3 >= 98 ~ "Exceptionally High",
            pct3 %in% 91:97 ~ "Above Average",
            pct3 %in% 75:90 ~ "High Average",
            pct3 %in% 25:74 ~ "Average",
            pct3 %in% 9:24 ~ "Low Average",
            pct3 %in% 2:8 ~ "Below Average",
            pct3 < 2 ~ "Exceptionally Low",
            TRUE ~ as.character(range)
          )
        ) %>%
        dplyr::mutate(percentile = pct1) %>%
        dplyr::select(-c(pct1, pct2, pct3))
    } else if (.score_type == "raw_score") {
      .x <-
        .x |>
        dplyr::mutate(z = (.score - mean(raw_score)) / sd(raw_score)) %>%
        dplyr::mutate(pct1 = round(stats::pnorm(z) * 100, 1)) %>%
        dplyr::mutate(pct2 = dplyr::case_when(
          pct1 < 1 ~ ceiling(pct1),
          pct1 > 99 ~ floor(pct1),
          TRUE ~ round(pct1)
        )) %>%
        dplyr::mutate(pct3 = pct2) %>%
        dplyr::mutate(
          range = dplyr::case_when(
            pct3 >= 25 ~ "Within Normal Limits Score",
            pct3 %in% 9:24 ~ "Low Average Score",
            pct3 %in% 2:8 ~ "Below Average Score",
            pct3 < 2 ~ "Exceptionally Low Score",
            TRUE ~ as.character(range)
          )
        ) %>%
        dplyr::mutate(percentile = pct1) %>%
        dplyr::select(-c(pct1, pct2, pct3))
    }
  }
