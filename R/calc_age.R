<<<<<<< HEAD
#' Calculate age
#'
#' Calculate age at a given reference date
#' Create an interval between the date of birth and the enrollment date;
#' intervals are specific to the two dates. Periods give the actual length
#' of time between those dates, so convert to period and extract the year.
#'
#' @param birthDate date of birth
#' @param refDate date of evaluation
#' @param unit unit year, month or day
#'
#' @return age
#' @export
#'
#' @examples
#'
#' dob <- "1977-07-13"
#' doe <- "2021-04-04"
#' calc_age(dob, doe)
calc_age <- function(birthDate, refDate = Sys.Date(), unit = "year") {

  if(grepl(x = unit, pattern = "year")) {
    lubridate::as.period(lubridate::interval(birthDate, refDate), unit = 'year')$year
  } else if(grepl(x = unit, pattern = "month")) {
    lubridate::as.period(lubridate::interval(birthDate, refDate), unit = 'month')$month
  } else if(grepl(x = unit, pattern = "week")) {
    floor(lubridate::as.period(lubridate::interval(birthDate, refDate), unit = 'day')$day / 7)
  } else if(grepl(x = unit, pattern = "day")) {
    lubridate::as.period(lubridate::interval(birthDate, refDate), unit = 'day')$day
=======
# Calculate age at a given reference date
# Create an interval between the date of birth and the enrollment date;
# intervals are specific to the two dates. Periods give the actual length
# of time between those dates, so convert to period and extract the year.

calc_age <- function(birthDate, refDate = Sys.Date(), unit = "year") {

  if(grepl(x = unit, pattern = "year")) {
    as.period(interval(birthDate, refDate), unit = 'year')$year
  } else if(grepl(x = unit, pattern = "month")) {
    as.period(interval(birthDate, refDate), unit = 'month')$month
  } else if(grepl(x = unit, pattern = "week")) {
    floor(as.period(interval(birthDate, refDate), unit = 'day')$day / 7)
  } else if(grepl(x = unit, pattern = "day")) {
    as.period(interval(birthDate, refDate), unit = 'day')$day
>>>>>>> 1cc1672b541eb2d4bc558c9888fc04852f2d61d7
  } else {
    print("Argument 'unit' must be one of 'year', 'month', 'week', or 'day'")
    NA
  }

}
