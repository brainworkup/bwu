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
  scale_text <- extracted_text[[page]]

  # Convert the string into a vector of lines
  lines <- strsplit(scale_text, "\n")[[1]]

  # Filter lines that contain the word in scale
  scale_text_filtered <- lines[grepl(scale, lines)]

  return(scale_text_filtered)
}


#' @title gpluck_locate_areas
#' @description This is a function to pluck and locate areas from file.
#' @param file The File name of the input PDF.
#' @param pages A vector of character strings specifying which pages to analyse, Default: NULL
#' @param ... Additional arguments passed to locate_areas() in the tabulizer package.
#' @return A list containing all areas found by area extraction algorithem.
#' @details Use this function with caution when handling sensitive PDFs as it involves rasterizing those documents. Also use this function if your PDF contains tables and you want to access those tables programmatically.
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # Get the located areas from file "example.pdf":
#'   exampleOutput <- gpluck_locate_areas("example.pdf")
#' }
#' }
#' @seealso
#'  \code{\link[tabulizer]{locate_areas}}
#' @rdname gpluck_locate_areas
#' @export
#' @importFrom tabulizer locate_areas
gpluck_locate_areas <- function(file, pages = NULL, ...) {
  tabulizer::locate_areas(
    file = file,
    pages = pages,
    ...
  )
}


#' @title gpluck_extract_tablevscode-file://vscode-app/Applications/Visual%20Studio%20Code.app/Contents/Resources/app/out/vs/code/electron-sandbox/workbench/workbench.html
#' @description This function returns the tables in a PDF file as parsed by the tabulizer package.
#' @importFrom tabulizer extract_tables
#' @param file The path to the PDF file.
#' @param pages A single page number or vector of page numbers, Default: NULL
#' @param area An area on the page given as c(x0, y0, x1, y1). Default: NULL
#' @param guess Whether to attempt to detect tables when the coordinates are not given. Default: FALSE
#' @param method Method to use for parsing. Default: c("decide", "lattice", "stream")
#' @param output Output format (see \code{\link[tabulizer]{extract_tables}} for more details). Default: c("matrix", "data.frame", "character", "asis", "csv", "tsv", "json")
#' @param ... Other arguments to \code{\link[tabulizer]{extract_tables}}
#' @return A parsed table in either matrix, data frame, character, asis, csv, tsv or json format.
#' @details This is a wrapper around the \code{\link[tabulizer]{extract_tables}} function that allows for easier access to the tables in a PDF document.
#' @seealso
#'  \code{\link[tabulizer]{extract_tables}}
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
    tabulizer::extract_tables(
      file = file,
      pages = pages,
      area = area,
      guess = match.arg(guess),
      method = match.arg(method),
      output = match.arg(output)
    )
  }


#' @title Make additional variables/columns from PDF tables.
#' @description This function takes a data frame containing text data from PDF tables, and makes additional columns of binary, range or score values for the specified domain, subdomains, test types, etc.
#' @param table Name of data/table to import and tidy.
#' @param test Name of test that information will be extracted from.
#' @param test_name Test name as provided in test field.
#' @param scale Type of scale used to report the results (scored, binary, categorical, etc.). Default: NULL
#' @param raw_score Raw score if available. Default: NULL
#' @param score Score for the given test. Default: NULL
#' @param range Range for the given test. Default: NULL
#' @param percentile Percentile for the given test. Default: NULL
#' @param ci_95 Confidence interval level (95%) for the given test. Default: NULL
#' @param domain Domain of the test, e.g. Intelligence/General Ability, Academic Skills. Default: c("Intelligence/General Ability", "Academic Skills", "Verbal/Language", "Visual Perception/Construction", "Attention/Executive", "Memory", "Motor", "Social Cognition", "Behavioral/Emotional/Social",
#'    "Personality Disorders", "Psychiatric Disorders", "Substance Use Disorders",
#'    "Psychosocial Problems", "ADHD", "Executive Dysfunction",
#'    "Effort/Validity", "")
#' @param subdomain Cognitive subdomain of the scale. Default: NULL
#' @param narrow Narrow cognitive domain of the scale. Default: NULL
#' @param pass PASS Cognitive Model. Default: c("Planning", "Attention", "Sequential", "Simultaneous", "Knowledge",
#'    NA)
#' @param verbal Type of verbal ability tested, e.g. Verbal, Nonverbal. Default: c("Verbal", "Nonverbal", NA)
#' @param timed Indicates if the test is timed or not. Default: c("Timed", "Untimed", NA)
#' @param test_type Type of test, e.g. npsych_test, rating_scale, validity_indicator, item. Default: c("npsych_test", "rating_scale", "validity_indicator", "item",
#'    NA)
#' @param score_type Type of score reported, e.g. raw_score, scaled_score, t_score, standard_score, z_score, percentile, base_rate, beta_coefficient. Default: c("raw_score", "scaled_score", "t_score", "standard_score", "z_score",
#'    "percentile", "base_rate", "beta_coefficient", NA)
#' @param absort Default order of scales to use for sorting. Default: NULL
#' @param description Description of the test or task. Default: NULL
#' @param result Concatenate the results to include details of test performance. Default: NULL
#' @param ... Other parameters.
#' @return A modified data frame with additional columns.
#' @details This function adds new columns to a data frame by extracting numerical values from PDF tables.
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   # EXAMPLE1
#'   gpluck_make_columns(
#'     data = data,
#'     test = "wais4",
#'     test_name = "WAIS-IV",
#'     domain = "Intelligence/General Ability",
#'     score_type = "scaled_score"
#'   )
#' }
#' }
#' @rdname gpluck_make_columns
#' @export
gpluck_make_columns <- function(table,
                                test,
                                test_name,
                                scale = NULL,
                                raw_score = NULL,
                                score = NULL,
                                range = NULL,
                                percentile = NULL,
                                ci_95 = NULL,
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
  table <-
    dplyr::mutate(
      table,
      scale = scale,
      raw_score = raw_score,
      score = score,
      range = range,
      percentile = percentile,
      ci_95 = ci_95,
      test = test,
      test_name = test_name,
      domain = domain,
      subdomain = subdomain,
      narrow = narrow,
      pass = pass,
      verbal = verbal,
      timed = timed,
      test_type = test_type,
      score_type = score_type,
      absort =
        paste0(
          tolower(test),
          "_", seq_len(nrow(table))
        ),
      description = description,
      result = result,
      ...
    )
  return(table)
}


#' @title gpluck_make_score_ranges
#' @description This function takes a text table of score ranges for each percentile, and returns an object that matches the input but with the ability to get score ranges for any given test type
#' @param table The table containing the lower bound and upper bound score columns
#' @param score Optional lower bound or upper bound score column name. If omitted, use `Score`
#' @param percentile Option percentiles column name. if omitted, use `Percentile`
#' @param range Score performance range. if omitted, use `Range`
#' @param test_type A vector of test types to consider. Default: c("npsych_test", "rating_scale", "validity_indicator", "basc3")
#' @param ... Other arguments passed on to `dplyr::filter`
#' @return An object that matches the input but with the ability to get score ranges for any given test type
#' @details This function takes a text table of score ranges for each percentile, and returns an object that matches the input but with the ability to get score ranges for any given test type
#' @examples
#' \dontrun{
#' # EXAMPLE 1
#' }
#' @rdname gpluck_make_score_ranges
#' @export
gpluck_make_score_ranges <-
  function(table,
           score = NULL,
           percentile = NULL,
           range = range,
           test_type = c(
             "npsych_test",
             "rating_scale",
             "validity_indicator",
             "basc3",
             "item",
             NA
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
            percentile >= 25 ~ "Within Normal Limits Score",
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
            percentile %in% 25:74 ~ "Within Normal Limits Score",
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
            score >= 60 & subdomain %in% c("Adaptive Skills", "Personal Adjustment") ~ "Strength",
            score %in% 40:59 & subdomain %in% c("Adaptive Skills", "Personal Adjustment") ~ "Within Normal Limits",
            score %in% 30:39 &
              subdomain %in% c("Adaptive Skills", "Personal Adjustment") ~ "Mildly Elevated",
            score %in% 20:29 &
              subdomain %in% c("Adaptive Skills", "Personal Adjustment") ~ "Significantly Elevated",
            score <= 29 &
              subdomain %in% c("Adaptive Skills", "Personal Adjustment") ~ "Markedly Elevated",
            score >= 80 &
              subdomain != c("Adaptive Skills", "Personal Adjustment") ~ "Markedly Elevated",
            score %in% 70:79 &
              subdomain != c("Adaptive Skills", "Personal Adjustment") ~ "Significantly Elevated",
            score %in% 60:69 &
              subdomain != c("Adaptive Skills", "Personal Adjustment") ~ "Mildly Elevated",
            score %in% 40:59 &
              subdomain != c("Adaptive Skills", "Personal Adjustment") ~ "Within Normal Limits",
            score <= 39 &
              subdomain != c("Adaptive Skills", "Personal Adjustment") ~ "Strength",
            TRUE ~ as.character(range)
          )
        )
    }
  }


#' @title gpluck_compute_percentile_range
#' @description Computes percentile, range, scores from vector .x and returns the score with the specified type.
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
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   x <- c(10, 20, 30, 40, 50)
#'   gpluck_compute_percentile_range(x, .score_type = "z_score")
#' }
#' }
#' @rdname gpluck_compute_percentile_range
#' @export
#'
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


#' @title compute_pctile_range
#' @description Computes percentile, range, and percentiles for a given score value
#' @param .x a numeric vector of scores
#' @param .score a single numeric score for which percentiles are to be computed, Default: NA
#' @param .score_type type of score, Default: c("z_score", "scaled_score", "t_score", "standard_score", "raw_score")
#' @param percentile numeric vector of percentile rank, Default: NA
#' @param range numeric vector of range, Default: NA
#' @param pct1 1st percentile, Default: NA
#' @param pct2 2nd percentile, Default: NA
#' @param pct3 3rd percentile, Default: NA
#' @param z Z-score, Default: NA
#' @param ... additional arguments passed to \code{pnorm} function
#' @return returns list of percentile, range, and percentiles
#' @details Provides appropriate percentiles based on the score argument supplied. It covers following types
#' of scores such as z-score, t-score, scaled, raw and standard
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   scores <- c(35, 52, 74, 98)
#'   compute_pctile_range(scores, 74) # this will return percentile, range, pct1, pct2 and pct3
#' }
#' }
#' @rdname compute_pctile_range
#' @export
#' @importFrom stats pnorm
compute_pctile_range <-
  function(.x,
           .score = NA,
           .score_type =
             c("z_score", "scaled_score", "t_score", "standard_score", "raw_score"),
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
    } else if (.score_type == "raw_score") {
      .x <-
        .x |>
        dplyr::mutate(z = (.score - mean(raw_score)) / sd(raw_score)) |>
        dplyr::mutate(pct1 = round(stats::pnorm(z) * 100, 1)) |>
        dplyr::mutate(pct2 = dplyr::case_when(
          pct1 < 1 ~ ceiling(pct1),
          pct1 > 99 ~ floor(pct1),
          TRUE ~ round(pct1)
        )) |>
        dplyr::mutate(pct3 = pct2) |>
        dplyr::mutate(
          range = dplyr::case_when(
            pct3 >= 25 ~ "Within Normal Limits Score",
            pct3 %in% 9:24 ~ "Low Average Score",
            pct3 %in% 2:8 ~ "Below Average Score",
            pct3 < 2 ~ "Exceptionally Low Score",
            TRUE ~ as.character(range)
          )
        ) |>
        dplyr::mutate(percentile = pct1) |>
        dplyr::select(-c(pct1, pct2, pct3))
    }
    return(.x)
  }
