
# split and compute means by group

split_data_frame <- function(df, gp, y, ...) {
  do.call(rbind, lapply(split(df, df$gp), function(d) {
    data.frame(mean = mean(d$y),
               sd = sd(d$y),
               gp = d$gp)
  }))
}



library(dplyr)
library(purrr)
library(stringr)

m2 <- map(neurocog1, ~ sample(neurocog, .x)) %>%
  map_df(~ data.frame(mean = mean(.x),
                      sd = sd(.x)), .id = "n")


x1 <- neurocog %>%
  # filter(domain %>% str_starts("domain_")) %>%
  group_by(domain) %>%
  summarize_at("z", mean)

map.lgl <- map(neurocog, is.logical)
map.mean <- map(neurocog, mean)


nest_by <- function(df, ...) {
  df %>%
    group_by(...) %>%
    summarise(data = list(across())) %>%
    rowwise(...)
}

neurocog %>% nest_by(domain)
neurocog %>% rowwise()

summary(neurocog)
## skimr package
skim(neurocog)

neurocog %>%
  dplyr::group_by(domain) %>%
  skim()


neurocog %>%
  group_by(domain) %>%
  summarize()
summarize(neurocog, avg = mean(z))

group_by_domain <- function(neurocog, domain, is.numeric, .) {
  by_domain <- neurocog %>% group_by(domain) %>%
    summarize_if(is.numeric, list(~ mean(., ns.rm = TRUE), ~ sd(., na.rm = TRUE))) %>%
    ungroup()
}




## subset
library(tidyverse)

# Create dummy data
df<- data.frame(loc = rep(c("l1", "l2"), each = 3),
                name = rep(c("A", "B"), 3),
                grid = c(5,6,7,2,3,5),
                area = c(5,10,1,1,3,1),
                areaOrig = rep(c(20, 10, 5), each = 2))

df2<-rbind(df, df)

# Create two mountain types types
df2$type = rep(c("y", "z"), each = 6)

by_type <- df2 %>%
  group_by(type) %>%
  nest() %>%
  mutate(plot = map(data,
                    ~ggplot(. ,aes(x = grid, y = area)) +
                      geom_bar(stat = "identity") +
                      ggtitle(.) +
                      facet_grid(loc ~name)))

by_type

# You can then easily look at your data with by_type$plot, or save them with

by_type$plot

walk2(by_type$type, by_type$plot,
      ~ggsave(paste0(.x, ".pdf"), .y))

library(tidyverse) # Load all "tidyverse" libraries.

library(viridis)   # Viridis color scale.
vignette()
vignette(package="dplyr")
vignette("dplyr", package="dplyr")
bigtab <- read_csv("r-more-files/fastqc.csv")

counts_untidy <- read_csv("r-more-files/read-counts.csv")


counts <- neurocog %>%
  gather(key=sample, value=count, -description, factor_key=TRUE) %>%
  separate(sample, sep=":", into=c("strain","time"), convert=TRUE, remove=FALSE) %>%
  mutate(
    strain = factor(strain, levels=c("WT","SET1","RRP6","SET1-RRP6"))
  ) %>%
  filter(time >= 2) %>%
  select(sample, strain, time, gene=Feature, count)

summary(counts)
