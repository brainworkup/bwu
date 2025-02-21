#' Create Dotplot for Neurocognitive Domains
#' This function generates a dotplot for neurocognitive and neurobehavioral
#' domains.
#' @param data The dataset or df containing the data for the dotplot.
#' @param x The column name in the data frame for the x-axis variable, typically
#'   the mean z-score for a cognitive domain.
#' @param y The column name in the data frame for the y-axis variable, typically
#'   the cognitive domain to plot.
#' @param linewidth The width of the line, Default: 0.5
#' @param fill The fill color for the points, Default: x-axis variable
#' @param shape The shape of the points, Default: 21
#' @param point_size The size of the points, Default: 6
#' @param line_color The color of the lines, Default: 'black'
#' @param colors A vector of colors for fill gradient, Default: NULL (uses
#'   pre-defined color palette)
#' @param theme The ggplot theme to be used, Default: 'fivethirtyeight'. Other
#'   options include 'minimal' and 'classic'
#' @param return_plot Whether to return the plot object, Default: TRUE
#' @param filename The filename to save the plot to, Default: NULL
#' @param ... Additional arguments to be passed to the function.
#' @return An object of class 'ggplot' representing the dotplot.
#' @importFrom ggplot2 ggplot geom_segment aes geom_point scale_fill_gradientn
#'   theme element_rect ggsave
#' @importFrom stats reorder
#' @importFrom ggthemes theme_fivethirtyeight
#' @importFrom ggtext element_markdown
#' @rdname dotplot
#' @export
dotplot <- function(data,
                    x,
                    y,
                    linewidth = 0.5,
                    fill = x,
                    shape = 21,
                    point_size = 6,
                    line_color = "black",
                    colors = NULL,
                    theme = "fivethirtyeight",
                    return_plot = NULL,
                    filename = NULL,
                    ...) {
  # Define the color palette
  color_palette <- if (is.null(colors)) {
    c(
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

  # Apply theme elements
  plot_object <- plot_object +
    ggplot2::theme(
      panel.background = ggplot2::element_rect(fill = "white"),
      plot.background = ggplot2::element_rect(fill = "white"),
      panel.border = ggplot2::element_rect(color = "white")
    )

  # Save the plot to a file if filename is provided
  if (!is.null(filename)) {
    # Determine file extension to save accordingly
    ext <- tools::file_ext(filename)

    if (ext == "pdf") {
      ggplot2::ggsave(
        filename = filename,
        plot = plot_object,
        device = "pdf"
      )
    } else if (ext == "png") {
      ggplot2::ggsave(
        filename = filename,
        plot = plot_object,
        device = "png"
      )
    } else if (ext == "svg") {
      ggplot2::ggsave(
        filename = filename,
        plot = plot_object,
        device = "svg"
      )
    } else {
      warning("File extension not recognized.
              Supported extensions are 'pdf', 'png', and 'svg'.")
    }
  }

  # Return the plot if return_plot is TRUE
  if (return_plot) {
    return(plot_object)
  }
}

#' Drilldown on Neuropsych Domains
#' This function uses the R Highcharter package and drilldown function to
#' "drilldown" on neuropsychological domains and test scores. \code{drilldown}
#' Creates a highcharter drilldown interactive plot.
#' @param data Dataset to use.
#' @param patient Name of patient.
#' @param neuro_domain Name of neuropsych domain to add to HC series.
#' @param theme The highcharter theme to use.
#' @importFrom dplyr group_by summarize mutate case_when arrange ungroup
#' @importFrom highcharter tooltip_table highchart hc_title hc_add_series hcaes
#'   hc_xAxis hc_yAxis hc_tooltip hc_plotOptions hc_drilldown hc_add_theme
#'   hc_theme_merge hc_theme_sandsignika hc_theme_darkunica hc_theme_monokai
#'   list_parse hc_colorAxis hc_chart
#' @importFrom tibble tibble
#' @return A drilldown plot
#' @rdname drilldown
#' @export
drilldown <- function(data, patient, neuro_domain = c(
                        "Neuropsychological Test Scores",
                        "Behavioral Rating Scales",
                        "Effort/Validity Test Scores"
                      ), theme) {
  # Create 4 levels of dataframes for drilldown ----------------------------------
  ## Level 1 -------------------------------------------------------
  ## Domain scores
  # 1. create mean z-scores for domain
  df1 <- data %>%
    dplyr::group_by(domain) %>%
    dplyr::summarize(
      zMean = mean(z, na.rm = TRUE),
      zPct = mean(percentile, na.rm = TRUE)
    ) %>%
    dplyr::mutate(range = NA) |>
    ungroup() # NOTE this is new


  df1$zMean <- round(df1$zMean, 2L)
  df1$zPct <- round(df1$zPct, 0L)
  df1 <-
    df1 %>%
    dplyr::mutate(
      range = dplyr::case_when(
        zPct >= 98 ~ "Exceptionally High",
        zPct %in% 91:97 ~ "Above Average",
        zPct %in% 75:90 ~ "High Average",
        zPct %in% 25:74 ~ "Average",
        zPct %in% 9:24 ~ "Low Average",
        zPct %in% 2:8 ~ "Below Average",
        zPct < 2 ~ "Exceptionally Low",
        TRUE ~ as.character(range)
      )
    )

  # 2. sort hi to lo
  df1 <- dplyr::arrange(df1, desc(zPct)) # NOTE this is new

  # 3. create tibble with new column with domain name lowercase
  df_level1_status <- tibble(
    name = df1$domain,
    y = df1$zMean,
    y2 = df1$zPct,
    range = df1$range,
    drilldown = tolower(name)
  )

  ## Level 2 -------------------------------------------------------
  ## Subdomain scores
  ## function to create second level of drilldown (subdomain scores)
  df_level2_drill <-
    lapply(unique(data$domain), function(x_level) {
      df2 <- subset(data, data$domain %in% x_level)

      # same as above
      df2 <-
        df2 %>%
        dplyr::group_by(subdomain) %>%
        dplyr::summarize(
          zMean = mean(z, na.rm = TRUE),
          zPct = mean(percentile, na.rm = TRUE)
        ) %>%
        dplyr::mutate(range = NA) |>
        dplyr::ungroup() # NOTE this is new

      # round z-score to 1 decimal
      df2$zMean <- round(df2$zMean, 2L)
      df2$zPct <- round(df2$zPct, 0L)
      df2 <-
        df2 %>%
        dplyr::mutate(
          range = dplyr::case_when(
            zPct >= 98 ~ "Exceptionally High",
            zPct %in% 91:97 ~ "Above Average",
            zPct %in% 75:90 ~ "High Average",
            zPct %in% 25:74 ~ "Average",
            zPct %in% 9:24 ~ "Low Average",
            zPct %in% 2:8 ~ "Below Average",
            zPct < 2 ~ "Exceptionally Low",
            TRUE ~ as.character(range)
          )
        )

      # 2. sort hi to lo
      df2 <- dplyr::arrange(df2, desc(zPct)) # NOTE this is new

      # 3. create tibble with new column with domain name lowercase
      df_level2_status <- tibble(
        name = df2$subdomain,
        y = df2$zMean,
        y2 = df2$zPct,
        range = df2$range,
        drilldown = tolower(paste(x_level, name, sep = "_"))
      )

      list(
        id = tolower(x_level),
        type = "column",
        data = list_parse(df_level2_status)
      )
    })

  ## Level 3 -------------------------------------------------------
  ## Narrow subdomains
  ## reuse function
  df_level3_drill <-
    lapply(unique(data$domain), function(x_level) {
      df2 <- subset(data, data$domain %in% x_level)

      # reuse function but with y_level
      lapply(unique(df2$subdomain), function(y_level) {
        # 1. create mean z-scores for subdomain
        # df3 becomes pronoun for domain
        df3 <- subset(df2, df2$subdomain %in% y_level)

        df3 <- df3 %>%
          dplyr::group_by(narrow) %>%
          dplyr::summarize(
            zMean = mean(z, na.rm = TRUE),
            zPct = mean(percentile, na.rm = TRUE)
          ) %>%
          dplyr::mutate(range = NA) |>
          ungroup() # NOTE this is new

        # round z-score to 1 decimal
        df3$zMean <- round(df3$zMean, 2L)
        df3$zPct <- round(df3$zPct, 0L)
        df3 <-
          df3 %>%
          dplyr::mutate(
            range = dplyr::case_when(
              zPct >= 98 ~ "Exceptionally High",
              zPct %in% 91:97 ~ "Above Average",
              zPct %in% 75:90 ~ "High Average",
              zPct %in% 25:74 ~ "Average",
              zPct %in% 9:24 ~ "Low Average",
              zPct %in% 2:8 ~ "Below Average",
              zPct < 2 ~ "Exceptionally Low",
              TRUE ~ as.character(range)
            )
          )

        df3 <- dplyr::arrange(df3, desc(zPct))

        df_level3_status <- tibble(
          name = df3$narrow,
          y = df3$zMean,
          y2 = df3$zPct,
          range = df3$range,
          drilldown = tolower(paste(x_level, y_level, name, sep = "_"))
        )

        list(
          id = tolower(paste(x_level, y_level, sep = "_")),
          type = "column",
          data = list_parse(df_level3_status)
        )
      })
    }) %>% unlist(recursive = FALSE)

  ## Level 4 -------------------------------------------------------
  ## Scale scores
  ## reuse both functions
  df_level4_drill <-
    lapply(unique(data$domain), function(x_level) {
      df2 <- subset(data, data$domain %in% x_level)

      lapply(unique(df2$subdomain), function(y_level) {
        df3 <- subset(df2, df2$subdomain %in% y_level)

        lapply(unique(df3$narrow), function(z_level) {
          df4 <- subset(df3, df3$narrow %in% z_level)

          df4 <-
            df4 %>%
            dplyr::group_by(scale) %>%
            dplyr::summarize(
              zMean = mean(z, na.rm = TRUE),
              zPct = mean(percentile, na.rm = TRUE)
            ) %>%
            dplyr::mutate(range = NA) |>
            dplyr::ungroup() # NOTE this is new

          # round z-score to 1 decimal
          df4$zMean <- round(df4$zMean, 2L)
          df4$zPct <- round(df4$zPct, 0L)
          df4 <-
            df4 %>%
            dplyr::mutate(
              range = dplyr::case_when(
                zPct >= 98 ~ "Exceptionally High",
                zPct %in% 91:97 ~ "Above Average",
                zPct %in% 75:90 ~ "High Average",
                zPct %in% 25:74 ~ "Average",
                zPct %in% 9:24 ~ "Low Average",
                zPct %in% 2:8 ~ "Below Average",
                zPct < 2 ~ "Exceptionally Low",
                TRUE ~ as.character(range)
              )
            )

          df4 <- dplyr::arrange(df4, desc(zMean))

          df_level4_status <- tibble(
            name = df4$scale,
            y = df4$zMean,
            y2 = df4$zPct,
            range = df4$range
          )

          list(
            id = tolower(paste(x_level, y_level, z_level, sep = "_")),
            type = "column",
            data = list_parse(df_level4_status)
          )
        })
      }) %>% unlist(recursive = FALSE)
    }) %>% unlist(recursive = FALSE)

  # Create charts ----------------------------------
  # Theme
  theme <-
    highcharter::hc_theme_merge(
      highcharter::hc_theme_monokai(),
      highcharter::hc_theme_darkunica()
    )

  # Tooltip
  x <- c("Name", "Score", "Percentile", "Range")
  y <- c("{point.name}", "{point.y}", "{point.y2}", "{point.range}")
  tt <- highcharter::tooltip_table(x, y)

  ## Create drilldown bar plot zscores
  plot <-
    highcharter::highchart() %>%
    highcharter::hc_title(
      text = patient,
      style = list(fontSize = "15px")
    ) %>%
    highcharter::hc_add_series(df_level1_status,
      type = "bar",
      name = neuro_domain,
      highcharter::hcaes(x = name, y = y)
    ) %>%
    highcharter::hc_xAxis(
      type = "category",
      title = list(text = "Domain"),
      categories = .$name
    ) %>%
    highcharter::hc_yAxis(
      title = list(text = "z-Score (Mean = 0, SD = 1)"),
      labels = list(format = "{value}")
    ) %>%
    highcharter::hc_tooltip(
      pointFormat = tt,
      useHTML = TRUE,
      valueDecimals = 1
    ) %>%
    highcharter::hc_plotOptions(
      series = list(
        colorByPoint = TRUE,
        allowPointSelect = TRUE,
        dataLabels = TRUE
      )
    ) %>%
    highcharter::hc_drilldown(
      allowPointDrilldown = TRUE,
      series = c(
        df_level2_drill,
        df_level3_drill,
        df_level4_drill
      )
    ) %>%
    highcharter::hc_colorAxis(
      minColor = "red",
      maxColor = "blue"
    ) %>%
    highcharter::hc_add_theme(theme) %>%
    highcharter::hc_chart(
      style = list(fontFamily = "Cabin"),
      backgroundColor = list("gray")
    )

  return(plot)
}


#' Drilldown on Neuropsych PASS
#' This function uses the R Highcharter package and drilldown function to
#' "drilldown" on neuropsychological domains and test scores. \code{drilldown}
#' Creates a highcharter drilldown interactive plot.
#' @param data Dataset to use.
#' @param patient Name of patient.
#' @param neuro_domain Name of neuropsych domain to add to HC series.
#' @param theme The highcharter theme to use.
#' @importFrom dplyr group_by summarize mutate case_when arrange ungroup
#' @importFrom highcharter tooltip_table highchart hc_title hc_add_series hcaes
#'   hc_xAxis hc_yAxis hc_tooltip hc_plotOptions hc_drilldown hc_add_theme
#'   hc_theme_merge hc_theme_sandsignika hc_theme_darkunica hc_theme_monokai
#'   list_parse hc_colorAxis hc_chart
#' @importFrom tibble tibble
#' @return A drilldown plot
#' @rdname pass
#' @export
pass <- function(data, patient, neuro_domain = c(
                   "Neuropsychological Test Scores",
                   "Behavioral Rating Scales",
                   "Effort/Validity Test Scores"
                 ), theme) {
  # Create 4 levels of dataframes for drilldown ----------------------------------
  ## Level 1 -------------------------------------------------------
  ## Domain scores
  # 1. create mean z-scores for domain
  df1 <- data |>
    dplyr::group_by(pass) |>
    dplyr::summarize(
      zMean = mean(z, na.rm = TRUE),
      zPct = mean(percentile, na.rm = TRUE)
    ) |>
    dplyr::mutate(range = NA) |>
    ungroup() # NOTE this is new


  df1$zMean <- round(df1$zMean, 2L)
  df1$zPct <- round(df1$zPct, 0L)
  df1 <-
    df1 |>
    dplyr::mutate(
      range = dplyr::case_when(
        zPct >= 98 ~ "Exceptionally High",
        zPct %in% 91:97 ~ "Above Average",
        zPct %in% 75:90 ~ "High Average",
        zPct %in% 25:74 ~ "Average",
        zPct %in% 9:24 ~ "Low Average",
        zPct %in% 2:8 ~ "Below Average",
        zPct < 2 ~ "Exceptionally Low",
        TRUE ~ as.character(range)
      )
    )

  # 2. sort hi to lo
  df1 <- dplyr::arrange(df1, desc(zPct)) # NOTE this is new

  # 3. create tibble with new column with domain name lowercase
  df_pass_status <- tibble(
    name = df1$pass,
    y = df1$zMean,
    y2 = df1$zPct,
    range = df1$range,
    drilldown = tolower(name)
  )



  ## Level 2 -------------------------------------------------------
  ## Scale scores
  df_scale_drill <-
    lapply(unique(data$pass), function(x_level) {
      df2 <- subset(data, data$pass %in% x_level)

      df2 <- df2 |>
        dplyr::group_by(scale) |>
        dplyr::summarize(
          zMean = mean(z, na.rm = TRUE),
          zPct = mean(percentile, na.rm = TRUE)
        ) |>
        dplyr::mutate(range = NA) |>
        dplyr::ungroup()

      # round z-score to 1 decimal
      df2$zMean <- round(df2$zMean, 2L)
      df2$zPct <- round(df2$zPct, 0L)
      df2 <- df2 |>
        dplyr::mutate(
          range = dplyr::case_when(
            zPct >= 98 ~ "Exceptionally High",
            zPct %in% 91:97 ~ "Above Average",
            zPct %in% 75:90 ~ "High Average",
            zPct %in% 25:74 ~ "Average",
            zPct %in% 9:24 ~ "Low Average",
            zPct %in% 2:8 ~ "Below Average",
            zPct < 2 ~ "Exceptionally Low",
            TRUE ~ as.character(range)
          )
        )

      df2 <- dplyr::arrange(df2, desc(zPct))

      df_scale_status <- tibble(
        name = df2$scale,
        y = df2$zMean,
        y2 = df2$zPct,
        range = df2$range
      )

      list(
        id = tolower(x_level),
        type = "column",
        data = list_parse(df_scale_status)
      )
    })

  # Create charts ----------------------------------
  # Theme
  theme <-
    highcharter::hc_theme_merge(
      highcharter::hc_theme_monokai(),
      highcharter::hc_theme_darkunica()
    )

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
    highcharter::hc_add_series(df_pass_status,
      type = "bar",
      name = neuro_domain,
      highcharter::hcaes(x = name, y = y)
    ) |>
    highcharter::hc_xAxis(
      type = "category",
      title = list(text = "Domain"),
      categories = df_pass_status$name
    ) |>
    highcharter::hc_yAxis(
      title = list(text = "z-Score (Mean = 0, SD = 1)"),
      labels = list(format = "{value}")
    ) |>
    highcharter::hc_tooltip(
      pointFormat = tt,
      useHTML = TRUE,
      valueDecimals = 1
    ) |>
    highcharter::hc_plotOptions(
      series = list(
        colorByPoint = TRUE,
        allowPointSelect = TRUE,
        dataLabels = TRUE
      )
    ) |>
    highcharter::hc_drilldown(
      allowPointDrilldown = TRUE,
      series = c(
        df_scale_drill
      )
    ) |>
    highcharter::hc_colorAxis(
      minColor = "red",
      maxColor = "blue"
    ) |>
    highcharter::hc_add_theme(theme) |>
    highcharter::hc_chart(
      style = list(fontFamily = "Cabin"),
      backgroundColor = list("gray")
    )

  return(plot)
}
