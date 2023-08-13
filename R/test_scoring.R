#' @title TMT A scoring function
#' @description Calculates the TMT predicted score for Trails A with ages between 16 and 89
#' @param raw_score The raw score inputted
#' @param age The age of the subject
#' @return A string containing the T-score, z-score, predicted score, and predicted standard deviation
#' @rdname tmt_a
#' @export
tmt_a <- function(raw_score, age) {
  predicted_score <-
    26.50094 - (0.2665049 * age) + (0.0069935 * (age * age))

  predicted_sd <-
    8.760348 - (0.1138093 * age) + (0.0028324 * (age * age))

  if (raw_score < predicted_score) {
    z_score <- ((raw_score - predicted_score) / predicted_sd) * -1
  } else if (raw_score > predicted_score) {
    z_score <- ((raw_score - predicted_score) / predicted_sd)
  }

  t_score <- (z_score * 10) + 50

  t_score <- round(t_score, digits = 0)
  z_score <- round(z_score, digits = 2)

  predicted_score <- round(predicted_score, digits = 2)
  predicted_sd <- round(predicted_sd, digits = 2)

  t_score <- paste0("TMT, A T-score: ", t_score, ", z-score = ", z_score, ", Predicted score = ", predicted_score, ", Predicted SD = ", predicted_sd)

  return(t_score)
}


#' @title TMT, B scoring function
#' @description Trails B Ages 16 - 89
#' @param raw_score Score on the Trail Making Test B
#' @param age Age of the participant
#' @param t_score T-Score for TMT, B
#' @return T-Score for TMT, B
#' @rdname tmt_b
#' @export
tmt_b <- function(raw_score, age) {
  predicted_score <-
    64.07469 - (0.9881013 * age) + (0.0235581 * (age * age))

  predicted_sd <-
    29.8444 - (0.8080508 * age) + (0.0148732 * (age * age))

  if (raw_score < predicted_score) {
    z_score <- ((raw_score - predicted_score) / predicted_sd) * -1
  } else if (raw_score > predicted_score) {
    z_score <- ((raw_score - predicted_score) / predicted_sd)
  }

  t_score <- (z_score * 10) + 50

  t_score <- round(t_score, digits = 0)
  z_score <- round(z_score, digits = 2)

  predicted_score <- round(predicted_score, digits = 2)
  predicted_sd <- round(predicted_sd, digits = 2)

  t_score <- paste0(
    "TMT, B T-score: ", t_score, ", z-score = ", z_score,
    ", Predicted score = ", predicted_score,
    ", Predicted SD = ", predicted_sd
  )

  return(t_score)
}


#' @title Rey Complex Figure, Copy
#' @description Provide a brief description of the rocft_copy function.
#' @param raw_score Description for the raw_score parameter.
#' @param age Description for the age parameter.
#' @param t_score Description for the t_score parameter.
#' @return Description for the return value of the function.
#' @details Provide additional details about the function if needed.
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
    "ROCFT Copy T-Score: ", t_score,
    ", z-Score = ", z_score,
    ", Predicted Score = ", predicted_score,
    ", Predicted SD = ", predicted_sd
  )
  return(t_score)
}

#' @title Rey Complex Figure, Delayed Recall
#' @description Provide a brief description of the rocft_delay function.
#' @param raw_score Description for the raw_score parameter.
#' @param age Description for the age parameter.
#' @return Description for the return value of the function.
#' @rdname rocft_delay
#' @export
rocft_delay <- function(raw_score, age) {
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
    "ROCFT Delayed Recall T-Score: ", t_score,
    ", z-Score = ", z_score,
    ", Predicted Score = ", predicted_score,
    ", Predicted SD = ", predicted_sd
  )
  return(t_score)
}
