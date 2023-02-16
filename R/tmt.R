# TMT predicted score

## Trails A
## Ages 16 - 89

#' Trails A Standardized Score
#'
#' @param raw_score Patients raw score
#' @param age Patients age
#'
#' @return A printed score
#' @export
#'
#' @examples
#' tmt_a_tscore <- tmtA(raw_score = 25, age = 21)
tmtA <- function(raw_score, age) {

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

  if (age < 16) {
    return("Age must be 16 or older")
  }

  if (age > 89) {
    return("Age must be 89 or younger")
  }

  predictedScore <-
    26.50094 - (0.2665049 * age) + (0.0069935 * (age * age))

  predictedSD <-
    8.760348 - (0.1138093 * age) + (0.0028324 * (age * age))

  if (raw_score < predictedScore) {
    zScore <- ((raw_score - predictedScore) / predictedSD) * -1
  }
  else if (raw_score > predictedScore) {
    zScore <- ((raw_score - predictedScore) / predictedSD)
  }

  tScore <- (zScore * 10) + 50
  tScore <- round(tScore, digits = 0)
  zScore <- round(zScore, digits = 2)
  predictedScore <- round(predictedScore, digits = 2)
  predictedSD <- round(predictedSD, digits = 2)

  paste0("T-score = ", tScore, ", z-score = ", zScore, ", Predicted score = ", predictedScore, ", Predicted SD = ", predictedSD)

}

## Trails B
## Ages 16 - 89

#' Trails B Standardized Score
#'
#' @param raw_score Patients raw score (seconds) on Trails B
#' @param age Patient's age
#'
#' @return A tscore of TMTB
#' @export
#'
#' @examples
#' tmt_b_tscore <- tmtB(raw_score = 75, age = 21)
tmtB <- function(raw_score, age) {

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

  if (age < 16) {
    return("Age must be 16 or older")
  }

  if (age > 89) {
    return("Age must be 89 or younger")
  }

  predictedScore <-
    64.07469 - (0.9881013 * age) + (0.0235581 * (age * age))

  predictedSD <-
    29.8444 - (0.8080508 * age) + (0.0148732 * (age * age))

  if (raw_score < predictedScore) {
    zScore <- ((raw_score - predictedScore) / predictedSD) * -1
  }
  else if (raw_score > predictedScore) {
    zScore <- ((raw_score - predictedScore) / predictedSD)
  }

  tScore <- (zScore * 10) + 50

  tScore <- round(tScore, digits = 0)

  zScore <- round(zScore, digits = 2)

  predictedScore <- round(predictedScore, digits = 2)

  predictedSD <- round(predictedSD, digits = 2)

  paste0("T-score = ", tScore, ", z-score = ", zScore, ", Predicted score = ", predictedScore, ", Predicted SD = ", predictedSD)

}
