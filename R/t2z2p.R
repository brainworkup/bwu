#' Convert T-score to z-score to percentile
#'
#' @param score T-score value
#' @param table Name of table
#' @param ... More expressions
#'
#' @return A tidy csv file
#' @export
#'
t2z2p <-
  function(table,
           score,
           ...) {
    table <-
      table |>
      dplyr::mutate(z = (score - 50) / 10) %>%
      dplyr::mutate(pct = round(stats::pnorm(z) * 100, 1)) |>
      dplyr::mutate(pct2 = dplyr::case_when(
        pct < 1 ~ ceiling(pct),
        pct > 99 ~ floor(pct),
        TRUE ~ round(pct)
      )) |>
      dplyr::mutate(percentile1 = pct2) |>
      dplyr::mutate(
        range = dplyr::case_when(
          percentile1 >= 98 ~ "Exceptionally High",
          percentile1 %in% 91:97 ~ "Above Average",
          percentile1 %in% 75:90 ~ "High Average",
          percentile1 %in% 25:74 ~ "Average",
          percentile1 %in% 9:24 ~ "Low Average",
          percentile1 %in% 2:8 ~ "Below Average",
          percentile1 < 2 ~ "Exceptionally Low",
          TRUE ~ as.character(range)
        )
      ) |>
      dplyr::mutate(percentile = pct) |>
      dplyr::mutate(result = glue::glue("{description} was {range}.")) |>
      dplyr::select(-c(pct, z, pct2, percentile1))

    return(table)
  }
