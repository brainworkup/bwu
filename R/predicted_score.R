#' @title Predicted Ability-Achievement Score
#'
#' @description Estimate the difference between an ability and achievement score
#'
#' @param x Actual score
#' @param r Correlation between ability test and achievement test
#' @param m Mean of test score
#'
#' @return A predicted score.
#'
#' @examples
#' predicted_score(x = 82, r = .93, m = 100)
#'
#' @export
predicted_score <- function(x, r, m = 100) {

  score <- r * (x - m) + m

  return(round(score, 0))
}
