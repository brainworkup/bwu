#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param data PARAM_DESCRIPTION
#' @param x PARAM_DESCRIPTION
#' @param y PARAM_DESCRIPTION
#' @param combine PARAM_DESCRIPTION, Default: FALSE
#' @param merge PARAM_DESCRIPTION, Default: FALSE
#' @param color PARAM_DESCRIPTION, Default: 'black'
#' @param fill PARAM_DESCRIPTION, Default: 'lightgray'
#' @param palette PARAM_DESCRIPTION, Default: NULL
#' @param title PARAM_DESCRIPTION, Default: NULL
#' @param xlab PARAM_DESCRIPTION, Default: NULL
#' @param ylab PARAM_DESCRIPTION, Default: NULL
#' @param facet.by PARAM_DESCRIPTION, Default: NULL
#' @param panel.labs PARAM_DESCRIPTION, Default: NULL
#' @param short.panel.labs PARAM_DESCRIPTION, Default: TRUE
#' @param size PARAM_DESCRIPTION, Default: NULL
#' @param binwidth PARAM_DESCRIPTION, Default: NULL
#' @param select PARAM_DESCRIPTION, Default: NULL
#' @param remove PARAM_DESCRIPTION, Default: NULL
#' @param order PARAM_DESCRIPTION, Default: NULL
#' @param add PARAM_DESCRIPTION, Default: 'mean_se'
#' @param add.params PARAM_DESCRIPTION, Default: list()
#' @param error.plot PARAM_DESCRIPTION, Default: 'pointrange'
#' @param label PARAM_DESCRIPTION, Default: NULL
#' @param font.label PARAM_DESCRIPTION, Default: list(size = 11, color = "black")
#' @param label.select PARAM_DESCRIPTION, Default: NULL
#' @param repel PARAM_DESCRIPTION, Default: FALSE
#' @param label.rectangle PARAM_DESCRIPTION, Default: FALSE
#' @param ggtheme PARAM_DESCRIPTION, Default: theme_pubr()
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname ggdotplot
#' @export 
ggdotplot <- function(data, x, y, combine = FALSE, merge = FALSE,
                      color = "black", fill = "lightgray", palette = NULL,
                      title = NULL, xlab = NULL, ylab = NULL,
                      facet.by = NULL, panel.labs = NULL, short.panel.labs = TRUE,
                      size = NULL, binwidth = NULL,
                      select = NULL, remove = NULL, order = NULL,
                      add = "mean_se",
                      add.params = list(),
                      error.plot = "pointrange",
                      label = NULL, font.label = list(size = 11, color = "black"),
                      label.select = NULL, repel = FALSE, label.rectangle = FALSE,
                      ggtheme = theme_pubr(),
                      ...)
{
  # Default options
  # :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  .opts <- list(
    combine = combine, merge = merge,
    color = color, fill = fill, palette = palette,
    title = title, xlab = xlab, ylab = ylab,
    facet.by = facet.by, panel.labs = panel.labs, short.panel.labs = short.panel.labs,
    size = size, binwidth = binwidth,
    select = select, remove = remove, order = order,
    add = add, add.params = add.params, error.plot = error.plot,
    label = label, font.label = font.label, label.select = label.select,
    repel = repel, label.rectangle = label.rectangle, ggtheme = ggtheme, ...)
  if (!missing(data)) .opts$data <- data
  if (!missing(x)) .opts$x <- x
  if (!missing(y)) .opts$y <- y

  # User options
  # :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  .user.opts <- as.list(match.call(expand.dots = TRUE))
  .user.opts[[1]] <- NULL # Remove the function name
  # keep only user arguments
  for (opt.name in names(.opts)) {
    if (is.null(.user.opts[[opt.name]]))
      .opts[[opt.name]] <- NULL
  }

  .opts$fun <- ggdotplot_core
  if (missing(ggtheme) & (!is.null(facet.by) | combine))
    .opts$ggtheme <- theme_pubr(border = TRUE)
  p <- do.call(.plotter, .opts)

  if (.is_list(p) & length(p) == 1) p <- p[[1]]
  return(p)
}


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param data PARAM_DESCRIPTION
#' @param x PARAM_DESCRIPTION
#' @param y PARAM_DESCRIPTION
#' @param color PARAM_DESCRIPTION, Default: 'black'
#' @param fill PARAM_DESCRIPTION, Default: 'lightgray'
#' @param palette PARAM_DESCRIPTION, Default: NULL
#' @param title PARAM_DESCRIPTION, Default: NULL
#' @param xlab PARAM_DESCRIPTION, Default: NULL
#' @param ylab PARAM_DESCRIPTION, Default: NULL
#' @param size PARAM_DESCRIPTION, Default: NULL
#' @param dotsize PARAM_DESCRIPTION, Default: size
#' @param binwidth PARAM_DESCRIPTION, Default: NULL
#' @param add PARAM_DESCRIPTION, Default: 'mean_se'
#' @param add.params PARAM_DESCRIPTION, Default: list()
#' @param error.plot PARAM_DESCRIPTION, Default: 'pointrange'
#' @param position PARAM_DESCRIPTION, Default: position_dodge(0.8)
#' @param ggtheme PARAM_DESCRIPTION, Default: theme_pubr()
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname ggdotplot_core
#' @export 
ggdotplot_core <- function(data, x, y,
                           color = "black", fill = "lightgray", palette = NULL,
                           title = NULL, xlab = NULL, ylab = NULL,
                           size = NULL, dotsize = size,
                           binwidth = NULL,
                           add = "mean_se",
                           add.params = list(),
                           error.plot = "pointrange",
                           position = position_dodge(0.8),
                           ggtheme = theme_pubr(),
                           ...)
{
  if (!is.factor(data[[x]])) data[[x]] <- as.factor(data[[x]])
  . <- NULL

  p <- ggplot(data, create_aes(list(x = x, y = y)))
  if ("none" %in% add) add <- "none"

  if (is.null(add.params$fill)) add.params$fill <- "white"
  add.params <- .check_add.params(add, add.params, error.plot, data, color, fill, ...)
  # plot boxplot | violin | crossbar before jitter
  if (any(c("boxplot", "violin") %in% add)) {
    p <- add.params %>%
      .add_item(p = p, add = intersect(add, c("boxplot", "violin"))) %>%
      do.call(ggadd, .)
  }
  if (error.plot == "crossbar") {
    p <- add.params %>%
      .add_item(p = p, error.plot = error.plot,
                add = setdiff(add, c("boxplot", "violin", "jitter"))) %>%
      do.call(ggadd, .)
  }
  # Plot jitter
  p <- p +
    geom_exec(geom_dotplot, data = data,
              binaxis = "y", stackdir = "center",
              color = color, fill = fill,
              position = position, stackratio = 1,
              dotsize = dotsize, binwidth = binwidth, ...)

  # Add errors
  if (error.plot == "crossbar") {}
  else p <- add.params %>%
    .add_item(p = p, error.plot = error.plot,
              add = setdiff(add, c("boxplot", "violin", "jitter"))) %>%
    do.call(ggadd, .)

  p <- ggpar(p, palette = palette, ggtheme = ggtheme,
             title = title, xlab = xlab, ylab = ylab, ...)

  p
}
