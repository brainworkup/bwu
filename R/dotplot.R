#' Make a dotplot for cognitive domains
#'
#' Description of the function.
#'
#' @param data Name of dataset
#' @param x Name of x-axis variable
#' @param y Name of y-axis variable
#' @param theme Name of ggtheme
#' @param ... Additional arguments
#' @return A dotplot using ggplot2
#'
#' @examples
#' dotplot(iris, iris$Sepal.Length, iris$Species)
#'
#' @export
dotplot <- function(data, x, y, theme = ggthemes::theme_fivethirtyeight(), ...) {
  ggplot2::ggplot() +
    ggplot2::geom_segment(
      data = data,
      ggplot2::aes(
        x = x,
        y = stats::reorder(y, x),
        xend = 0,
        yend = y
      ),
      size = 0.5
    ) +
    ggplot2::geom_point(
      data = data,
      ggplot2::aes(x = x, y = stats::reorder(y, x)),
      shape = 21,
      size = 6,
      color = "black",
      fill = "orange"
    ) +
    theme <- theme +
    ggplot2::theme(panel.background = ggplot2::element_rect(fill = "white")) +
    ggplot2::theme(plot.background = ggplot2::element_rect(fill = "white")) +
    ggplot2::theme(panel.border = ggplot2::element_rect(color = "white"))
}
