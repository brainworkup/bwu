#' @title Create a dotplot
#' @description This function generates a dot plot with the given data, x and y. The point's aesthetics and plot theme can be customized.
#' @param data The data frame containing the data for the dot plot.
#' @param x The column name in the data frame for the x-axis variable.
#' @param y The column name in the data frame for the y-axis variable.
#' @param linewidth The width of the line, Default: 0.5
#' @param fill The fill color for the points, Default: x-axis variable
#' @param shape The shape of the points, Default: 21
#' @param point_size The size of the points, Default: 6
#' @param line_color The color of the lines, Default: 'black'
#' @param colors A vector of colors for fill gradient, Default: NULL (uses pre-defined color palette)
#' @param theme The ggplot theme to be used, Default: 'fivethirtyeight'. Other options include 'minimal' and 'classic'
#' @return An object of class 'ggplot' representing the dot plot.
#' @details This function generates a dot plot with the given data, x and y. The points' aesthetics and plot theme can be customized.
#' @rdname dotplot
#' @export
#' @importFrom ggplot2 ggplot geom_segment aes geom_point scale_fill_gradientn theme element_rect
#' @importFrom stats reorder
#' @importFrom ggthemes theme_fivethirtyeight
dotplot <- function(data, x, y, linewidth = 0.5, fill, shape = 21, point_size = 6, line_color = "black", colors = NULL, theme = "fivethirtyeight") {
  # Define the color palette
  color_palette <- if (is.null(colors)) {
    c(
      "#190D33", "#27123A", "#351742", "#421E4A", "#502653",
      "#5C2E5A", "#683863", "#73436A", "#7B4E70", "#815875",
      "#866079", "#89697D", "#8B7280", "#8C7A81", "#8E8385",
      "#908A87", "#919289", "#929A8A", "#94A38D", "#96AB8F",
      "#99B392", "#9CBD95", "#A2C79A", "#ACD3A0", "#B9DFA9",
      "#C8EAB3", "#D8F2BD", "#E6F9C7", "#F3FCD0", "#FEFED8"
    )
  } else {
    colors
  }

  # Make the plot
  plot_object <-
    ggplot2::ggplot() +
    ggplot2::geom_segment(
      data = data,
      ggplot2::aes(
        x = x,
        y = stats::reorder(y, x),
        xend = 0,
        yend = y
      ),
      color = line_color,
      linewidth = linewidth
    ) +
    ggplot2::geom_point(
      data = data,
      ggplot2::aes(
        x = x,
        y = stats::reorder(y, x),
        fill = x
      ),
      shape = shape,
      size = point_size,
      color = line_color
    ) +
    ggplot2::scale_fill_gradientn(colors = color_palette, guide = "none")

  # Apply theme
  plot_object <- plot_object +
    switch(theme,
           "fivethirtyeight" = ggthemes::theme_fivethirtyeight(),
           "minimal" = ggplot2::theme_minimal(),
           "classic" = ggplot2::theme_classic(),
           ggplot2::theme_minimal()
    )

  plot_object <- plot_object +
    ggplot2::theme(
      panel.background = ggplot2::element_rect(fill = "white"),
      plot.background = ggplot2::element_rect(fill = "white"),
      panel.border = ggplot2::element_rect(color = "white")
    )

  return(plot_object)
}
