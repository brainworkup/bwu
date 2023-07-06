#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param x PARAM_DESCRIPTION
#' @param y PARAM_DESCRIPTION
#' @param r PARAM_DESCRIPTION
#' @param m PARAM_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname pred
#' @export 
pred <- function(x, y, r, m, ...) {
  z <- round(r * (x - m) + m, 0)
  diff <- z - y

  return(paste(z, diff, sep = ", "))
}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param x PARAM_DESCRIPTION
#' @param m PARAM_DESCRIPTION
#' @param sd PARAM_DESCRIPTION
#' @param rel PARAM_DESCRIPTION
#' @param level PARAM_DESCRIPTION, Default: 0.95
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso 
#'  [qnorm][stats::qnorm]
#' @rdname ci
#' @export 
#' @importFrom stats qnorm
ci <- function(x, m, sd, rel, level = 0.95, ...) {
  # Check input parameters
  if (!is.numeric(x) || !is.numeric(m) || !is.numeric(sd) || !is.numeric(rel) || !is.numeric(level) ||
      sd <= 0 || rel < 0 || rel > 1 || level <= 0 || level >= 1) {
    stop("Invalid input parameters")
  }

  # Compute SEM
  sem <- sd * sqrt(1 - rel)

  # Compute true score
  true_score <- round((x - m) * rel + m, 0)

  # Compute z value
  z <- -stats::qnorm((1 - level) / 2)

  # Compute error
  error <- z * sem

  # Compute CI
  ci_lo <- round(true_score - error, 0)
  ci_hi <- round(true_score + error, 0)

  # Return structured result
  return(c(true_score = true_score, ci_lo = ci_lo, ci_hi = ci_hi))
}


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param x PARAM_DESCRIPTION
#' @param m PARAM_DESCRIPTION
#' @param sd PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso 
#'  [pnorm][stats::pnorm]
#' @rdname pct
#' @export 
#' @importFrom stats pnorm
pct <- function(x, m, sd) {
  z <- (x - m) / sd
  percentile <- round(stats::pnorm(z) * 100, 0)
  return(percentile)
}
