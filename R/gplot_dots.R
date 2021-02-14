

# Make npsych dot plots by domain
require(ggplot2)
require(ggthemes)

plots_fx <- function(neurocog, z_mean_dom, domain, z) {

    # dot plots
    ggplot() +

      # segment plot; required_aes: x y xend yen
      geom_segment(
        data = data,
        aes(x = x, y = reorder(yend = yend, x = x),
            xend = 0,
            yend = yend
            ),
        size = 1) +

      # smaller individual data points
      geom_point(
        data = data,
        aes(z, y = reorder(yend = yend, z), inherit.aes = FALSE ),
        shape = 21,
        size = 4,
        color = "orange",
        fill = "gray"
      ) +

      # large mean dots
      geom_point(
        data = data,
        aes(x = x, y = reorder(yend = yend, x = x)),
        shape = 21,
        size = 8,
        color = "black",
        fill = "orange"
      ) +

      # theme
      theme_fivethirtyeight() +
      theme(panel.background = element_rect(fill = "white")) +
      theme(plot.background = element_rect(fill = "white")) +
      theme(panel.border = element_rect(colour = "white"))

  }

gplot_dots()
