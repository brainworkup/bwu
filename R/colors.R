#' Make shades
#'
#' Given a color make \code{n} lighter or darker shades
#'
#' @param color The color to make shades of
#' @param n The number of shades to make
#' @param lighter Whether to make lighter (\code{TRUE}) or darker (\code{FALSE})
#' shades
#'
#' @return A vector of \code{n} color hex codes
#' @export
#'
#' @examples
#' # Five lighter shades
#' make_shades("goldenrod", 5)
#' # Five darker shades
#' make_shades("goldenrod", 5, lighter = FALSE)
make_shades <- function(color, n, lighter = TRUE) {
  # Check the value of n
  if (n < 1) {
    stop("n must be at least 1")
  }

  # Convert the color to RGB
  color_rgb <- grDevices::col2rgb(color)[, 1]

  # Decide if we are heading towards white or black
  if (lighter) {
    end <- 255
  } else {
    end <- 0
  }

  # Calculate the red, green and blue for the shades
  # we calculate one extra point to avoid pure white/black
  red <- seq(color_rgb[1], end, length.out = n + 1)[1:n]
  green <- seq(color_rgb[2], end, length.out = n + 1)[1:n]
  blue <- seq(color_rgb[3], end, length.out = n + 1)[1:n]

  # Convert the RGB values to hex codes
  shades <- grDevices::rgb(red, green, blue, maxColorValue = 255)

  return(shades)
}


#' Plot colors
#'
#' Plot a vector of colours to see what they look like
#'
#' @param colors Vector of colour to plot
#'
#' @return A ggplot2 object
#' @export
#'
#' @importFrom rlang .data
#'
#' @examples
#' shades <- make_shades("goldenrod", 5)
#' plot_colors(shades)
plot_colors <- function(colors) {
  plot_data <- data.frame(Color = colors)

  ggplot2::ggplot(
    plot_data,
    ggplot2::aes(
      x = .data$Color, y = 1, fill = .data$Color,
      label = .data$Color
    )
  ) +
    ggplot2::geom_tile() +
    ggplot2::geom_text(angle = "90") +
    ggplot2::scale_fill_identity() +
    ggplot2::theme_void()
}
