#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param raw_score PARAM_DESCRIPTION
#' @param age PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname rocft_copy
#' @export 
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

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param raw_score PARAM_DESCRIPTION
#' @param age PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname rocft_delay
#' @export 
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
