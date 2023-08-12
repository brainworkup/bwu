#' @title Predicted test score
#' @description Estimate the difference between an actual score and a predicted score.
#' @importFrom glue glue
#' @param x Score 1 (ability)
#' @param y Score 2 (achievement)
#' @param r Correlation between ability test and achievement test
#' @param m Mean of test score
#' @param round Number of digits to round to
#' @return A predicted score.
#' @rdname calc_predicted_score
#' @examples
#' calc_predicted_score(x = 122, y = 84, r = .65, m = 100)
#' @export
calc_predicted_score <- function(x, y, r, m, round = 0) {
  # Step 1: Calculate the predicted score.
  z <- round(r * (x - m) + m, digits = round)

  # Step 2: Calculate the difference between the predicted score and the actual score.
  diff <- (z - y)

  # Step 3: Return the predicted score and difference.
  return(glue::glue("Ability Score = {x}\nPredicted Achievement Score = {z}\nActual Achievement Score = {y}\nDifference = {diff}"))
}

#' @title Compute confidence intervals (CI)
#' @description To compute confidence intervals for test scores.
#' @importFrom stats qnorm
#' @importFrom glue glue
#' @param x Score
#' @param m Mean of scale
#' @param sd Standard deviation (SD) of scale
#' @param rel Reliability of scale
#' @param round Number of digits to round to
#' @param level Confidence level
#' @return Returns confidence interval
#' @rdname calc_ci_95
#' @examples
#' calc_ci_95(x = 88, m = 100, sd = 15, rel = .90, round = 0, level = 0.95)
#' @export
calc_ci_95 <- function(x, m, sd, rel, round = 0, level = 0.95) {
  # Compute standard error of measurement (SEM)
  sem <- sd * sqrt(1 - rel)

  # Compute true score
  true_score <- round((x - m) * rel + m, digits = round)

  # Compute z-score for desired confidence level
  z <- -stats::qnorm((1 - level) / 2)

  # Compute error
  error <- z * sem

  # Compute confidence interval
  upper_ci_95 <- round(true_score - error, digits = round)
  lower_ci_95 <- round(true_score + error, digits = round)

  # Return the observed score, true score and confidence interval
  return(glue::glue("Ability Score = {x}\nTrue Score = {true_score} (95% CI: {upper_ci_95}-{lower_ci_95})"))
}

#' Convert SS/T/scaled scores to z scores to percentiles.
#' This is a functioning that converts T-scores to z-scores to percentile
#' ranks.
#' @param x Raw test score
#' @param m Mean of whatever type of score
#' @param sd Standard deviation (SD) of whatever type of score
#' @param round Number of digits to round to
#' @return A percentile rank score
#' @importFrom stats pnorm
#' @importFrom glue glue
#' @rdname calc_percentile
#' @examples
#' calc_percentile(x = 103, m = 100, sd = 15, round = 1)
#' @export
calc_percentile <- function(x, m, sd, round = 0) {
  # Calculate the z score
  z <- (x - m) / sd

  # Convert the z score to a percentile rank
  percentile <- round(stats::pnorm(z) * 100, digits = round)

  return(glue::glue("Ability Score = {x}\nPercentile Rank = {percentile}"))
}

#' @title Predicted test score with confidence intervals
#' @description Estimate the difference between an actual score and a predicted score and compute the percentile of that score, and the confidence interval 95% of the time.
#' @importFrom glue glue
#' @importFrom stats qnorm
#' @param x Score 1 (ability)
#' @param y Score 2 (achievement)
#' @param r Correlation between ability test and achievement test
#' @param m Mean of test score
#' @param sd Standard deviation of test scores
#' @param rel Reliability of scale
#' @param round Number of digits to round to
#' @param level Confidence level
#' @return A predicted score.
#' @rdname calc_pred_score_ci_95_pct
#' @examples
#' calc_predicted_ci(x = 122, y = 84, r = .65, m = 100, sd = 15, rel = .90, round = 0, level = 0.95)
#' @export
calc_pred_score_ci_95_pct <- function(x, y, r, m, sd, rel, round = 0, level = 0.95) {
  # Step 1: Calculate the predicted score.
  pred_score <- round(r * (x - m) + m, digits = 0)

  # Step 2: Calculate the difference between the predicted score and the actual score.
  diff <- (pred_score - y)

  # Step 3: Compute standard error of measurement (SEM)
  sem <- round(sd * sqrt(1 - rel), digits = 2)

  # Step 4: Compute true score
  true_score <- round((x - m) * rel + m, digits = 0)

  # Step 5: Compute z-score for desired confidence level
  fisher <- round(-stats::qnorm((1 - level) / 2), digits = 2)

  # Step 6: Compute error
  error <- round(fisher * sem, digits = 2)

  # Step 8: Calculate the z score
  z <- (x - m) / sd

  # Step 9: Convert the z score to a percentile rank
  pr <- round(stats::pnorm(z) * 100, digits = 1)

  # Step 7: Compute confidence interval
  ci_95_hi_x <- round(x - error, digits = round)
  ci_95_lo_x <- round(x + error, digits = round)
  ci_95_hi_y <- round(y - error, digits = round)
  ci_95_lo_y <- round(y + error, digits = round)
  ci_95_hi_p <- round(pred_score - error, digits = round)
  ci_95_lo_p <- round(pred_score + error, digits = round)
  ci_95_hi_t <- round(true_score - error, digits = round)
  ci_95_lo_t <- round(true_score + error, digits = round)
  ci_95_hi_pr <- round(pr - error, digits = round)
  ci_95_lo_pr <- round(pr + error, digits = round)

  # Step 9: Return the predicted score and difference along with confidence intervals and percentile.
  return(glue::glue("Ability Score = {x} (95% CI: {ci_95_hi_x}-{ci_95_lo_x}), Percentile Rank = {pr} (95% CI: {ci_95_hi_pr}-{ci_95_lo_pr})\nTrue Score = {true_score} (95% CI: {ci_95_hi_t}-{ci_95_lo_t})\nPredicted Achievement Score = {pred_score} (95% CI: {ci_95_hi_p}-{ci_95_lo_p})\nActual Achievement Score = {y} (95% CI: {ci_95_hi_y}-{ci_95_lo_y})\nDifference = {diff}\nSE = {error}\nSEM = {sem}"))
}
