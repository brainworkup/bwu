#' Roma Color Palette
#'
#' A color palette named `roma`.
#'
#' @examples
#' barplot(1:10, col = roma[1:10])
#'
#' @export
roma <- c(
  "#7E1700",
  "#832504",
  "#883008",
  "#8E3B0B",
  "#92450F",
  "#984E14",
  "#9C5717",
  "#A05F1B",
  "#A4671E",
  "#A86F22",
  "#AD7826",
  "#B0802B",
  "#B58A30",
  "#B99336",
  "#BD9C3D",
  "#C2A647",
  "#C7B051",
  "#CBBA5D",
  "#CEC56C",
  "#D0CE7A",
  "#D2D78A",
  "#D1DE98",
  "#CFE4A6",
  "#CBE7B3",
  "#C4EABD",
  "#BCEAC6",
  "#B2E8CD",
  "#A7E6D2",
  "#9BE2D4",
  "#8EDDD7",
  "#80D6D7",
  "#73CED5",
  "#65C6D5",
  "#59BDD2",
  "#4FB5D0",
  "#45ABCB",
  "#3DA3C8",
  "#379BC5",
  "#3292C2",
  "#2E8ABF",
  "#2A81BA",
  "#2779B7",
  "#2471B4",
  "#2269B0",
  "#1F60AD",
  "#1B57A8",
  "#184EA4",
  "#1344A0",
  "#0C3B9C",
  "#023198"
)

#' Hawaii Color Palette
#'
#' A color palette named `hawaii`.
#'
#' @examples
#' barplot(1:10, col = hawaii[1:10])
#'
#' @export
hawaii <- c(
  "#8C0172",
  "#8D126A",
  "#8F1E62",
  "#912859",
  "#923152",
  "#94394C",
  "#944245",
  "#964B3F",
  "#965339",
  "#995D33",
  "#9A652E",
  "#9B6F28",
  "#9B7922",
  "#9D841D",
  "#9C901B",
  "#9A9B1E",
  "#97A727",
  "#91B135",
  "#8ABB46",
  "#81C359",
  "#7AC86B",
  "#71CF7E",
  "#69D592",
  "#62DBA5",
  "#5FE1B9",
  "#61E6CC",
  "#6EEADD",
  "#82EFEB",
  "#9AF1F6",
  "#B2F2FD"
)

#' Tokyo Color Palette
#'
#' A color palette named `tokyo`.
#'
#' @examples
#' barplot(1:10, col = tokyo[1:10])
#'
#' @export
tokyo <- c(
  "#190D33",
  "#27123A",
  "#351742",
  "#421E4A",
  "#502653",
  "#5C2E5A",
  "#683863",
  "#73436A",
  "#7B4E70",
  "#815875",
  "#866079",
  "#89697D",
  "#8B7280",
  "#8C7A81",
  "#8E8385",
  "#908A87",
  "#919289",
  "#929A8A",
  "#94A38D",
  "#96AB8F",
  "#99B392",
  "#9CBD95",
  "#A2C79A",
  "#ACD3A0",
  "#B9DFA9",
  "#C8EAB3",
  "#D8F2BD",
  "#E6F9C7",
  "#F3FCD0",
  "#FEFED8"
)

#' Vik Color Palette
#'
#' A color palette named `vik`.
#'
#' @examples
#' barplot(1:10, col = vik[1:10])
#'
#' @export
vik <- c(
  "#590007",
  "#6E1006",
  "#862206",
  "#A13C0B",
  "#B75926",
  "#C27142",
  "#CC875F",
  "#D69F7E",
  "#E0B89F",
  "#EBD0C2",
  "#EBE5E0",
  "#CEDFE7",
  "#A6C9D9",
  "#7DB0C9",
  "#5596B7",
  "#2F7CA5",
  "#116496",
  "#034D87",
  "#01397A",
  "#02266D",
  "#001260"
)

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

#' @title Create a color palette from the Scico palette
#'
#' @description Create a color palette from the Roma palette containing 24 colors. If n is greater than the length of roma, return the full palette.
#'
#' @param n The number of colors to sample from the Roma palette.
#' @param palette Palettes from `scico`.
#'
#' @return A vector of colors sampled from the `scico` palette.
#'
#' @examples
#' \dontrun{
#' scico_palette(11, "hawaii")
#' }
#'
#' @export
scico_palette <- function(n, palette = c("roma", "hawaii", "tokyo", "vik")) {
  # If n is greater than the length of roma, return the full palette
  if (n > length(palette)) {
    warning("Requested more colors than available in the palette. Returning the full palette.")
    return(palette)
  }

  # Sample n colors from the palette
  sample(palette, n, replace = FALSE)
}
