# ROCFT predicted score

## ROCFT Copy Trial
## Ages 22 - 79

#' ROCFT Copy Standardized Score
#'
#' @param rawScore Patients raw score
#' @param age Patients age
#'
#' @return A printed T-Score of ROCFT Copy performance
#' @export
#'
#' @examples
#' rocft_copy <- rocftCopy(rawScore = 32, age = 24)
rocftCopy <- function(rawScore, age) {

  predictedScore <-
    34.40434 + (0.0595862 * age) - (0.0013855 * (age * age))
  
  predictedSD <-
    -0.333026 + (0.0625042 * age)
  
  zScore <- (rawScore - predictedScore) / predictedSD
  
  tScore <- (zScore * 10) + 50
  
  tScore <- round(tScore, digits = 0)
  zScore <- round(zScore, digits = 2)
  predictedScore <- round(predictedScore, digits = 2)
  predictedSD <- round(predictedSD, digits = 2)
  
  paste0(tScore, ", ", zScore, ", ", predictedScore, ", ", predictedSD)
  
}
 
## ROCFT Delayed Recall
## Ages 22 - 79

#' ROCFT Delayed Recall Standardized Score
#'
#' @param rawScore Patients raw score on Delayed Recall
#' @param age Patient's age
#'
#' @return A T-Score of ROCFT Delayed Recall performance
#' @export
#'
#' @examples
#' rocft_delay <- rocftDelay(rawScore = 14, age = 24)
rocftDelay <- function(rawScore, age) {
  predictedScore <-
    25.39903 + (0.0416485 * age) - (0.0022144 * (age * age))
  predictedSD <- 6.67
  zScore <- (rawScore - predictedScore) / predictedSD
  tScore <- (zScore * 10) + 50
  tScore <- round(tScore, digits = 0)
  zScore <- round(zScore, digits = 2)
  predictedScore <- round(predictedScore, digits = 2)
  predictedSD <- round(predictedSD, digits = 2)
  paste0(tScore, ", ", zScore, ", ", predictedScore, ", ", predictedSD)
}
