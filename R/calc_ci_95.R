#' @title Compute 95% CI
#' @description To compute confidence interval.
#' @param x score
#' @param m mean of scale
#' @param sd sd of scale
#' @param rel reliability of scale
#' @param level confidence level
#' @import stats
#' @return Returns 95% CI
#' @examples calc_ci_95(x = 88, m = 100, sd = 15, rel = .80)
#'
#' @export
calc_ci_95 <- function(x, m, sd, rel, level = .95) {
  sem <- sd * sqrt(1 - rel)
  true_score <- (x - m) * rel + m # true score
  z <- -stats::qnorm((1 - level) / 2)
  error <- z * sem
  ci_95_lo <- true_score - error
  ci_95_hi <- true_score + error

  calc_ci_95 <- paste0(c(true_score, ci_95_lo, "-", ci_95_hi), sep = "")

  return(calc_ci_95)
}
