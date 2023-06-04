#' ROCFT Copy Standardized Score
#' @description ROCFT predicted scores, for age range of 22 -79 years, for copy trial.
#' @param raw_score Patients raw score
#' @param age Patients age
#'
#' @return A printed T-Score of ROCFT Copy performance
#' @export
#'
#' @examples
#' rocft_copy_score <- rocft_copy(raw_score = 32, age = 24)
rocft_copy <- function(raw_score, age) {
  if (raw_score == "") {
    return("No raw score provided")
  }

  if (age == "") {
    return("No age provided")
  }

  if (!is.numeric(raw_score)) {
    return("Raw score must be numeric")
  }

  if (!is.numeric(age)) {
    return("Age must be numeric")
  }

  if (age < 18) {
    return("Age must be 16 or older")
  }

  if (age > 79) {
    return("Age must be 89 or younger")
  }

  predicted_score <-
    34.40434 + (0.0595862 * age) - (0.0013855 * (age * age))

  predicted_sd <-
    -0.333026 + (0.0625042 * age)

  z_score <- (raw_score - predicted_score) / predicted_sd
  t_score <- (z_score * 10) + 50

  t_score <- round(t_score, digits = 0)
  z_score <- round(z_score, digits = 2)

  predicted_score <- round(predicted_score, digits = 2)
  predicted_sd <- round(predicted_sd, digits = 2)

  paste0(
    "ROCFT Copy T-Score = ", t_score,
    ", z-Score = ", z_score,
    ", Predicted Score = ", predicted_score,
    ", Predicted SD = ", predicted_sd
  )
}

#' ROCFT Delayed Recall Standardized Score
#' @description ROCFT predicted scores, for age range of 22 -79 years, for
#' long-term delayed recall.
#' @param raw_score Patients raw score on Delayed Recall
#' @param age Patient's age
#'
#' @return A T-Score of ROCFT Delayed Recall performance
#' @export
#'
#' @examples
#' rocft_delay_score <- rocft_delay(raw_score = 14, age = 24)
rocft_delay <- function(raw_score, age) {
  if (raw_score == "") {
    return("No raw score provided")
  }

  if (age == "") {
    return("No age provided")
  }

  if (!is.numeric(raw_score)) {
    return("Raw score must be numeric")
  }

  if (!is.numeric(age)) {
    return("Age must be numeric")
  }

  if (age < 18) {
    return("Age must be 16 or older")
  }

  if (age > 79) {
    return("Age must be 89 or younger")
  }

  predicted_score <-
    25.39903 + (0.0416485 * age) - (0.0022144 * (age * age))

  # SD same across groups
  predicted_sd <- 6.67

  z_score <- (raw_score - predicted_score) / predicted_sd
  t_score <- (z_score * 10) + 50

  t_score <- round(t_score, digits = 0)
  z_score <- round(z_score, digits = 2)

  predicted_score <- round(predicted_score, digits = 2)
  predicted_sd <- round(predicted_sd, digits = 2)

  paste0("ROCFT Delayed Recall T-Score = ", t_score, ",
         z-Score = ", z_score, ",
         Predicted Score = ", predicted_score, ",
         Predicted SD = ", predicted_sd)
}
