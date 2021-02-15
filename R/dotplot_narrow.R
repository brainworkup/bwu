### Cognitive and Academic Strengths and Weaknesses {#subdomain-narrow .page-break-before}

## Plot result
plot_subdomain_narrow <- 
  neurocog %>% 
  mutate(subdomain_narrow = na_if(subdomain_narrow, NA)) %>% 
  ggplot() +
    geom_segment(data = neurocog, aes(x = z_mean_narrow, y = reorder(subdomain_narrow, z_mean_narrow), xend = 0, yend = subdomain_narrow), size = 1) +
    # geom_point(data = neurocog, aes(x = z, y = reorder(subdomain_narrow, z)), shape = 21, size = 4, color = "orange", fill = "gray") +
    geom_point(data = neurocog, aes(x = z_mean_narrow, y = reorder(subdomain_narrow, z_mean_narrow)), shape = 21, size = 6, color = "black", fill = "orange") +
    theme_fivethirtyeight() +
    theme(panel.background = element_rect(fill = "white")) +
    theme(plot.background = element_rect(fill = "white")) +
    theme(panel.border = element_rect(colour = "white"))
plot(plot_subdomain_narrow)
ggsave("plot_subdomain_narrow.pdf")
ggsave("plot_subdomain_narrow.png")