### Broad Domain Scores {#domain .page-break-before}

## Plot result
plot_domain <- 
  ggplot() +
    geom_segment(data = neurocog, aes(x = z_mean_dom, y = reorder(domain, z_mean_dom), xend = 0, yend = domain), size = 0.5) +
    #geom_point(data = neurocog, aes(x = z, y = reorder(domain, z)), shape = 21, size = 4, color = "orange", fill = "gray") +
    geom_point(data = neurocog, aes(x = z_mean_dom, y = reorder(domain, z_mean_dom)), shape = 21, size = 6, color = "black", fill = "orange") +
    theme_fivethirtyeight() +
    theme(panel.background = element_rect(fill = "#be9696")) +
    theme(plot.background = element_rect(fill = "#ad9d9d")) +
    theme(panel.border = element_rect(colour = "#4e4c4c"))
plot(plot_domain)
ggsave("plot_domain.pdf")
ggsave("plot_domain.png")