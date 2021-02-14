# Read csv files
library(here)
library(purrr)
library(dplyr)
library(readr)

# path to files
data_path <- here("data-raw", "neurocog_raw")

# get file names of .csv files
files <- dir(data_path, pattern = "*.csv")

# col types BUT I THINK IT DOESNT MATTER HERE
colLabs <- "cddcdfcfffffffflc"

# read into env
neurocog <- files %>%
  set_names() %>%
  map_df(~ read_csv(file.path(data_path, .)),
         col_types = colLabs,
         na = c(""),
         .id = "filename") %>%
  filter(!is.na(percentile)) %>%
  distinct() %>%
  mutate(z = qnorm(percentile/100))
