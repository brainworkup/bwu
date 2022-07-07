#' @title Convert T-score to z-score to percentile
#'
#' @param table Name of data table
#' @param score T-score value
#' @param score_type Type of score
#' @param ... More expressions
#'
#' @return A tidy csv file
#' @export
#'
gpluck_t2z2p <-
  function(...,
           table,
           score,
           score_type) {
    if (score_type == "t_score") {
      table <-
        table |>
        dplyr::mutate(z = (score - 50) / 10) %>%
        dplyr::mutate(pct1 = round(stats::pnorm(z) * 100, 1)) |>
        dplyr::mutate(pct2 = dplyr::case_when(
          pct1 < 1 ~ ceiling(pct1),
          pct1 > 99 ~ floor(pct1),
          TRUE ~ round(pct1)
        )) |>
        dplyr::mutate(pct3 = pct2) |>
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
        ) |>
        dplyr::mutate(percentile = pct1) |>
        dplyr::mutate(result = glue::glue("{description} was {range}.")) |>
        dplyr::select(-c(z, pct1, pct2, pct3))
    } else if (score_type == "standard_score") {
        table <-
          table |>
          dplyr::mutate(z = (score - 100) / 15) %>%
          dplyr::mutate(pct1 = round(stats::pnorm(z) * 100, 1)) |>
          dplyr::mutate(pct2 = dplyr::case_when(
            pct1 < 1 ~ ceiling(pct1),
            pct1 > 99 ~ floor(pct1),
            TRUE ~ round(pct1)
          )) |>
          dplyr::mutate(pct3 = pct2) |>
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
          )
        |>
        dplyr::mutate(percentile = pct1) |>
        dplyr::mutate(result = glue::glue("{description} was {range}.")) |>
        dplyr::select(-c(z, pct1, pct2, pct3))
      } 
 }
