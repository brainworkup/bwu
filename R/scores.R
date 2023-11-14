#' Calculate Standardized and Predicted Scores
#' This function calculates predicted, standardized, and confidence interval scores based on given parameters.
#' @param ability_score Obtained ability score
#' @param achievement_score Obtained achievement score
#' @param correlation Correlation between the two variables
#' @param mean Mean of the variable
#' @param standard_deviation Standard deviation of the variable
#' @param reliability Reliability of the test
#' @param round Number of decimal places to round to
#' @param confidence_level Confidence level for the calculation (defaults to 0.95)
#' @rdname standardized_score
#' @return Set of scores including predicted, standardized, and confidence intervals
#' @export
standardized_score <- function(ability_score, achievement_score, correlation, mean, standard_deviation, reliability, round = 0, confidence_level = 0.95) {
  # Calculate predicted score and difference
  predicted_score <- round(correlation * (ability_score - mean) + mean)
  diff <- predicted_score - achievement_score

  # Compute standard error of measurement (SEM) and true score
  sem <- round(standard_deviation * sqrt(1 - reliability), 2)
  true_score <- round((ability_score - mean) * reliability + mean)

  # Compute z-score for desired confidence level and its percentile
  fisher <- round(-stats::qnorm((1 - confidence_level) / 2), 2)
  z <- (ability_score - mean) / standard_deviation
  percentile <- round(stats::pnorm(z) * 100, 1)

  # Compute error
  error <- round(fisher * sem, 2)

  # Calculate confidence intervals
  compute_CI <- function(value) {
    hi <- round(value - error, digits = round)
    lo <- round(value + error, digits = round)
    c(hi, lo)
  }

  ci_x <- compute_CI(ability_score)
  ci_y <- compute_CI(achievement_score)
  ci_pred <- compute_CI(predicted_score)
  ci_true <- compute_CI(true_score)
  ci_pr <- compute_CI(percentile)

  # Determine significance of diff from zero
  significance_threshold <- 1.96 * error # for 95% confidence
  significant_diff <- abs(diff) > significance_threshold

  significance_msg <- ifelse(significant_diff,
    "The difference is statistically significant (p < .05).",
    "The difference is not statistically significant."
  )

  # Return the results
  return(glue::glue("Ability Score = {ability_score} (95% CI: {ci_x[1]}-{ci_x[2]}),
                    Percentile Rank = {percentile} (95% CI: {ci_pr[1]}-{ci_pr[2]}),
                    True Score = {true_score} (95% CI: {ci_true[1]}-{ci_true[2]}),
                    Predicted Achievement Score = {predicted_score} (95% CI: {ci_pred[1]}-{ci_pred[2]}),
                    Actual Achievement Score = {achievement_score} (95% CI: {ci_y[1]}-{ci_y[2]}),
                    Difference = {diff} ({significance_msg}),
                    SE = {error},
                    SEM = {sem}"))
}

#' @title Predicted Test Score
#' @description Estimate the difference between an actual score and a predicted score.
#' @importFrom glue glue
#' @param ability_score Score 1 (ability)
#' @param achievement_score Score 2 (achievement)
#' @param correlation Correlation between ability test and achievement test
#' @param mean Mean of test score
#' @param round Number of digits to round to
#' @return A predicted score.
#' @rdname calc_predicted_score
#' @examples
#' calc_predicted_score(ability_score = 122, achievement_score = 84, correlation = .65, mean = 100)
#' @export
calc_predicted_score <- function(ability_score, achievement_score, correlation, mean, round = 0) {
  # Step 1: Calculate the predicted score.
  z <- round(correlation * (ability_score - mean) + mean, digits = round)

  # Step 2: Calculate the difference between the predicted score and the actual score.
  diff <- (z - achievement_score)

  # Step 3: Return the predicted score and difference.
  return(glue::glue("Ability Score = {ability_score}\nPredicted Achievement Score = {z}\nActual Achievement Score = {achievement_score}\nDifference = {diff}"))
}

#' @title Compute 95% Confidence Intervals
#' @description To compute confidence intervals for test scores.
#' @importFrom stats qnorm
#' @importFrom glue glue
#' @param ability_score Score
#' @param mean Mean of scale
#' @param standard_deviation Standard deviation (SD) of scale
#' @param reliability Reliability of scale
#' @param round Number of digits to round to
#' @param confidence_level Confidence level
#' @return Returns confidence interval
#' @rdname calc_ci_95
#' @export
calc_ci_95 <- function(ability_score, mean, standard_deviation, reliability, round = 0, confidence_level = 0.95) {
  # Compute standard error of measurement (SEM)
  sem <- standard_deviation * sqrt(1 - reliability)

  # Compute true score
  true_score <- round((ability_score - mean) * reliability + mean, digits = round)

  # Compute z-score for desired confidence level
  z <- -stats::qnorm((1 - confidence_level) / 2)

  # Compute error
  error <- z * sem

  # Compute confidence interval
  lower_ci_95 <- round(true_score - error, digits = round)
  upper_ci_95 <- round(true_score + error, digits = round)

  # Return a list of values
  return(list(
    ability_score = ability_score,
    true_score = true_score,
    lower_ci_95 = lower_ci_95,
    upper_ci_95 = upper_ci_95
  ))
}

#' Convert Standard Score/T-Score/Scaled Score to z-Scores to Percentiles
#' This is a functioning that converts T-scores to z-scores to percentile
#' ranks.
#' @param ability_score Raw test score
#' @param mean Mean of whatever type of score
#' @param standard_deviation Standard deviation (SD) of whatever type of score
#' @param round Number of digits to round to
#' @return A percentile rank score
#' @importFrom stats pnorm
#' @importFrom glue glue
#' @rdname calc_percentile
#' @examples
#' calc_percentile(ability_score = 103, mean = 100, standard_deviation = 15, round = 1)
#' @export
calc_percentile <- function(ability_score, mean, standard_deviation, round = 0) {
  # Calculate the z score
  z <- (ability_score - mean) / standard_deviation

  # Convert the z score to a percentile rank
  percentile <- round(stats::pnorm(z) * 100, digits = round)

  return(glue::glue("Ability Score = {ability_score}\nPercentile Rank = {percentile}"))
}


#' Normalize a vector
#'
#' @param x A numeric vector
#' @return A normalized numeric vector
#' @export
normalization <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}

#' Standardization of a vector
#'
#' This function takes a vector as input and returns the standardization of that vector.
#'
#' @param x A vector.
#'
#' @return The standardization of the vector.
#'
#' @examples
#' x <- c(1, 2, 3)
#' standardization(x)
#'
#' @export
standardization <- function(x) {
  return((x - mean(x)) / sd(x))
}
