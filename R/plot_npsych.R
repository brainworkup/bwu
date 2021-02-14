# 02_NT Plots
library(tidyverse)

# Loop over these variables and print out their length
for (variable in 1:length(names(neurocog))) {

  # Get the name of the variable
  name <- names(neurocog)[variable]

  # Get the number of unique entries of that variable
  length <- neurocog[, variable] %>%
    n_distinct()

  print(str_c(name, ": ", length))

}

# split and compute means by group
neurocog <- do.call(rbind, lapply(split(neurocog, neurocog$domain), function(d) {
  data.frame(z_mean = mean(d$z), z_sd = sd(d$z), domain = d$domain)
}))

# Create plot
ggplot() +
  geom_segment(neurocog, aes(x = z_mean, y = reorder(domain, z_mean), xend = 0, yend = domain), size = 1) +
  geom_point(data = neurocog, aes(x = z, y = reorder(domain, z)), shape = 21, size = 2, color = "orange", fill = "black") +
  geom_point(data = neurocog, aes(x = z_mean, y = reorder(domain, z_mean)), shape = 21, size = 8, color = "black", fill = "orange") +
  theme_fivethirtyeight() +
  theme(panel.background = element_rect(fill = "white")) +
  theme(plot.background = element_rect(fill = "white")) +
  theme(panel.border = element_rect(colour = "white"))


gplot_dots(neurocog, z_mean_sub, subdomain)

gg_dot_plot(neurocog, z_mean_sub, subdomain, z)

gg_plot_dots(neurocog, z_mean_dom = z_mean_narrow, domain = subdomain_narrow, z = z)
