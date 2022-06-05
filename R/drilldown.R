#' Drilldown on neuropsych domains.
#'
#' This function uses the R Highcharter package and drilldown function to "drill down" on neuropsychological domains and test scores.
#'
#' \code{drilldown} Creates a highcharter drilldown interactive plot.
#'
#' @param data Dataset to use.
#' @param patient Patient initials, 4 letters.
#' @param ... Numeric, complex, or logical vectors.
#'
#' @return A drilldown plot
#'
#' @export
drilldown <- function(data, patient, ...) {

  # Create 4 levels of dataframes for drilldown -----------------------
  ## Level 1 -------------------------------------------------------
  ## Domain scores
  # 1. create mean z-scores for domain
  ncog1 <-
    data %>%
    dplyr::group_by(domain) %>%
    dplyr::summarize(
      zMean = mean(z),
      zPct = mean(percentile)
    ) %>%
    dplyr::mutate(range = NA)
  ncog1$zMean <- round(ncog1$zMean, 2L)
  ncog1$zPct <- round(ncog1$zPct, 0L)
  ncog1 <-
    ncog1 %>%
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
  ncog1 <- dplyr::arrange(ncog1, desc(zMean))

  # 3. create tibble with new column with domain name lowercase
  ncog_level1_status <- tibble::tibble(
    name = ncog1$domain,
    y = ncog1$zMean,
    y2 = ncog1$zPct,
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
        ncog2 %>%
        dplyr::group_by(subdomain) %>%
        dplyr::summarize(
          zMean = mean(z),
          zPct = mean(percentile)
        ) %>%
        dplyr::mutate(range = NA)

      # round z-score to 1 decimal
      ncog2$zMean <- round(ncog2$zMean, 2L)
      ncog2$zPct <- round(ncog2$zPct, 0L)
      ncog2 <-
        ncog2 %>%
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
      ncog2 <- dplyr::arrange(ncog2, desc(zMean))

      # 3. create tibble with new column with domain name lowercase
      ncog_level2_status <- tibble::tibble(
        name = ncog2$subdomain,
        y = ncog2$zMean,
        y2 = ncog2$zPct,
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

        ncog3 <- ncog3 %>%
          dplyr::group_by(narrow) %>%
          dplyr::summarize(zMean = mean(z), zPct = mean(percentile)) %>%
          dplyr::mutate(range = NA)

        # round z-score to 1 decimal
        ncog3$zMean <- round(ncog3$zMean, 2L)
        ncog3$zPct <- round(ncog3$zPct, 0L)
        ncog3 <-
          ncog3 %>%
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

        ncog3 <- dplyr::arrange(ncog3, desc(zMean))

        ncog_level3_status <- tibble::tibble(
          name = ncog3$narrow,
          y = ncog3$zMean,
          y2 = ncog3$zPct,
          range = ncog3$range,
          drilldown = tolower(paste(x_level, y_level, name, sep = "_"))
        )

        list(
          id = tolower(paste(x_level, y_level, sep = "_")),
          type = "column",
          data = list_parse(ncog_level3_status)
        )
      })
    }) %>% unlist(recursive = FALSE)

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
            ncog4 %>%
            dplyr::group_by(scale) %>%
            dplyr::summarize(
              zMean = mean(z),
              zPct = mean(percentile)
            ) %>%
            dplyr::mutate(range = NA)

          # round z-score to 1 decimal
          ncog4$zMean <- round(ncog4$zMean, 2L)
          ncog4$zPct <- round(ncog4$zPct, 0L)
          ncog4 <-
            ncog4 %>%
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

          ncog4 <- dplyr::arrange(ncog4, desc(zMean))

          ncog_level4_status <- tibble::tibble(
            name = ncog4$scale,
            y = ncog4$zMean,
            y2 = ncog4$zPct,
            range = ncog4$range
          )

          list(
            id = tolower(paste(x_level, y_level, z_level, sep = "_")),
            type = "column",
            data = list_parse(ncog_level4_status)
          )
        })
      }) %>% unlist(recursive = FALSE)
    }) %>% unlist(recursive = FALSE)

  # Create charts ----------------------------------
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
    highcharter::hc_add_series(ncog_level1_status,
      type = "bar",
      name = "Neuropsychological Test Scores",
      highcharter::hcaes(x = name, y = y)
    ) %>%
    highcharter::hc_xAxis(
      type = "category",
      title = list(text = "Domain"),
      categories = .$name
    ) %>%
    highcharter::hc_yAxis(
      title = list(text = "z-score"),
      labels = list(format = "{value}")
    ) %>%
    highcharter::hc_tooltip(
      pointFormat = tt,
      useHTML = TRUE,
      valueDecimals = 1
    ) %>%
    highcharter::hc_plotOptions(series = list(
      colorByPoint = TRUE,
      allowPointSelect = TRUE,
      dataLabels = TRUE
    )) %>%
    highcharter::hc_drilldown(
      allowPointDrilldown = TRUE,
      series = c(ncog_level2_drill, ncog_level3_drill, ncog_level4_drill)
    ) %>%
    highcharter::hc_add_theme(highcharter::hc_theme_sandsignika())
  plot
}
