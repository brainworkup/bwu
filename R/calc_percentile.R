#' Convert T scores to z scores to percentiles
#'
#' @param score Test score
#' @param mean Mean of whatever type of score
#' @param sd SD of whatever type of score
#' @return percentile score
#'
#' @examples
#' calc_percentile(score = 103, mean = 100, sd = 15)
#' @export
calc_percentile <- function(score, mean, sd) {
    z <- (score - mean) / sd
    calc_percentile <- round(pnorm(z) * 100, 0)

    return(calc_percentile)

  }
