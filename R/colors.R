#' Make shades
#' Given a color make \code{n} lighter or darker shades
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


roma <- c(
  "#7E1700", "#893107", "#934610", "#9C5717", "#A5681F", "#AD7A27",
  "#B58B31", "#BF9F40", "#C7B354", "#CFC970", "#D2DA90", "#CDE5AC",
  "#C0E9C2", "#ACE7D0", "#93DFD5", "#77D1D7", "#5DC0D2", "#47AECD",
  "#389CC6", "#2F8CBF", "#277AB8", "#2169B0", "#1C58A9", "#1345A0",
  "#023198"
)

#' @title Create a color palette from the Roma palette
#'
#' @description Create a color palette from the Roma palette containing 24 colors. If n is greater than the length of roma, return the full palette.
#'
#' @param n The number of colors to sample from the Roma palette.
#'
#' @return A vector of colors sampled from the Roma palette.
#'
#' @examples
#' \dontrun{
#' roma_palette(3)
#' }
#'
#' @export
roma_palette <- function(n) {
  # If n is greater than the length of roma, return the full palette
  if (n > length(roma)) {
    warning("Requested more colors than available in the palette. Returning the full palette.")
    return(roma)
  }

  # Sample n colors from the roma palette
  sample(roma, n, replace = FALSE)
}
