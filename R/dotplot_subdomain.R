### Neurocognitive Strengths and Weaknesses {#subdomain .page-break-before}

## Plot result
subdomain <- 
  ggplot() +
    geom_segment(data = neurocog, aes(x = z_mean_sub, y = reorder(subdomain, z_mean_sub), xend = 0, yend = subdomain), size = 1) +
    # geom_point(data = neurocog, aes(x = z, y = reorder(subdomain, z)), shape = 21, size = 4, color = "orange", fill = "gray") +
    geom_point(data = neurocog, aes(x = z_mean_sub, y = reorder(subdomain, z_mean_sub)), shape = 21, size = 8, color = "black", fill = "orange") +
    theme_fivethirtyeight() +
    theme(panel.background = element_rect(fill = "white")) +
    theme(plot.background = element_rect(fill = "white")) +
    theme(panel.border = element_rect(colour = "white"))
plot(subdomain)
ggsave("subdomain.pdf")
ggsave("subdomain.png")