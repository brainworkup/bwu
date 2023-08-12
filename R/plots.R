#' @title Create a dotplot of cognitive and behavioral domains.
#' @description This function generates a dot plot with the given data, x and y. The point's aesthetics and plot theme can be customized.
#' @param data The data frame containing the data for the dotplot.
#' @param x The column name in the data frame for the x-axis variable, typically
#' the mean z-score for a cognitive domain.
#' @param y The column name in the data frame for the y-axis variable, typically
#' the cognitive domain to plot.
#' @param linewidth The width of the line, Default: 0.5
#' @param fill The fill color for the points, Default: x-axis variable
#' @param shape The shape of the points, Default: 21
#' @param point_size The size of the points, Default: 6
#' @param line_color The color of the lines, Default: 'black'
#' @param colors A vector of colors for fill gradient, Default: NULL (uses pre-defined color palette)
#' @param theme The ggplot theme to be used, Default: 'fivethirtyeight'. Other options include 'minimal' and 'classic'
#' @return An object of class 'ggplot' representing the dotplot.
#' @details This function generates a dot plot with the given data, x and y. The points' aesthetics and plot theme can be customized.
#' @rdname dotplot
#' @export
#' @importFrom ggplot2 ggplot geom_segment aes geom_point scale_fill_gradientn theme element_rect
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



#' Drilldown on neuropsych domains.
#'
#' This function uses the R Highcharter package and drilldown function to "drilldown" on neuropsychological domains and test scores.
#'
#' \code{drilldown} Creates a highcharter drilldown interactive plot.
#' @importFrom dplyr group_by summarize mutate case_when arrange
#' @importFrom tibble tibble
#' @importFrom highcharter tooltip_table highchart hc_title hc_add_series hcaes hc_xAxis hc_yAxis hc_tooltip hc_plotOptions hc_drilldown hc_add_theme hc_theme_sandsignika
#' @param data Dataset to use.
#' @param mean_z Mean z-score.
#' @param mean_pct Mean percentile.
#' @return A drilldown plot
#' @rdname drilldown
#' @export
drilldown <- function(data, mean_z = NULL, mean_pct = NULL) {
  # Create 4 levels of data.frames for drilldown -----------------------
  ## Level 1 -------------------------------------------------------
  ## Domain scores
  # 1. create mean z-scores for domain
  ncog1 <-
    data |>
    dplyr::group_by(domain) |>
    dplyr::summarize(
      mean_z = mean(z),
      mean_pct = mean(percentile)
    ) |>
    dplyr::mutate(range = "")

  ncog1$mean_z <- round(ncog1$mean_z, 2L)
  ncog1$mean_pct <- round(ncog1$mean_pct, 0L)

  ncog1 <-
    ncog1 |>
    dplyr::mutate(
      range = dplyr::case_when(
        mean_pct >= 98 ~ "Exceptionally High",
        mean_pct %in% 91:97 ~ "Above Average",
        mean_pct %in% 75:90 ~ "High Average",
        mean_pct %in% 25:74 ~ "Average",
        mean_pct %in% 9:24 ~ "Low Average",
        mean_pct %in% 2:8 ~ "Below Average",
        mean_pct < 2 ~ "Exceptionally Low",
        TRUE ~ as.character(range)
      )
    )

  # 2. sort hi to lo
  ncog1 <- dplyr::arrange(ncog1, desc(mean_pct))

  # 3. create tibble with new column with domain name lowercase
  ncog_level1_status <- tibble::tibble(
    name = ncog1$domain,
    y = ncog1$mean_z,
    y2 = ncog1$mean_pct,
    range = ncog1$range,
    drilldown = tolower(name)
  )

  ## Level 2 -------------------------------------------------------
  ## Subdomain scores
  ## function to create second level of drilldown (subdomain scores)
  ncog_level2_drill <-
    lapply(unique(neurocog$domain), function(x_level) {
      ncog2 <- subset(neurocog, neurocog$domain %in% x_level)

      # same as above
      ncog2 <-
        ncog2 |>
        dplyr::group_by(subdomain) |>
        dplyr::summarize(
          mean_z = mean(z),
          mean_pct = mean(percentile)
        ) |>
        dplyr::mutate(range = NA)

      # round z-score to 1 decimal
      ncog2$mean_z <- round(ncog2$mean_z, 2L)
      ncog2$mean_pct <- round(ncog2$mean_pct, 0L)
      ncog2 <-
        ncog2 |>
        dplyr::mutate(
          range = dplyr::case_when(
            mean_pct >= 98 ~ "Exceptionally High",
            mean_pct %in% 91:97 ~ "Above Average",
            mean_pct %in% 75:90 ~ "High Average",
            mean_pct %in% 25:74 ~ "Average",
            mean_pct %in% 9:24 ~ "Low Average",
            mean_pct %in% 2:8 ~ "Below Average",
            mean_pct < 2 ~ "Exceptionally Low",
            TRUE ~ as.character(range)
          )
        )

      # 2. sort hi to lo
      ncog2 <- dplyr::arrange(ncog2, desc(mean_pct))

      # 3. create tibble with new column with domain name lowercase
      ncog_level2_status <- tibble::tibble(
        name = ncog2$subdomain,
        y = ncog2$mean_z,
        y2 = ncog2$mean_pct,
        range = ncog2$range,
        drilldown = tolower(paste(x_level, name, sep = "_"))
      )

      list(
        id = tolower(x_level),
        type = "column",
        data = list_parse(ncog_level2_status)
      )
    })

  ## Level 3 -------------------------------------------------------
  ## Narrow subdomains
  ## reuse function
  ncog_level3_drill <-
    lapply(unique(neurocog$domain), function(x_level) {
      ncog2 <- subset(neurocog, neurocog$domain %in% x_level)

      # reuse function but with y_level
      lapply(unique(ncog2$subdomain), function(y_level) {
        # 1. create mean z-scores for subdomain
        # ncog3 becomes pronoun for domain
        ncog3 <- subset(ncog2, ncog2$subdomain %in% y_level)

        ncog3 <- ncog3 |>
          dplyr::group_by(narrow) |>
          dplyr::summarize(mean_z = mean(z), mean_pct = mean(percentile)) |>
          dplyr::mutate(range = NA)

        # round z-score to 1 decimal
        ncog3$mean_z <- round(ncog3$mean_z, 2L)
        ncog3$mean_pct <- round(ncog3$mean_pct, 0L)
        ncog3 <-
          ncog3 |>
          dplyr::mutate(
            range = dplyr::case_when(
              mean_pct >= 98 ~ "Exceptionally High",
              mean_pct %in% 91:97 ~ "Above Average",
              mean_pct %in% 75:90 ~ "High Average",
              mean_pct %in% 25:74 ~ "Average",
              mean_pct %in% 9:24 ~ "Low Average",
              mean_pct %in% 2:8 ~ "Below Average",
              mean_pct < 2 ~ "Exceptionally Low",
              TRUE ~ as.character(range)
            )
          )

        ncog3 <- dplyr::arrange(ncog3, desc(mean_pct))

        ncog_level3_status <- tibble::tibble(
          name = ncog3$narrow,
          y = ncog3$mean_z,
          y2 = ncog3$mean_pct,
          range = ncog3$range,
          drilldown = tolower(paste(x_level, y_level, name, sep = "_"))
        )

        list(
          id = tolower(paste(x_level, y_level, sep = "_")),
          type = "column",
          data = list_parse(ncog_level3_status)
        )
      })
    }) |> unlist(recursive = FALSE)

  ## Level 4 -------------------------------------------------------
  ## Scale scores
  ## reuse both functions
  ncog_level4_drill <-
    lapply(unique(neurocog$domain), function(x_level) {
      ncog2 <- subset(neurocog, neurocog$domain %in% x_level)

      lapply(unique(ncog2$subdomain), function(y_level) {
        ncog3 <- subset(ncog2, ncog2$subdomain %in% y_level)

        lapply(unique(ncog3$narrow), function(z_level) {
          ncog4 <- subset(ncog3, ncog3$narrow %in% z_level)

          ncog4 <-
            ncog4 |>
            dplyr::group_by(scale) |>
            dplyr::summarize(
              mean_z = mean(z),
              mean_pct = mean(percentile)
            ) |>
            dplyr::mutate(range = NA)

          # round z-score to 1 decimal
          ncog4$mean_z <- round(ncog4$mean_z, 2L)
          ncog4$mean_pct <- round(ncog4$mean_pct, 0L)
          ncog4 <-
            ncog4 |>
            dplyr::mutate(
              range = dplyr::case_when(
                mean_pct >= 98 ~ "Exceptionally High",
                mean_pct %in% 91:97 ~ "Above Average",
                mean_pct %in% 75:90 ~ "High Average",
                mean_pct %in% 25:74 ~ "Average",
                mean_pct %in% 9:24 ~ "Low Average",
                mean_pct %in% 2:8 ~ "Below Average",
                mean_pct < 2 ~ "Exceptionally Low",
                TRUE ~ as.character(range)
              )
            )

          ncog4 <- dplyr::arrange(ncog4, desc(mean_pct))

          ncog_level4_status <- tibble::tibble(
            name = ncog4$scale,
            y = ncog4$mean_z,
            y2 = ncog4$mean_pct,
            range = ncog4$range
          )

          list(
            id = tolower(paste(x_level, y_level, z_level, sep = "_")),
            type = "column",
            data = list_parse(ncog_level4_status)
          )
        })
      }) |> unlist(recursive = FALSE)
    }) |> unlist(recursive = FALSE)

  # Create charts ----------------------------------
  # Tooltip
  x <- c("Name", "Score", "Percentile", "Range")
  y <- c("{point.name}", "{point.y}", "{point.y2}", "{point.range}")
  tt <- highcharter::tooltip_table(x, y)

  ## Create drilldown bar plot zscores
  plot <-
    highcharter::highchart() |>
    highcharter::hc_title(
      text = patient,
      style = list(fontSize = "15px")
    ) |>
    highcharter::hc_add_series(ncog_level1_status,
      type = "bar",
      name = "Neuropsychological Test Scores",
      highcharter::hcaes(x = name, y = y)
    ) |>
    highcharter::hc_xAxis(
      type = "category",
      title = list(text = "Scale"),
      categories = .$name
    ) |>
    highcharter::hc_yAxis(
      title = list(text = "z-score"),
      labels = list(format = "{value}")
    ) |>
    highcharter::hc_tooltip(
      pointFormat = tt,
      useHTML = TRUE,
      valueDecimals = 1
    ) |>
    highcharter::hc_plotOptions(series = list(
      colorByPoint = TRUE,
      allowPointSelect = TRUE,
      dataLabels = TRUE
    )) |>
    highcharter::hc_drilldown(
      allowPointDrilldown = TRUE,
      series = c(ncog_level2_drill, ncog_level3_drill, ncog_level4_drill)
    ) |>
    highcharter::hc_add_theme(highcharter::hc_theme_sandsignika())

  return(plot)
}
