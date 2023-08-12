#' @title Predicted test score
#' @description Estimate the difference between an ability and achievement score.
#' @param x Score 1 (ability)
#' @param y Score 2 (achievement)
#' @param r Correlation between ability test and achievement test
#' @param m Mean of test score
#' @return A predicted score.
#' @rdname calc_predicted_score
#' @examples
#' calc_predicted_score(x = 122, y = 84, r = .65, m = 100) #'
#' @export
calc_predicted_score <- function(x, y, r, m) {
  # Step 1: Calculate the predicted score.
  z <- round(r * (x - m) + m, 0)

  # Step 2: Calculate the difference between the predicted score and the actual score.
  diff <- (z - y)

  # Step 3: Return the predicted score and difference.
  return(paste(z, diff, sep = ", "))
}

#' @title Compute confidence intervals (CI)
#' @description To compute confidence intervals for test scores.
#' @importFrom stats qnorm
#' @importFrom glue glue
#' @param x Score
#' @param m Mean of scale
#' @param sd Standard deviation (SD) of scale
#' @param rel Reliability of scale
#' @param level Confidence level
#' @return Returns confidence interval
#' @rdname calc_ci_95
#' @examples
#' calc_ci_95(x = 88, m = 100, sd = 15, rel = .80)
#' @export
calc_ci_95 <- function(x, m, sd, rel, level = 0.95) {
  # Compute standard error of measurement (SEM)
  sem <- sd * sqrt(1 - rel)

  # Compute true score
  true_score <- round((x - m) * rel + m, 0)

  # Compute z-score for desired confidence level
  z <- -stats::qnorm((1 - level) / 2)

  # Compute error
  error <- z * sem

  # Compute confidence interval
  upper_ci_95 <- round(true_score - error, 0)
  lower_ci_95 <- round(true_score + error, 0)
  ci_95 <- glue::glue(true_score, " ", "[", upper_ci_95, "-", lower_ci_95, "]")
}

#' Convert T scores to z scores to percentiles.
#' This is a functioning that converts T-scores to z-scores to percentile
#' ranks. That is about it.
#' @param x Raw test score
#' @param m Mean of whatever type of score
#' @param sd Standard deviation (SD) of whatever type of score
#' @return A percentile rank score
#' @importFrom stats pnorm
#' @rdname calc_percentile
#' @examples
#' calc_percentile(x = 103, m = 100, sd = 15)
#' @export
calc_percentile <- function(x, m, sd) {
  # Calculate the z score
  z <- (x - m) / sd

  # Convert the z score to a percentile rank
  percentile <- round(stats::pnorm(z) * 100, 0)

  # Return the percentile rank
  percentile
}
