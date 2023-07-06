#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param birthDate PARAM_DESCRIPTION
#' @param refDate PARAM_DESCRIPTION, Default: Sys.Date()
#' @param unit PARAM_DESCRIPTION, Default: 'year'
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso 
#'  [as.period][lubridate::as.period], [interval][lubridate::interval]
#' @rdname age
#' @export 
#' @importFrom lubridate as.period interval
age <-
  function(birthDate, refDate = Sys.Date(), unit = "year") {
    if (grepl(x = unit, pattern = "year")) {
      lubridate::as.period(lubridate::interval(birthDate, refDate), unit = "year")$year
    } else if (grepl(x = unit, pattern = "month")) {
      lubridate::as.period(lubridate::interval(birthDate, refDate), unit = "month")$month
    } else if (grepl(x = unit, pattern = "week")) {
      floor(lubridate::as.period(lubridate::interval(birthDate, refDate), unit = "day")$day / 7)
    } else if (grepl(x = unit, pattern = "day")) {
      lubridate::as.period(lubridate::interval(birthDate, refDate), unit = "day")$day
    } else {
      print("Argument 'unit' must be one of 'year', 'month', 'week', or 'day'")
      NA
    }
  }
