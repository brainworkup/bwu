#' @title TMT, Part A Score Lookup
#' @description Calculates the TMT predicted score for Trails A with ages between 16 and 89
#' @param raw_score The raw score inputted
#' @param age The age of the subject
#' @return A string containing the T-score, z-score, predicted score, and predicted standard deviation
#' @rdname tmt_a
#' @export
tmt_a <- function(raw_score, age) {
  predicted_score <- 26.50094 - (0.2665049 * age) + (0.0069935 * (age * age))
  predicted_sd <- 8.760348 - (0.1138093 * age) + (0.0028324 * (age * age))

  # For TMT, a lower raw score is better, so we invert the z-score calculation.
  z_score <- (predicted_score - raw_score) / predicted_sd

  t_score <- (z_score * 10) + 50

  # Round the scores
  t_score <- round(t_score, digits = 0)
  z_score <- round(z_score, digits = 2)
  predicted_score <- round(predicted_score, digits = 2)
  predicted_sd <- round(predicted_sd, digits = 2)

  # Create output string
  t_score <- paste0(
    "TMT-A T-score: ", t_score,
    ", z-score = ", z_score,
    ", Predicted score = ", predicted_score,
    ", Predicted SD = ", predicted_sd
  )

  return(t_score)
}

#' @title TMT, Part B Score Lookup
#' @description Trails B Ages 16 - 89
#' @param raw_score Score on the Trail Making Test B
#' @param age Age of the participant
#' @return T-Score for TMT, B
#' @rdname tmt_b
#' @export
tmt_b <- function(raw_score, age) {
  predicted_score <- 64.07469 - (0.9881013 * age) + (0.0235581 * (age * age))
  predicted_sd <- 29.8444 - (0.8080508 * age) + (0.0148732 * (age * age))

  # For TMT, a lower raw score is better, so we invert the z-score calculation.
  z_score <- (predicted_score - raw_score) / predicted_sd

  t_score <- (z_score * 10) + 50

  # Round the scores
  t_score <- round(t_score, digits = 0)
  z_score <- round(z_score, digits = 2)
  predicted_score <- round(predicted_score, digits = 2)
  predicted_sd <- round(predicted_sd, digits = 2)

  # Create output string
  t_score <- paste0(
    "TMT-B T-score: ", t_score,
    ", z-score = ", z_score,
    ", Predicted score = ", predicted_score,
    ", Predicted SD = ", predicted_sd
  )

  return(t_score)
}

#' @title Rey Complex Figure, Copy Trial Score Lookup
#' @description Calculates a Rey Complex Figure, Copy trial score (T-score) from a raw score and age. The predicted score and standard deviation are also calculated.
#' @param raw_score A numeric value of the raw score from the Rey Complex Figure, Copy trial.
#' @param age A numeric value of the age of the participant. Must be between 16 and 89 years old.
#' @return Returns a numeric value of the T-score for the Rey Complex Figure, Copy trial.
#' @details This function takes the raw score and age of a participant and calculates the Rey Complex Figure, Copy trial T-score using the formula provided by \emph{Manly et al. (2000)}. It also returns the predicted score and standard deviation for the trial.
#' @references Manly, J.J., Schinka, J.A., & Guerrero, L. (2000). Normative Data on the Rey Complex Figure Test in Older Adults. Archives of Clinical Neuropsychology, 15(7), 613-621.
#' @rdname rocft_copy
#' @export
rocft_copy <- function(raw_score, age) {
  MIN_AGE <- 16
  MAX_AGE <- 89

  validate_inputs <- function(raw_score, age) {
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

    if (age < MIN_AGE) {
      return(paste0("Age must be ", MIN_AGE, " or older"))
    }

    if (age > MAX_AGE) {
      return(paste0("Age must be ", MAX_AGE, " or younger"))
    }

    return(NULL)
  }

  validation_message <- validate_inputs(raw_score, age)
  if (!is.null(validation_message)) {
    return(validation_message)
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
    "ROCFT Copy T-Score: ",
    t_score,
    ", z-Score = ",
    z_score,
    ", Predicted Score = ",
    predicted_score,
    ", Predicted SD = ",
    predicted_sd
  )
  return(t_score)
}



#' @title Rey Complex Figure, Delayed Recall Score Lookup
#' @description Calculates a Rey Complex Figure, Delayed Recall (30-min) trial score (T-score) from a raw score and age. The predicted score and standard deviation are also calculated.
#' @param raw_score A numeric value of the raw score from the Rey Complex Figure, Copy trial.
#' @param age A numeric value of the age of the participant. Must be between 16 and 89 years old.
#' @return Returns a numeric value of the T-score for the Rey Complex Figure, Copy trial.
#' @details This function takes the raw score and age of a participant and calculates the Rey Complex Figure, Copy trial T-score using the formula provided by \emph{Manly et al. (2000)}. It also returns the predicted score and standard deviation for the trial.
#' @references Manly, J.J., Schinka, J.A., & Guerrero, L. (2000). Normative Data on the Rey Complex Figure Test in Older Adults. Archives of Clinical Neuropsychology, 15(7), 613-621.
#' @rdname rocft_delayed_recall
#' @export
rocft_delayed_recall <- function(raw_score, age) {
  MIN_AGE <- 16
  MAX_AGE <- 89

  validate_inputs <- function(raw_score, age) {
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

    if (age < MIN_AGE) {
      return(paste0("Age must be ", MIN_AGE, " or older"))
    }

    if (age > MAX_AGE) {
      return(paste0("Age must be ", MAX_AGE, " or younger"))
    }

    return(NULL)
  }

  validation_message <- validate_inputs(raw_score, age)
  if (!is.null(validation_message)) {
    return(validation_message)
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

  paste0(
    "ROCFT Delayed Recall T-Score: ",
    t_score,
    ", z-Score = ",
    z_score,
    ", Predicted Score = ",
    predicted_score,
    ", Predicted SD = ",
    predicted_sd
  )
  return(t_score)
}
