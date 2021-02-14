# Calculate age at a given reference date
# Create an interval between the date of birth and the enrollment date;
# intervals are specific to the two dates. Periods give the actual length
# of time between those dates, so convert to period and extract the year.

calc_age <- function(birthDate, refDate = Sys.Date(), unit = "year") {

  require(lubridate)

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


# Examples
calc_age("1990-06-30") # As long as the date is %Y-%m-%d formatted, it can be a character
calc_age("1990-06-30", unit = "months") # Other units available
calc_age("1990-06-30", "2003-07-12")   # Calculate age at any date
# Works for babies:
calc_age("1990-06-30", "1990-12-12", unit = "month")
calc_age("1990-06-30", "1990-12-12", unit = "week")

# Works for multiple reference dates, too
calc_age(birthDate = "1990-06-30",
         refDate = seq(from = as.Date("2003-01-01"), to = as.Date("2012-01-01"), by = "year")
)
