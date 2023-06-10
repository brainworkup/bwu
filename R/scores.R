#' @title Predicted test score
#'
#' @description Estimate the difference between an ability and achievement score.
#'
#' @param x Score 1 (ability)
#' @param y Score 2 (achievement)
#' @param r Correlation between ability test and achievement test
#' @param m Mean of test score
#' @param ... Additional arguments
#'
#' @return A predicted score.
#'
#' @examples
#' pred(x = 122, y = 84, r = .65, m = 100)
#'
#' @export
pred <- function(x, y, r, m, ...) {
  z <- round(r * (x - m) + m, 0)
  diff <- z - y

  return(paste(z, diff, sep = ", "))
}

#' @title Compute confidence intervals (CI)
#' @description To compute confidence intervals for test scores.
#' @param x Score
#' @param m Mean of scale
#' @param sd Standard deviation (SD) of scale
#' @param rel Reliability of scale
#' @param level Confidence level, default is 0.95
#' @param ... Additional arguments
#' @return Returns a named vector with elements 'true_score', 'ci_lo' and 'ci_hi'
#' @examples
#' ci_res <- ci(x = 88, m = 100, sd = 15, rel = .80)
#' @export
ci <- function(x, m, sd, rel, level = 0.95, ...) {
  # Check input parameters
  if (!is.numeric(x) || !is.numeric(m) || !is.numeric(sd) || !is.numeric(rel) || !is.numeric(level) ||
      sd <= 0 || rel < 0 || rel > 1 || level <= 0 || level >= 1) {
    stop("Invalid input parameters")
  }

  # Compute SEM
  sem <- sd * sqrt(1 - rel)

  # Compute true score
  true_score <- round((x - m) * rel + m, 0)

  # Compute z value
  z <- -stats::qnorm((1 - level) / 2)

  # Compute error
  error <- z * sem

  # Compute CI
  ci_lo <- round(true_score - error, 0)
  ci_hi <- round(true_score + error, 0)

  # Return structured result
  return(c(true_score = true_score, ci_lo = ci_lo, ci_hi = ci_hi))
}


#' Convert T scores to z scores to percentiles.
#' This is a functioning that converts T-scores to z-scores to percentile
#' ranks. That is about it.
#'
#' @param x Raw test score
#' @param m Mean of whatever type of score
#' @param sd Standard deviation (SD) of whatever type of score
#' @return A percentile rank score
#'
#' @examples
#' pct(x = 103, m = 100, sd = 15)
#'
#' @export
pct <- function(x, m, sd) {
  z <- (x - m) / sd
  percentile <- round(stats::pnorm(z) * 100, 0)
  return(percentile)
}
