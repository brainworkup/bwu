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
  } else {
    print("Argument 'unit' must be one of 'year', 'month', 'week', or 'day'")
    NA
  }

}
