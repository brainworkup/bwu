
# Make npsych dot plots by domain
library(ggplot2)
library(ggthemes)

# domain
gg_dot_plot <- function(neurocog, z_mean_dom, domain, z) {
  ggplot() +

    geom_segment(data = neurocog, aes(x = z_mean_dom, y = reorder(yend = domain, x = z_mean_dom), xend = 0, yend = domain), size = 1) +

    geom_point(data = neurocog, aes(x = z, y = reorder(yend = domain, x = z)), shape = 21, size = 4, color = "orange", fill = "gray") +

    geom_point(data = neurocog, aes(x = z_mean_dom, y = reorder(domain, z_mean_dom)), shape = 21, size = 8, color = "black", fill = "orange") +

    theme_fivethirtyeight() +
    theme(panel.background = element_rect(fill = "white")) +
    theme(plot.background = element_rect(fill = "white")) +
    theme(panel.border = element_rect(colour = "white"))
}


# subdomain
ggplot() +
  geom_segment(data = neurocog, aes(x = z_mean_sub, y = reorder(subdomain, z_mean_sub), xend = 0, yend = subdomain), size = 1) +
  geom_point(data = neurocog, aes(x = z, y = reorder(subdomain, z)), shape = 21, size = 4, color = "orange", fill = "gray") +
  geom_point(data = neurocog, aes(x = z_mean_sub, y = reorder(subdomain, z_mean_sub)), shape = 21, size = 8, color = "black", fill = "orange") +
  theme_fivethirtyeight() +
  theme(panel.background = element_rect(fill = "white")) +
  theme(plot.background = element_rect(fill = "white")) +
  theme(panel.border = element_rect(colour = "white"))

# subdomain narrow
ggplot() +

  geom_segment(data = neurocog, aes(x = z_mean_narrow, y = reorder(subdomain_narrow, z_mean_narrow), xend = 0, yend = subdomain_narrow), size = 1) +

  geom_point(data = neurocog, aes(x = z, y = reorder(subdomain_narrow, z)), shape = 21, size = 4, color = "orange", fill = "gray") +

  geom_point(data = neurocog, aes(x = z_mean_narrow, y = reorder(subdomain_narrow, z_mean_narrow)), shape = 21, size = 8, color = "black", fill = "orange") +

  theme_fivethirtyeight() +
  theme(panel.background = element_rect(fill = "white")) +
  theme(plot.background = element_rect(fill = "white")) +
  theme(panel.border = element_rect(colour = "white"))
