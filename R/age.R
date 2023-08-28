#' @title Compute age
#' @description Compute age of someone.
#' @param birthDate Date of birth
#' @param refDate Reference date, Default: Sys.Date()
#' @param unit Date unit, Default: 'year'
#' @return OUTPUT_DESCRIPTION
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
