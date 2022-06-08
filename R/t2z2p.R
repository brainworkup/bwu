#' Convert T-score to z-score to percentile
#'
#' @param table Name of table
#' @param score T-score value
#' @param z z-score value
#' @param scale Name of scale/measure/subtest
#' @param percentile Percentile rank
#'
#' @return A tidy csv file
#' @export
#'
t2z2p <-
  function(table = table,
           score = score,
           z = z,
           scale = scale,
           percentile = percentile) {
    table <- table %>%
      dplyr::mutate(z = (score - 50) / 10) %>%
      dplyr::mutate(percentile = round(stats::pnorm(z) * 100, 5)) %>%
      dplyr::select(scale, score, percentile)

    return(table)
  }
