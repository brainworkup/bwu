# Read csv files
library(here)
library(purrr)
library(dplyr)
library(readr)
library(data.table)
library(collapse)
library(magrittr)
library(ggplot2)
library(tidyr)

# path to files
data_path <- here("data-raw", "neurocog_raw")

# get file names of .csv files
files <- dir(data_path, pattern = "*_kb.csv")

# col types
colLabs <- ("cddcdfcffffffffl")

# read into env
neurocog <- files %>%
  purrr::set_names() %>%
  map_df(~ read_csv(file.path(data_path, .)),
         col_types = cols(colLabs),
         na = c(""),
         .id = "filename") %>%
  mutate(z = qnorm(percentile/100)) %>%
  #select(z, everything()) %>%
  filter(!is.na(z)) %>%
  mutate(z_mean = mean(z), z_sd = sd(z))

neurocog$test_name <- parse_factor(neurocog$test_name)
neurocog$domain <- parse_factor(neurocog$domain)
neurocog$subdomain <- parse_factor(neurocog$subdomain)
neurocog$subdomain_narrow <- parse_factor(neurocog$subdomain_narrow)
neurocog$domain_broad <- parse_factor(neurocog$domain_broad)
neurocog$domain_test <- parse_factor(neurocog$domain_test)
neurocog$test_type <- parse_factor(neurocog$test_type)
neurocog$score_type <- parse_factor(neurocog$score_type)

glimpse(neurocog)

neurocog <-
  neurocog %>%
  group_by(domain, .add = TRUE) %>%
  mutate(z_mean_dom = mean(z), z_sd_dom = sd(z)) %>%
  group_by(subdomain, .add = TRUE) %>%
  mutate(z_mean_sub = mean(z), z_sd_sub = sd(z)) %>%
  group_by(subdomain_narrow, .add = TRUE) %>%
  mutate(z_mean_narrow = mean(z), z_sd_narrow = sd(z))


neurocog %>%
  map_df(n_distinct) %>%
  # Convert to longer format
  pivot_longer(everything(), names_to = "variable", values_to = "count") %>%
  # Start plotting
  ggplot(aes(x = variable, y = count)) +
  geom_col() +
  coord_flip()

readr::write_csv(neurocog, "data-raw/neurocog_raw/neurocog-kb.csv")


