# Need to add pdf_01_extract_text() and pdf_02_filter_lines() to the package

#' @title Filter lines in a PDF file
#' @description Filter lines from text extracted from a PDF for given words.
#' @param extracted_text A \code{list} of strings, containing text extracted from the PDF file.
#' @param pdf_file Path to the PDF file.
#' @param page Optional \code{integer}: Page number in the PDF used for extraction, defaults to \code{NULL}.
#' @param scale The word which is searched in lines and then filtered.
#' @return A \code{vector} of strings, for all lines that contains the word in \code{scale}.
#' @rdname pdf_02_filter_lines
#' @export
pdf_02_filter_lines <- function(extracted_text, pdf_file, page = NULL, scale) {
  # Extract text
  scale_text <- extracted_text[[page]]

  # Convert the string into a vector of lines
  lines <- strsplit(scale_text, "\n")[[1]]

  # Filter lines that contain the word in scale
  scale_text_filtered <- lines[grepl(scale, lines)]

  return(scale_text_filtered)
}


#' @title Locate PDF Areas
#' @description This is a function to pluck and locate areas from file.
#' @importFrom tabulapdf locate_areas
#' @param file The File name of the input PDF.
#' @param pages A vector of character strings specifying which pages to analyse, Default: NULL
#' @param ... Additional arguments passed to locate_areas() in the tabulapdf package.
#' @return A list containing all areas found by area extraction algorithem.
#' @details Use this function with caution when handling sensitive PDFs as it involves rasterizing those documents. Also use this function if your PDF contains tables and you want to access those tables programmatically.
#' @seealso
#'  \code{\link[tabulapdf]{locate_areas}}
#' @rdname gpluck_locate_areas
#' @export
gpluck_locate_areas <- function(file, pages = NULL, ...) {
  tabulapdf::locate_areas(
    file = file,
    pages = pages,
    ...
  )
}


#' @title Extract Tables from a PDF
#' @description This function returns the tables in a PDF file as parsed by the tabulapdf package.
#' @importFrom tabulapdf extract_tables
#' @param file The path to the PDF file.
#' @param pages A single page number or vector of page numbers, Default: NULL
#' @param area An area on the page given as c(x0, y0, x1, y1). Default: NULL
#' @param guess Whether to attempt to detect tables when the coordinates are not given. Default: FALSE
#' @param method Method to use for parsing. Default: c("decide", "lattice", "stream")
#' @param output Output format (see \code{\link[tabulapdf]{extract_tables}} for more details). Default: c("matrix", "data.frame", "character", "asis", "csv", "tsv", "json")
#' @param ... Other arguments to \code{\link[tabulapdf]{extract_tables}}
#' @return A parsed table in either matrix, data frame, character, asis, csv, tsv or json format.
#' @details This is a wrapper around the \code{\link[tabulapdf]{extract_tables}} function that allows for easier access to the tables in a PDF document.
#' @seealso
#'  \code{\link[tabulapdf]{extract_tables}}
#' @rdname gpluck_extract_tables
#' @export
gpluck_extract_tables <-
  function(file,
           pages = NULL,
           area = NULL,
           guess = FALSE,
           method = c(
             "decide",
             "lattice",
             "stream"
           ),
           output = c(
             "matrix",
             "data.frame",
             "character",
             "asis",
             "csv",
             "tsv",
             "json"
           ),
           ...) {
    tabulapdf::extract_tables(
      file = file,
      pages = pages,
      area = area,
      guess = match.arg(guess),
      method = match.arg(method),
      output = match.arg(output)
    )
  }


#' @title Insert Variables and Data from Tables into DF.
#' @description This function takes a data frame containing text data from PDF tables, and makes additional columns of binary, range or score values for the specified domain, subdomains, test types, etc.
#' @importFrom dplyr mutate
#' @param data Data frame to convert to table and then csv.
#' @param test Name of test that information will be extracted from.
#' @param test_name Test name as provided in test field.
#' @param scale Name of subscale from neuropsych test or battery. Default: NULL
#' @param raw_score Raw score if available. Default: NULL
#' @param score Standardized Score for the given test. Default: NULL
#' @param range Range of performance e.g., Below Average, Average, Above
#' Average, etc the given test or subscale. Default: NULL
#' @param percentile Percentile the patient's performance falls at for the given test. Default: NULL
#' @param ci_95 Confidence interval level (95%) for the given test. Default: NULL
#' @param domain Domain of the test, e.g. Academic Skills. Default: c("General
#' Cognitive Ability", "Academic Skills", "Verbal/Language", "Visual
#' Perception/Construction", "Attention/Executive", "Memory", "Motor", "Social
#' Cognition", "Emotional/Behavioral/Personality", "Behavioral/Emotional/Social", "Personality Disorders", "Psychiatric Disorders", "Substance Use", "Psychosocial Problems", "ADHD", "Executive Function", "Adaptive Function", "Effort/Validity")
#' @param subdomain Cognitive subdomain of the scale. Default: NULL
#' @param narrow Narrow cognitive domain of the scale. Default: NULL
#' @param pass PASS Cognitive Model. Default: c("Planning", "Attention", "Sequential", "Simultaneous", "Knowledge",
#'    NA)
#' @param verbal Type of verbal ability tested, e.g. Verbal, Nonverbal. Default: c("Verbal", "Nonverbal", NA)
#' @param timed Indicates if the test is timed or not. Default: c("Timed", "Untimed", NA)
#' @param test_type Type of test, e.g. npsych_test, rating_scale,
#' validity_indicator, item. Default: c("npsych_test", "rating_scale",
#' "validity_indicator", "basc3", "item", NA)
#' @param score_type Type of score reported, e.g. raw_score, scaled_score, t_score, standard_score, z_score, percentile, base_rate, beta_coefficient. Default: c("raw_score", "scaled_score", "t_score", "standard_score", "z_score",
#'    "percentile", "base_rate", "beta_coefficient", NA)
#' @param absort Default order of scales to use for sorting. Default: NULL
#' @param description Description of the test or task. Default: NULL
#' @param result Concatenate the results to include details of test performance. Default: NULL
#' @param ... Other parameters.
#' @return A modified data frame with additional columns.
#' @details This function adds new columns to a data frame by extracting numerical values from PDF tables.
#' @rdname gpluck_make_columns
#' @export
gpluck_make_columns <- function(data,
                                test,
                                test_name,
                                scale = NULL,
                                raw_score = NULL,
                                score = NULL,
                                ci_95 = NULL,
                                percentile = NULL,
                                range = NULL,
                                domain = c(
                                  "General Cognitive Ability",
                                  "Intelligence/General Ability",
                                  "Academic Skills",
                                  "Verbal/Language",
                                  "Visual Perception/Construction",
                                  "Attention/Executive",
                                  "Memory",
                                  "Motor",
                                  "Social Cognition",
                                  "Emotional/Behavioral/Personality",
                                  "Behavioral/Emotional/Social",
                                  "Psychiatric Disorders",
                                  "Personality Disorders",
                                  "Substance Use",
                                  "Psychosocial Problems",
                                  "ADHD",
                                  "Executive Functioning",
                                  "Adaptive Functioning",
                                  "Effort/Validity"
                                ),
                                subdomain = NULL,
                                narrow = NULL,
                                pass = c(
                                  "Planning",
                                  "Attention",
                                  "Sequential",
                                  "Simultaneous",
                                  "Knowledge",
                                  NA
                                ),
                                verbal = c(
                                  "Verbal",
                                  "Nonverbal",
                                  NA
                                ),
                                timed = c(
                                  "Timed",
                                  "Untimed",
                                  NA
                                ),
                                test_type = c(
                                  "npsych_test",
                                  "rating_scale",
                                  "validity_indicator",
                                  "item",
                                  "basc3",
                                  NA
                                ),
                                score_type = c(
                                  "raw_score",
                                  "scaled_score",
                                  "t_score",
                                  "standard_score",
                                  "z_score",
                                  "percentile",
                                  "base_rate",
                                  "beta_coefficient",
                                  NA
                                ),
                                absort = NULL,
                                description = NULL,
                                result = NULL,
                                ...) {
  table <- data |>
    dplyr::mutate(
      test = test,
      test_name = test_name,
      scale = scale,
      raw_score = raw_score,
      score = score,
      ci_95 = ci_95,
      percentile = percentile,
      range = range,
      domain = domain,
      subdomain = subdomain,
      narrow = narrow,
      pass = pass,
      verbal = verbal,
      timed = timed,
      score_type = score_type,
      test_type = test_type,
      absort = paste0(tolower(test), "_", seq_len(nrow(data))),
      # row_names = gsub(" ", "", paste(tolower(test), tolower(scale), sep = "_")),
      description = description,
      result = result,
      ...
    )
  return(table)
}


#' @title Make Score Ranges
#' @description This function takes a text table of score ranges for each percentile, and returns an object that matches the input but with the ability to get score ranges for any given test type
#' @importFrom dplyr mutate case_when
#' @param table The table containing the lower bound and upper bound score columns
#' @param score Optional lower bound or upper bound score column name. If omitted, use `Score`
#' @param percentile Option percentiles column name. if omitted, use `Percentile`
#' @param range Score performance range. if omitted, use `Range`
#' @param test_type A vector of test types to consider. Default: c("npsych_test", "rating_scale", "validity_indicator", "basc3")
#' @param subdomain Which subdomain.
#' @param ... Other arguments passed on to `dplyr::filter`
#' @return An object that matches the input but with the ability to get score ranges for any given test type
#' @details This function takes a text table of score ranges for each percentile, and returns an object that matches the input but with the ability to get score ranges for any given test type
#' @rdname gpluck_make_score_ranges
#' @export
gpluck_make_score_ranges <-
  function(table,
           score,
           percentile,
           range,
           subdomain = NULL,
           test_type = c(
             "npsych_test",
             "rating_scale",
             "performance_validity",
             "symptom_validity",
             "basc3"
           ),
           ...) {
    if (test_type == "npsych_test") {
      table <-
        table |>
        dplyr::mutate(
          range = dplyr::case_when(
            percentile >= 98 ~ "Exceptionally High",
            percentile %in% 91:97 ~ "Above Average",
            percentile %in% 75:90 ~ "High Average",
            percentile %in% 25:74 ~ "Average",
            percentile %in% 9:24 ~ "Low Average",
            percentile %in% 2:8 ~ "Below Average",
            percentile < 2 ~ "Exceptionally Low",
            TRUE ~ as.character(range)
          )
        )
    } else if (test_type == "rating_scale") {
      table <-
        table |>
        dplyr::mutate(
          range = dplyr::case_when(
            percentile >= 98 ~ "Exceptionally High",
            percentile %in% 91:97 ~ "Above Average",
            percentile %in% 75:90 ~ "High Average",
            percentile %in% 25:74 ~ "Average",
            percentile %in% 9:24 ~ "Low Average",
            percentile %in% 2:8 ~ "Below Average",
            percentile < 2 ~ "Exceptionally Low",
            TRUE ~ as.character(range)
          )
        )
    } else if (test_type == "performance_validity") {
      table <-
        table |>
        dplyr::mutate(
          range = dplyr::case_when(
            percentile >= 25 ~ "WNL Score",
            percentile %in% 9:24 ~ "Low Average Score",
            percentile %in% 2:8 ~ "Below Average Score",
            percentile < 2 ~ "Exceptionally Low Score",
            TRUE ~ as.character(range)
          )
        )
    } else if (test_type == "symptom_validity") {
      table <-
        table |>
        dplyr::mutate(
          range = dplyr::case_when(
            percentile >= 98 ~ "Exceptionally High Score",
            percentile %in% 91:97 ~ "Above Average Score",
            percentile %in% 75:90 ~ "High Average Score",
            percentile %in% 25:74 ~ "WNL Score",
            percentile %in% 9:24 ~ "Low Average Score",
            percentile %in% 2:8 ~ "Below Average Score",
            percentile < 2 ~ "Exceptionally Low Score",
            TRUE ~ as.character(range)
          )
        )
    } else if (test_type == "basc3") {
      table <-
        table |>
        dplyr::mutate(
          range = dplyr::case_when(
            score >= 60 & subdomain %in% c("Adaptive Skills", "Personal Adjustment") ~ "Normative Strength",
            score %in% 40:59 & subdomain %in% c("Adaptive Skills", "Personal Adjustment") ~ "Average",
            score %in% 30:39 &
              subdomain %in% c("Adaptive Skills", "Personal Adjustment") ~ "At-Risk",
            score %in% 20:29 &
              subdomain %in% c("Adaptive Skills", "Personal Adjustment") ~ "Clinically Significant",
            score <= 20 &
              subdomain %in% c("Adaptive Skills", "Personal Adjustment") ~ "Markedly Impaired",
            score >= 80 &
              subdomain != c("Adaptive Skills", "Personal Adjustment") ~ "Markedly Elevated",
            score %in% 70:79 &
              subdomain != c("Adaptive Skills", "Personal Adjustment") ~ "Clinically Significant",
            score %in% 60:69 &
              subdomain != c("Adaptive Skills", "Personal Adjustment") ~ "At-Risk",
            score %in% 40:59 &
              subdomain != c("Adaptive Skills", "Personal Adjustment") ~ "Average",
            score <= 39 &
              subdomain != c("Adaptive Skills", "Personal Adjustment") ~ "Normative Strength",
            TRUE ~ as.character(range)
          )
        )
    }
    return(table)
  }


#' @title Compute Percentile and Range if Unknown
#' @description Computes percentile, performance range from vector .x and returns the score with the specified type.
#' @importFrom stats pnorm
#' @importFrom dplyr mutate case_when select
#' @param .x A numeric vector.
#' @param .score The value of scores to be calculated according to the scoring type. Default: NA
#' @param .score_type Type of scoring- it can be z_score, scaled_score, t_score or standard_score. Default: c("z_score", "scaled_score", "t_score", "standard_score")
#' @param percentile Percentile of x. Default: NA
#' @param range Difference between the highest and lowest percentiles. Default: NA
#' @param pct1 First percentile. Default: NA
#' @param pct2 Second percentile. Default: NA
#' @param pct3 Third percentile. Default: NA
#' @param z Z-scores. Default: NA
#' @param ... Other arguments not in use.
#' @return Returns the score with the specified type.
#' @details Values are calculated from vector x according to the specified scoring type.
#' @rdname gpluck_compute_percentile_range
#' @export
gpluck_compute_percentile_range <-
  function(.x,
           .score = NA,
           .score_type =
             c("z_score", "scaled_score", "t_score", "standard_score"),
           percentile = NA,
           range = NA,
           pct1 = NA,
           pct2 = NA,
           pct3 = NA,
           z = NA,
           ...) {
    if (.score_type == "z_score") {
      .x <-
        .x |>
        dplyr::mutate(z = (.score - 0) / 1) |>
        dplyr::mutate(pct1 = round(stats::pnorm(z) * 100, 1)) |>
        dplyr::mutate(pct2 = dplyr::case_when(
          pct1 < 1 ~ ceiling(pct1),
          pct1 > 99 ~ floor(pct1),
          TRUE ~ round(pct1)
        )) |>
        dplyr::mutate(pct3 = pct2) |>
        dplyr::mutate(
          range = dplyr::case_when(
            pct3 >= 98 ~ "Exceptionally High",
            pct3 %in% 91:97 ~ "Above Average",
            pct3 %in% 75:90 ~ "High Average",
            pct3 %in% 25:74 ~ "Average",
            pct3 %in% 9:24 ~ "Low Average",
            pct3 %in% 2:8 ~ "Below Average",
            pct3 < 2 ~ "Exceptionally Low",
            TRUE ~ as.character(range)
          )
        ) |>
        dplyr::mutate(percentile = pct1) |>
        dplyr::select(-c(pct1, pct2, pct3))
    } else if (.score_type == "scaled_score") {
      .x <-
        .x |>
        dplyr::mutate(z = (.score - 10) / 3) |>
        dplyr::mutate(pct1 = round(stats::pnorm(z) * 100, 1)) |>
        dplyr::mutate(pct2 = dplyr::case_when(
          pct1 < 1 ~ ceiling(pct1),
          pct1 > 99 ~ floor(pct1),
          TRUE ~ round(pct1)
        )) |>
        dplyr::mutate(pct3 = pct2) |>
        dplyr::mutate(
          range = dplyr::case_when(
            pct3 >= 98 ~ "Exceptionally High",
            pct3 %in% 91:97 ~ "Above Average",
            pct3 %in% 75:90 ~ "High Average",
            pct3 %in% 25:74 ~ "Average",
            pct3 %in% 9:24 ~ "Low Average",
            pct3 %in% 2:8 ~ "Below Average",
            pct3 < 2 ~ "Exceptionally Low",
            TRUE ~ as.character(range)
          )
        ) |>
        dplyr::mutate(percentile = pct1) |>
        dplyr::select(-c(pct1, pct2, pct3))
    } else if (.score_type == "t_score") {
      .x <-
        .x |>
        dplyr::mutate(z = (.score - 50) / 10) |>
        dplyr::mutate(pct1 = round(stats::pnorm(z) * 100, 1)) |>
        dplyr::mutate(pct2 = dplyr::case_when(
          pct1 < 1 ~ ceiling(pct1),
          pct1 > 99 ~ floor(pct1),
          TRUE ~ round(pct1)
        )) |>
        dplyr::mutate(pct3 = pct2) |>
        dplyr::mutate(
          range = dplyr::case_when(
            pct3 >= 98 ~ "Exceptionally High",
            pct3 %in% 91:97 ~ "Above Average",
            pct3 %in% 75:90 ~ "High Average",
            pct3 %in% 25:74 ~ "Average",
            pct3 %in% 9:24 ~ "Low Average",
            pct3 %in% 2:8 ~ "Below Average",
            pct3 < 2 ~ "Exceptionally Low",
            TRUE ~ as.character(range)
          )
        ) |>
        dplyr::mutate(percentile = pct1) |>
        dplyr::select(-c(pct1, pct2, pct3))
    } else if (.score_type == "standard_score") {
      .x <-
        .x |>
        dplyr::mutate(z = (.score - 100) / 15) |>
        dplyr::mutate(pct1 = round(stats::pnorm(z) * 100, 1)) |>
        dplyr::mutate(pct2 = dplyr::case_when(
          pct1 < 1 ~ ceiling(pct1),
          pct1 > 99 ~ floor(pct1),
          TRUE ~ round(pct1)
        )) |>
        dplyr::mutate(pct3 = pct2) |>
        dplyr::mutate(
          range = dplyr::case_when(
            pct3 >= 98 ~ "Exceptionally High",
            pct3 %in% 91:97 ~ "Above Average",
            pct3 %in% 75:90 ~ "High Average",
            pct3 %in% 25:74 ~ "Average",
            pct3 %in% 9:24 ~ "Low Average",
            pct3 %in% 2:8 ~ "Below Average",
            pct3 < 2 ~ "Exceptionally Low",
            TRUE ~ as.character(range)
          )
        ) |>
        dplyr::mutate(percentile = pct1) |>
        dplyr::select(-c(pct1, pct2, pct3))
    }

    return(.x)
  }

#' Compute Percentile and Range if Unknown Version 2
#'
#' This function computes percentile, performance range from a provided numeric vector `.x` and returns the value according to the specified scoring type.
#'
#' @param .x A numeric vector.
#' @param .score The value of scores to be calculated according to the scoring type. Default: NA
#' @param .score_type Type of scoring- it can be z_score, scaled_score, t_score or standard_score. Default: c("z_score", "scaled_score", "t_score", "standard_score")
#' @param percentile Percentile of x. Default: NA
#' @param range Difference between the highest and lowest percentiles. Default: NA
#' @param pct1 First percentile. Default: NA
#' @param pct2 Second percentile. Default: NA
#' @param pct3 Third percentile. Default: NA
#' @param z Z-scores. Default: NA
#' @param ... Other arguments not in use.
#' @return Returns the score with the specified type.
#' @importFrom stats pnorm
#' @importFrom dplyr mutate case_when select
#' @rdname gpluck_compute_percentile_range_v2
#' @export
gpluck_compute_percentile_range_v2 <-
  function(.x, .score = NA, .score_type = c("z_score", "scaled_score", "t_score", "standard_score"),
           percentile = NA, range = NA, pct1 = NA, pct2 = NA, pct3 = NA, z = NA, ...) {
    # Set up the transformation steps
    transform_steps <- list(
      transform_z = dplyr::mutate(z = (.score - 0) / 1),
      transform_pct1 = dplyr::mutate(pct1 = round(stats::pnorm(z) * 100, 1)),
      transform_pct2 = dplyr::mutate(pct2 = dplyr::case_when(
        pct1 < 1 ~ ceiling(pct1),
        pct1 > 99 ~ floor(pct1),
        TRUE ~ round(pct1)
      )),
      transform_pct3 = dplyr::mutate(pct3 = pct2),
      transform_range = dplyr::mutate(
        range = dplyr::case_when(
          pct3 >= 98 ~ "Exceptionally High",
          pct3 %in% 91:97 ~ "Above Average",
          pct3 %in% 75:90 ~ "High Average",
          pct3 %in% 25:74 ~ "Average",
          pct3 %in% 9:24 ~ "Low Average",
          pct3 %in% 2:8 ~ "Below Average",
          pct3 < 2 ~ "Exceptionally Low",
          TRUE ~ as.character(range)
        )
      ),
      transform_percentile = dplyr::mutate(percentile = pct1),
      transform_cols = dplyr::select(-c(pct1, pct2, pct3))
    )

    # Iterate over all defined transformation steps
    transform_function <- NULL
    for (transform_step in transform_steps) {
      transform_function <-
        dplyr::bind_rows(transform_function, transform_step)
    }

    # Create a switch for the different score types
    .x <-
      switch(.score_type,
        z_score = transform_function(.x, .score = .score, pct1 = NA_real_),
        scaled_score = transform_function(.x, .score = .score, pct1 = NA_real_),
        t_score = transform_function(.x, .score = .score, pct1 = NA_real_),
        standard_score = transform_function(.x, .score = .score, pct1 = NA_real_)
      )

    return(.x)
  }
