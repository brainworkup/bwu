# Predicted achievement scores
# 2-time points

predict1 <- predict %>% dplyr::filter(test_type == "composite")
## Plot result
plot_predict1 <- 
  ggplot() +
  geom_segment(data = predict1, aes(x = actual_score_t1, y = reorder(scale, actual_score_t1), xend = actual_score_t2, yend = scale), size = 0.5, 
               arrow = arrow(length = unit(0.04, "npc"))) +
  geom_point(data = predict1, aes(x = predicted_score, y = reorder(scale, predicted_score)), shape = 21, size = 4, color = "orange", fill = "black") +
  geom_point(data = predict1, aes(x = actual_score_t1, y = reorder(scale, actual_score_t1)), shape = 21, size = 4, color = "orange", fill = "gray") +
  geom_point(data = predict1, aes(x = actual_score_t2, y = reorder(scale, actual_score_t2)), shape = 21, size = 4, color = "black", fill = "orange") +
  theme_fivethirtyeight() +
  theme(panel.background = element_rect(fill = "white")) +
  theme(plot.background = element_rect(fill = "white")) +
  theme(panel.border = element_rect(colour = "white"))
plot(plot_predict1)
ggsave("plot_predict1.pdf")
ggsave("plot_predict1.png")