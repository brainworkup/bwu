#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param data PARAM_DESCRIPTION
#' @param x PARAM_DESCRIPTION
#' @param y PARAM_DESCRIPTION
#' @param linewidth PARAM_DESCRIPTION, Default: 0.5
#' @param fill PARAM_DESCRIPTION, Default: x
#' @param shape PARAM_DESCRIPTION, Default: 21
#' @param point_size PARAM_DESCRIPTION, Default: 6
#' @param line_color PARAM_DESCRIPTION, Default: 'black'
#' @param colors PARAM_DESCRIPTION, Default: NULL
#' @param theme PARAM_DESCRIPTION, Default: 'fivethirtyeight'
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso 
#'  [ggplot][ggplot2::ggplot], [geom_segment][ggplot2::geom_segment], [aes][ggplot2::aes], [geom_point][ggplot2::geom_point], [scale_fill_gradientn][ggplot2::scale_fill_gradientn], [theme_minimal][ggplot2::theme_minimal], [theme_classic][ggplot2::theme_classic], [theme][ggplot2::theme], [element_rect][ggplot2::element_rect]
#'  [reorder][stats::reorder]
#'  [theme_fivethirtyeight][ggthemes::theme_fivethirtyeight]
#' @rdname dotplot
#' @export 
#' @importFrom ggplot2 ggplot geom_segment aes geom_point scale_fill_gradientn theme_minimal theme_classic theme element_rect
#' @importFrom stats reorder
#' @importFrom ggthemes theme_fivethirtyeight
dotplot <- function(data, x, y, linewidth = 0.5, fill = x, shape = 21, point_size = 6, line_color = "black", colors = NULL, theme = "fivethirtyeight") {
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


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param data PARAM_DESCRIPTION
#' @param x PARAM_DESCRIPTION
#' @param y PARAM_DESCRIPTION
#' @param linewidth PARAM_DESCRIPTION, Default: 0.5
#' @param fill PARAM_DESCRIPTION, Default: x
#' @param shape PARAM_DESCRIPTION, Default: 21
#' @param point_size PARAM_DESCRIPTION, Default: 6
#' @param line_color PARAM_DESCRIPTION, Default: 'black'
#' @param colors PARAM_DESCRIPTION, Default: NULL
#' @param theme PARAM_DESCRIPTION, Default: 'fivethirtyeight'
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso 
#'  [ggplot][ggplot2::ggplot], [geom_segment][ggplot2::geom_segment], [aes][ggplot2::aes], [geom_point][ggplot2::geom_point], [scale_fill_gradientn][ggplot2::scale_fill_gradientn], [theme_minimal][ggplot2::theme_minimal], [theme_classic][ggplot2::theme_classic], [theme][ggplot2::theme], [element_rect][ggplot2::element_rect]
#'  [reorder][stats::reorder]
#'  [theme_fivethirtyeight][ggthemes::theme_fivethirtyeight]
#' @rdname fig_dotplot
#' @export 
#' @importFrom ggplot2 ggplot geom_segment aes geom_point scale_fill_gradientn theme_minimal theme_classic theme element_rect
#' @importFrom stats reorder
#' @importFrom ggthemes theme_fivethirtyeight
fig_dotplot <- function(data, x, y, linewidth = 0.5, fill = x, shape = 21, point_size = 6, line_color = "black", colors = NULL, theme = "fivethirtyeight") {
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
