#' @title Compute 95% confidence intervals (CI)
#' @description To compute confidence intervals for test scores.
#' @param x Score
#' @param m Mean of scale
#' @param sd Standard deviation (SD) of scale
#' @param rel Reliability of scale
#' @param level Confidence level
#' @return Returns 95% CI
#' @examples
#' ci_95(x = 88, m = 100, sd = 15, rel = .80)
#' @export
ci_95 <- function(x, m, sd, rel, level = .95) {
  sem <- sd * sqrt(1 - rel)
  true_score <- (x - m) * rel + m # true score
  z <- -stats::qnorm((1 - level) / 2)
  error <- z * sem
  ci_95_lo <- true_score - error
  ci_95_hi <- true_score + error
  ci <- paste0(c(true_score, ci_95_lo, "-", ci_95_hi), sep = "")

  return(ci)
}
