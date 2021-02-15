### Dot Plots Subtests

## Plot result
plot_scale <- 
  ggplot() +
    geom_segment(data = neurocog, aes(x = z, y = reorder(scale, z), xend = 0, yend = scale), size = 0.5) +
    geom_point(data = neurocog, aes(x = z, y = reorder(scale, z)), shape = 21, size = 4, color = "black", fill = "orange") +
    theme_fivethirtyeight() +
    theme(panel.background = element_rect(fill = "white")) +
    theme(plot.background = element_rect(fill = "white")) +
    theme(panel.border = element_rect(colour = "white"))
plot(plot_scale)
ggsave("plot_scale.pdf")
ggsave("plot_scale.png")