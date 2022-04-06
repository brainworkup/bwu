#' Convert T scores to z scores to percentiles.
#' This is a functioning that converts T-scores to z-scores to percentile
#' ranks. That is about it.
#'
#' @param score Raw test score
#' @param mean Mean of whatever type of score
#' @param sd Standard deviation (SD) of whatever type of score
#' @return A percentile rank score
#'
#' @examples
#' percentile(score = 103, mean = 100, sd = 15)
#'
#' @export
percentile <- function(score, mean, sd) {
  z <- (score - mean) / sd
  percentile <- round(stats::pnorm(z) * 100, 0)

  return(percentile)
}
