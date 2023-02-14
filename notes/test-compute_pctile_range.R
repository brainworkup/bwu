library(magrittr)
library(bwu)
library(data.table)
library(tidytable)


df <- tidytable::tidytable(
  test = "rocft",
  test_name = "Rey Complex Figure",
  test_type = "npsych_test",
  scale = "ROCFT Copy",
  score = 44,
  percentile = NA,
  range = NA,
  score_type = "t_score",
  z = NA
)

test_that("compute_pctile_range() tests that a pctile and range can be created", {

  ## Make data.frame




  ## Function to compute percentile and range

  compute_pctile_range <-
    function(.x,
             .score = df$score,
             .score_type = df$score_type,
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
          tidytable::mutate.(z = (.score - 0) / 1) %>%
          tidytable::mutate.(pct1 = round(stats::pnorm(z) * 100, 1)) %>%
          tidytable::mutate.(pct2 = tidytable::case_when.(
            pct1 < 1 ~ ceiling(pct1),
            pct1 > 99 ~ floor(pct1),
            TRUE ~ round(pct1)
          )) %>%
          tidytable::mutate.(pct3 = pct2) %>%
          tidytable::mutate.(
            range = tidytable::case_when.(
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
          tidytable::mutate.(percentile = pct1) %>%
          tidytable::select.(-c(pct1, pct2, pct3))
      } else if (.score_type == "scaled_score") {
        .x <-
          .x |>
          tidytable::mutate.(z = (.score - 10) / 3) %>%
          tidytable::mutate.(pct1 = round(stats::pnorm(z) * 100, 1)) %>%
          tidytable::mutate.(pct2 = tidytable::case_when.(
            pct1 < 1 ~ ceiling(pct1),
            pct1 > 99 ~ floor(pct1),
            TRUE ~ round(pct1)
          )) %>%
          tidytable::mutate.(pct3 = pct2) %>%
          tidytable::mutate.(
            range = tidytable::case_when.(
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
          tidytable::mutate.(percentile = pct1) %>%
          tidytable::select.(-c(pct1, pct2, pct3))
      } else if (.score_type == "t_score") {
        .x <-
          .x |>
          tidytable::mutate.(z = (.score - 50) / 10) %>%
          tidytable::mutate.(pct1 = round(stats::pnorm(z) * 100, 1)) %>%
          tidytable::mutate.(pct2 = tidytable::case_when.(
            pct1 < 1 ~ ceiling(pct1),
            pct1 > 99 ~ floor(pct1),
            TRUE ~ round(pct1)
          )) %>%
          tidytable::mutate.(pct3 = pct2) %>%
          tidytable::mutate.(
            range = tidytable::case_when.(
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
          tidytable::mutate.(percentile = pct1) %>%
          tidytable::select.(-c(pct1, pct2, pct3))
      } else if (.score_type == "standard_score") {
        .x <-
          .x |>
          tidytable::mutate.(z = (.score - 100) / 15) %>%
          tidytable::mutate.(pct1 = round(stats::pnorm(z) * 100, 1)) %>%
          tidytable::mutate.(pct2 = tidytable::case_when.(
            pct1 < 1 ~ ceiling(pct1),
            pct1 > 99 ~ floor(pct1),
            TRUE ~ round(pct1)
          )) %>%
          tidytable::mutate.(pct3 = pct2) %>%
          tidytable::mutate.(
            range = tidytable::case_when.(
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
          tidytable::mutate.(percentile = pct1) %>%
          tidytable::select.(-c(pct1, pct2, pct3))
      }
    }


  ## Compute percentile, range

  df1 <- compute_pctile_range(
    .x = (df),
    .score = df$score,
    .score_type = df$score_type,
    percentile = percentile,
    range = range
  )

})
