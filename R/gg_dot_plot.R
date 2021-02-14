
# Make npsych dot plots by domain
library(ggplot2)
library(ggthemes)

gg_dot_plot <- function(data = neurocog, x = z_mean, y = y_axis, z = z_score, ...) {
  ggplot() +
    geom_segment(data = neurocog, aes(x = z_mean_dom, y = reorder(domain, z_mean_dom), xend = 0, yend = domain), size = 1) +
    geom_point(data = neurocog, aes(x = z, y = reorder(domain, z)), shape = 21, size = 4, color = "orange", fill = "gray") +
    geom_point(data = neurocog, aes(x = z_mean_dom, y = reorder(domain, z_mean_dom)), shape = 21, size = 8, color = "black", fill = "orange") +
    theme_fivethirtyeight() +
    theme(panel.background = element_rect(fill = "white")) +
    theme(plot.background = element_rect(fill = "white")) +
    theme(panel.border = element_rect(colour = "white"))

gg_dot_plot()

  }


gg_dot_plot(neurocog, z_mmean_dom, domain, z)
