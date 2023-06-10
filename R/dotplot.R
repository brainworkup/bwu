#' @title Create Dotplots of Cognitive Domains
#' @description Make a dotplot for cognitive domains.
#' @param data Dataset variable.
#' @param x X Mean z-score of domain.
#' @param y Y Domain/variable name of the y-axis.
#' @param fill Optional name of variable to fill points by
#' @param size Dot size, Default: NULL
#' @param palette Color palette
#' @param ... other arguments to be passed to
#'   \code{\link[ggplot2]{geom_dotplot}}.
#' @return Produce a dotplot of domain scores
#' @details This is used to collapse individual test scores into composites and
#' then plot them ...
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#' }
#' }
#' @seealso
#'  \code{\link[ggplot2]{ggplot}}, \code{\link[ggplot2]{aes}},
#'  \code{\link[ggplot2]{geom_segment}}, \code{\link[ggplot2]{geom_point}},
#'  \code{\link[ggplot2]{scale_colour_gradient}},
#'  \code{\link[ggplot2]{guide_colourbar}}, \code{\link[ggplot2]{margin}},
#'  \code{\link[ggplot2]{theme}}
#'  \code{\link[stats]{reorder.default}}
#'  \code{\link[ggthemes]{theme_fivethirtyeight}}
#' @rdname dotplot
#' @export
#' @importFrom ggplot2 ggplot aes geom_segment geom_point element_text theme element_rect
#' @importFrom stats reorder
#' @importFrom ggthemes theme_fivethirtyeight
dotplot <- function(
    data, x, y,
    fill = NULL, size = NULL, palette = NULL, ...) {
  ggplot2::ggplot(data) +
    ggplot2::geom_segment(
      aes(x, y = stats::reorder(y, x), xend = 0, yend = y),
      linewidth = 0.5
    ) +
    ggplot2::geom_point(
      aes(x, y = stats::reorder(y, x)),
      shape = 21,
      linewidth = 0.5,
      color = "black",
      fill =
        c(
          "#190D33", "#27123A", "#351742", "#421E4A", "#502653",
          "#5C2E5A", "#683863", "#73436A", "#7B4E70", "#815875",
          "#866079", "#89697D", "#8B7280", "#8C7A81", "#8E8385",
          "#908A87", "#919289", "#929A8A", "#94A38D", "#96AB8F",
          "#99B392", "#9CBD95", "#A2C79A", "#ACD3A0", "#B9DFA9",
          "#C8EAB3", "#D8F2BD", "#E6F9C7", "#F3FCD0", "#FEFED8"
        ),
      k = length(unique(data$y)),
      size = 6
    ) +
    ggthemes::theme_fivethirtyeight() +
    ggplot2::theme(panel.background = element_rect(fill = "white")) +
    ggplot2::theme(plot.background = element_rect(fill = "white")) +
    ggplot2::theme(panel.border = element_rect(color = "white"))
}
