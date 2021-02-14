# Download from google sheets

library(readr)
library(dplyr)
library(purrr)
library(tidyr)
library(dplyr)
library(devtools)
library(here)

# create directory for storing raw CSVs
RAW_CSV_DIR <- "data-raw/neurocog_raw/"
dir.create(RAW_CSV_DIR, showWarnings = FALSE)

# paths to CSV files of test batteries
#test.battery <- c("WISC", "WRAT", "NEPSY", "KTEA", "EXAMINER")
test <- c("WISC", "WRAT", "NEPSY")
csv <- file.path(RAW_CSV_DIR, paste0(test, ".csv"))
csv1 <- file.path(RAW_CSV_DIR, paste0(test[1], ".csv"))
csv2 <- file.path(RAW_CSV_DIR, paste0(test[2], ".csv"))
csv3 <- file.path(RAW_CSV_DIR, paste0(test[3], ".csv"))

url1 <- paste0("https://docs.google.com/spreadsheets/d/e/2PACX-1vTehWzImZWaM2JdzwO8YPido2ymMN62aSzA8epjtrCl8pATAqJbgFwrI8hybC3HsJ5dY1UJaVq2iAzh/pub?output=csv")

url2 <- paste0("https://docs.google.com/spreadsheets/d/e/2PACX-1vS52KCrRdgPQfA8ZcfWS1L_40J7DLK8Ja0TLxusUxqWVzn4DcLTOquxGk5Yt-7W7V5kzHA4e3I3K62z/pub?output=csv")

url3 <- paste0("https://docs.google.com/spreadsheets/d/e/2PACX-1vRuvFZz9uObm8kCZ2zVlQ2P8abu5OB0aGRqJZehZQ3NJIyyMThngMLdycMvJ6I5qMAoMy-Z6WlvY1UN/pub?output=csv")

walk2(url1, csv1, function(x, dest) download.file(x, destfile = dest))
walk2(url2, csv2, function(x, dest) download.file(x, destfile = dest))
walk2(url3, csv3, function(x, dest) download.file(x, destfile = dest))

# read the CSV files
batteries <- map(csv, read_csv,
              col_types = cols(
                scale = col_character(),
                score = col_double(),
                percentile = col_double(),
                range = col_character()
              )
)

neurocog <- map_df(csv, read_csv,
                 col_types = cols(
                   scale = col_character(),
                   score = col_double(),
                   percentile = col_double(),
                   range = col_character()
                 )
)

write.csv(neurocog, "data-raw/neurocog.csv", row.names = FALSE, quote = FALSE)
usethis::use_data(neurocog, overwrite = TRUE)
