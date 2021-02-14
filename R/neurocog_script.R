## purrR
library(purrr)
library(tidyverse)
library(here)
library(ggplot2)

## data import

# Loop over these variables and print out their length
for (variable in 1:length(names(neurocog))) {

  # Get the name of the variable
  name <- names(neurocog)[variable]

  # Get the number of unique entries of that variable
  length <- neurocog[, variable] %>%
    n_distinct()

  print(str_c(name, ": ", length))

}

# I think map_df is extremely useful because you can feed its output directly into a ggplot2 call:

neurocog %>%
  map_df(n_distinct) %>%
  # Convert to longer format
  pivot_longer(everything(), names_to = "variable", values_to = "count") %>%
  # Start plotting
  ggplot(aes(x = variable, y = count)) +
  geom_col() +
  coord_flip()

# Nested tibbles

# Nesting converts grouped data to a form where each group becomes a single row containing a nested data frame, and unnesting does the opposite.
# In our case, we might want to split our data set according to the groups defined in the group variable:

neurocog %>% pull(domain) %>% unique()

# There’s a very simple procedure to do this:

# -Group by your variable of interest using group_by()
# -Use the nest() function

ncog_nested <- neurocog %>%
  group_by(domain) %>%
  nest()

ncog_nested

ncog_nested %>% pull(data)

# You can now access each of these sub data frames e.g. using base R list operators:

ncog_nested$data[[1]] %>% View()

# If you had enough of your nested table, you can easily unnest it again using unnest():

ncog_nested %>%
unnest(data)

### Combining nested tibbles and map
map(ncog_nested$data, nrow)

ncog_nested %>%
  mutate(n_row = map(data, # The first argument of map is our variable named data
                     nrow # The second argument defines the function that needs to be applied
                     )
         )

# Almost there! Remember that map always returns a list? If we expect that the result is one single digit, then it might be easier to use one of the map_*() variants.

ncog_nested %>%
  mutate(n_row = map_int(data,
                         nrow
  )
  )

### purrr map functions

Map functions: beyond apply
A map function is one that applies the same action/function to every element of an object (e.g. each entry of a list or a vector, or each of the columns of a data frame).

eukaryotes_nested %>%
  mutate(n_organisms = map_dbl(data,
                               ~ .x %>% pull(organism_name) %>% n_distinct),
         n_centers = map_dbl(data,
                             ~ .x %>% pull(center) %>% n_distinct),
         n_subgroups = map_dbl(data,
                               ~ .x %>% pull(subgroup) %>%  n_distinct))



ncog %>%
  mutate(
    n_domain = map_dbl(data,
                       ~ .x %>% pull(domain) %>% n_distinct),
    n_subdomain = map_dbl(data,
                          ~ .x %>% pull(subdomain) %>% n_distinct),
    n_subdomain_narrow = map_dbl(data,
                                 ~ .x %>% pull(subdomain_narrow) %>% n_distinct)
  )


ncog <- group_by(ncog, domain) %>%
  ungroup()

ncog %>%
  group_by(subdomain) %>%
  summarize(across(z, mean))
