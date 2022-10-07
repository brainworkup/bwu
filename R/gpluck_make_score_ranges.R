#' @title Make test score range (e.g., Below Average, Above Average).
#' @description Use a consistent set of ranges for performance on neuropsychological testing.
#'
#' @param table Name of table
#' @param score Score, raw score, or standard score
#' @param percentile Percentile rank
#' @param range Range of performance score
#' @param test_type Type of test
#' @param ... More if needed
#'
#' @return Returns a modified table.
#'
#' @examples
#' neurocog <- gpluck_make_score_ranges(
#'   table = neurocog,
#'   score = 50,
#'   percentile = 50,
#'   range = "",
#'   test_type = "npsych_test"
#' )
#'
#' @export
gpluck_make_score_ranges <-
  function(table = table,
           score = NULL,
           percentile = NULL,
           range = range,
           test_type,
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
            score >= 70 ~ "Clinically Significant",
            score %in% 60:69 ~ "At-Risk",
            score %in% 40:59 ~ "Average",
            score <= 39 ~ "Below Average/Strength",
            TRUE ~ as.character(range)
          )
        )
    } else {
      table <-
        table %>%
        dplyr::mutate(
          range = dplyr::case_when(
            score >= 60 &
              subdomain %in% c("Adaptive Skills", "Personal Adjustment") ~ "Strength",
            score %in% 40:59 &
              subdomain %in% c("Adaptive Skills", "Personal Adjustment") ~ "Within Normal Limits",
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
