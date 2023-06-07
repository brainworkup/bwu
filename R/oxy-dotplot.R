#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param data PARAM_DESCRIPTION
#' @param x PARAM_DESCRIPTION
#' @param y PARAM_DESCRIPTION
#' @param domain PARAM_DESCRIPTION, Default: NULL
#' @param fill PARAM_DESCRIPTION, Default: NULL
#' @param size PARAM_DESCRIPTION, Default: NULL
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso 
#'  \code{\link[ggplot2]{ggplot}}, \code{\link[ggplot2]{aes}}, \code{\link[ggplot2]{geom_segment}}, \code{\link[ggplot2]{geom_point}}, \code{\link[ggplot2]{scale_colour_gradient}}, \code{\link[ggplot2]{guide_colourbar}}, \code{\link[ggplot2]{margin}}, \code{\link[ggplot2]{theme}}
#'  \code{\link[stats]{reorder.default}}
#'  \code{\link[ggthemes]{theme_fivethirtyeight}}
#' @rdname dotplot
#' @export 
#' @importFrom ggplot2 ggplot aes geom_segment geom_point scale_fill_gradientn guide_colorbar element_text theme element_rect
#' @importFrom stats reorder
#' @importFrom ggthemes theme_fivethirtyeight
dotplot <- function(data, x, y,
    domain = NULL, fill = NULL, size = NULL, ...) {

  tokyo_palette <- c(
    "#190D33", "#27123A", "#351742", "#421E4A", "#502653",
    "#5C2E5A", "#683863", "#73436A", "#7B4E70", "#815875",
    "#866079", "#89697D", "#8B7280", "#8C7A81", "#8E8385",
    "#908A87", "#919289", "#929A8A", "#94A38D", "#96AB8F",
    "#99B392", "#9CBD95", "#A2C79A", "#ACD3A0", "#B9DFA9",
    "#C8EAB3", "#D8F2BD", "#E6F9C7", "#F3FCD0", "#FEFED8")

  berlin_palette <- c(
    "#9EB0FF", "#85ACF3", "#6BA8E5", "#519FD3", "#3C8EBA", "#307BA0",
    "#286886", "#20546D", "#194155", "#14303E", "#112029", "#111418",
    "#180B09", "#240B01", "#300F00", "#3F1101", "#501802", "#64220D",
    "#7B321C", "#914531", "#A65949", "#BC6D61", "#D18279", "#E89793",
    "#FFACAC")

  roma_palette <- c(
    "#7E1700", "#893107", "#934610", "#9C5717", "#A5681F", "#AD7A27",
    "#B58B31", "#BF9F40", "#C7B354", "#CFC970", "#D2DA90", "#CDE5AC",
    "#C0E9C2", "#ACE7D0", "#93DFD5", "#77D1D7", "#5DC0D2", "#47AECD",
    "#389CC6", "#2F8CBF", "#277AB8", "#2169B0", "#1C58A9", "#1345A0",
    "#023198")

  ggplot2::ggplot(data, ggplot2::aes(x = x, y = stats::reorder(y, x))) +

    ggplot2::geom_segment(ggplot2::aes(xend = 0, yend = y), linewidth = 0.5) +

    ggplot2::geom_point(ggplot2::aes(fill = x), shape = 21, size = NULL, linewidth = 6, color = "black") +

    ggplot2::scale_fill_gradientn(name = "Domain", breaks = NULL, colors = tokyo_palette, guide = ggplot2::guide_colorbar(title.position = "top", title.hjust = 0.5, title.vjust = 0.5, label.hjust = 0.5, label.vjust = 0.5,
      label.position = "bottom", label.theme = ggplot2::element_text(size = 10))) +

    ggthemes::theme_fivethirtyeight() +

    ggplot2::theme(panel.background = ggplot2::element_rect(fill = "white")) +

    ggplot2::theme(plot.background = ggplot2::element_rect(fill = "white")) +

    ggplot2::theme(panel.border = ggplot2::element_rect(color = "white"))
}


