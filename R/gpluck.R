#' @rdname gpluck_extract_areas
#' @title Extract areas for PDF plucking of tables
#' @description Interactively identify areas and extract
#' @param file A character string specifying the path to a PDF file. This can also be a URL, in which case the file will be downloaded to the R temporary directory using \code{download.file}.
#' @param pages An optional integer vector specifying pages to extract from. To extract multiple tables from a given page, repeat the page number (e.g., \code{c(1,2,2,3)}).
#' @param \dots Other arguments passed to \code{\link{extract_tables}}.
#'
#' @examples
#' \dontrun{
#' # simple demo file
#' f <- system.file("examples", "data.pdf", package = "tabulizer")
#'
#' # locate areas only, using Shiny app
#' locate_areas(f)
#'
#' # locate areas only, using native graphics device
#' locate_areas(f, widget = "shiny")
#'
#' # locate areas and extract
#' extract_areas(f)
#' }
#' @importFrom tabulizer locate_areas
#' @importFrom tools file_path_sans_ext
#' @importFrom rJava J new
#' @importFrom png readPNG
#' @importFrom grDevices dev.capabilities dev.off
#' @importFrom graphics par rasterImage locator plot
#'
#' @export
gpluck_locate_areas <- function(file, pages = NULL, ...) {
  tabulizer::locate_areas(
    file = file,
    pages = pages,
    ...
  )
}


#' @title Pluck tables from PDFs
#' @description Extract tables from a file
#' @param file A character string specifying the path or URL to a PDF file.
#' @param pages An optional integer vector specifying pages to extract from.
#' @param area An optional list, of length equal to the number of pages specified, where each entry contains a four-element numeric vector of coordinates (top,left,bottom,right) containing the table for the corresponding page. As a convenience, a list of length 1 can be used to extract the same area from all (specified) pages. Only specify \code{area} xor \code{columns}.
#' @param guess A logical indicating whether to guess the locations of tables on each page. If \code{FALSE}, \code{area} or \code{columns} must be specified; if \code{TRUE}, columns is ignored.
#' @param method A string identifying the prefered method of table extraction.
#' \itemize{
#'   \item \code{method = "decide"} (default) automatically decide (for each page) whether spreadsheet-like formatting is present and "lattice" is appropriate
#'   \item \code{method = "lattice"} use Tabula's spreadsheet extraction algorithm
#'   \item \code{method = "stream"} use Tabula's basic extraction algorithm
#' }
#' @param output A function to coerce the Java response object (a Java ArrayList of Tabula Tables) to some output format. The default method, \dQuote{matrices}, returns a list of character matrices. See Details for other options.
#' @param \dots These are additional arguments passed to the internal functions dispatched by \code{method}.
#' @details This function mimics the behavior of the Tabula command line utility. It returns a list of R character matrices containing tables extracted from a file by default. This response behavior can be changed by using the following options.
#' \itemize{
#'   \item \code{output = "character"} returns a list of single-element character vectors, where each vector is a tab-delimited, line-separate string of concatenated table cells.
#'   \item \code{output = "data.frame"} attempts to coerce the structure returned by \code{method = "character"} into a list of data.frames and returns character strings where this fails.
#'   \item \code{output = "csv"} writes the tables to comma-separated (CSV) files using Tabula's CSVWriter method in the same directory as the original PDF. \code{method = "tsv"} does the same but with tab-separated (TSV) files using Tabula's TSVWriter and \code{method = "json"} does the same using Tabula's JSONWriter method. Any of these three methods return the path to the directory containing the extract table files.
#'   \item \code{output = "asis"} returns the Java object reference, which can be useful for debugging or for writing a custom parser.
#' }
#' @return By default, a list of character matrices. This can be changed by specifying an alternative value of \code{method} (see Details).
#' @references \href{http://tabula.technology/}{Tabula}
#' @examples
#' \dontrun{
#' # simple demo file
#' f <- system.file("examples", "data.pdf", package = "tabulizer")
#'
#' # extract all tables
#' extract_tables(f)
#'
#' # extract tables from only second page
#' extract_tables(f, pages = 2)
#'
#' # extract areas from a page
#' ## full table
#' extract_tables(f, pages = 2, area = list(c(126, 149, 212, 462)))
#' ## part of the table
#' extract_tables(f, pages = 2, area = list(c(126, 284, 174, 417)))
#'
#' # return data.frames
#' extract_tables(f, pages = 2, output = "data.frame")
#' }
#' @importFrom tabulizer extract_tables
#' @importFrom utils read.delim download.file
#' @importFrom tools file_path_sans_ext
#' @importFrom rJava J new .jfloat
#' @export
gpluck_extract_table <-
  function(file,
           pages = NULL,
           area = NULL,
           guess = FALSE,
           method = c("decide", "lattice", "stream"),
           output = c("matrix", "data.frame", "character", "asis", "csv", "tsv", "json"),
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


#' @title Make columns for npsych tables
#' @description Make new columns for neuropsych tables more of a description.
#' @param table Name of table
#' @param scale Name of scale/subtest
#' @param raw_score Raw score for scale
#' @param score Standardized score
#' @param range Test score range
#' @param percentile Percentile rank
#' @param ci_95 95% CI
#' @param test Name of test
#' @param test_name Name of test full
#' @param domain Cognitive domain
#' @param subdomain Cognitive subdomain#'
#' @param narrow Narrow cognitive subdomain
#' @param pass PASS model area
#' @param verbal Verbal or nonverbal test
#' @param timed Timed or untimed test
#' @param test_type Test type
#' @param score_type Score type
#' @param absort Sort file
#' @param description Description of scale and ability it measures
#' @param result Performance on this scale
#' @param ... Other args
#'
#' @return A table for the report
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
                                  "Intelligence/General Ability",
                                  "Academic Skills",
                                  "Verbal/Language",
                                  "Visual Perception/Construction",
                                  "Attention/Executive",
                                  "Memory",
                                  "Motor",
                                  "Social Cognition",
                                  "Behavioral/Emotional/Social",
                                  "Personality Disorders",
                                  "Psychiatric Disorders",
                                  "Substance Use Disorders",
                                  "Psychosocial Problems",
                                  "ADHD",
                                  "Executive Dysfunction",
                                  "Effort/Validity",
                                  NA
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
                                  "item"
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
        paste0(tolower(test),
          "_", tolower(scale),
          "_", seq_len(nrow(table))
        ),
      description = description,
      result = result,
      ...
    )
}




#' @title Make test score range (e.g., Below Average, Above Average).
#' @description Use a consistent set of ranges for performance on neuropsychological testing.
#'
#' @param table Name of table
#' @param score Score, raw score, or standard score
#' @param percentile Percentile rank
#' @param range Range of performance score
#' @param test_type Type of test
#' @param ... More if needed
#'
#' @return Returns a modified table.
#'
#' @examples
#' neurocog <- gpluck_make_score_ranges(
#'   table = neurocog,
#'   score = 50,
#'   percentile = 50,
#'   range = "",
#'   test_type = "npsych_test"
#' )
#'
#' @export
gpluck_make_score_ranges <-
  function(table = table,
           score = NULL,
           percentile = NULL,
           range = range,
           test_type,
           ...) {
    if (test_type == "npsych_test") {
      table <-
        table %>%
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
        table %>%
        dplyr::mutate(
          range = dplyr::case_when(
            score >= 70 ~ "Clinically Significant",
            score %in% 60:69 ~ "At-Risk",
            score %in% 40:59 ~ "Average",
            score <= 39 ~ "Below Average/Strength",
            TRUE ~ as.character(range)
          )
        )
    } else if (test_type == "validity_indicator") {
      table <-
        table %>%
        dplyr::mutate(
          range = dplyr::case_when(
            score >= 25 ~ "Within Normal Limits Score",
            score %in% 9:24 ~ "Low Average Score",
            score %in% 2:8 ~ "Below Average Score",
            score < 2 ~ "Exceptionally Low Score",
            TRUE ~ as.character(range)
          )
        )
    } else {
      table <-
        table %>%
        dplyr::mutate(
          range = dplyr::case_when(
            score >= 60 &
              subdomain %in% c("Adaptive Skills", "Personal Adjustment") ~ "Strength",
            score %in% 40:59 &
              subdomain %in% c("Adaptive Skills", "Personal Adjustment") ~ "Within Normal Limits",
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

#' @title Compute percentile scores and ranges
#'
#' @import tidytable
#' @param .x Pronoun for data.frame
#' @param .score Known score
#' @param .score_type Known type of score
#' @param percentile Unknown percentile
#' @param range Unknown test score classification range
#' @param pct1 Temp pct 1
#' @param pct2 Temp pct 2
#' @param pct3 Temp pct 3
#' @param z Z score
#' @param ... Additional expressions
#'
#' @return A table with standardized scores
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
        tidytable::mutate(z = (.score - 0) / 1) %>%
        tidytable::mutate(pct1 = round(stats::pnorm(z) * 100, 1)) %>%
        tidytable::mutate(pct2 = tidytable::case_when(
          pct1 < 1 ~ ceiling(pct1),
          pct1 > 99 ~ floor(pct1),
          TRUE ~ round(pct1)
        )) %>%
        tidytable::mutate(pct3 = pct2) %>%
        tidytable::mutate(
          range = tidytable::case_when(
            pct3 >= 98 ~ "Exceptionally High",
            pct3 %in% 91:97 ~ "Above Average",
            pct3 %in% 75:90 ~ "High Average",
            pct3 %in% 25:74 ~ "Average",
            pct3 %in% 9:24 ~ "Low Average",
            pct3 %in% 2:8 ~ "Below Average",
            pct3 < 2 ~ "Exceptionally Low",
            TRUE ~ as.character(range)
          )
        ) %>%
        tidytable::mutate(percentile = pct1) %>%
        tidytable::select(-c(pct1, pct2, pct3))
    } else if (.score_type == "scaled_score") {
      .x <-
        .x |>
        tidytable::mutate(z = (.score - 10) / 3) %>%
        tidytable::mutate(pct1 = round(stats::pnorm(z) * 100, 1)) %>%
        tidytable::mutate(pct2 = tidytable::case_when(
          pct1 < 1 ~ ceiling(pct1),
          pct1 > 99 ~ floor(pct1),
          TRUE ~ round(pct1)
        )) %>%
        tidytable::mutate(pct3 = pct2) %>%
        tidytable::mutate(
          range = tidytable::case_when(
            pct3 >= 98 ~ "Exceptionally High",
            pct3 %in% 91:97 ~ "Above Average",
            pct3 %in% 75:90 ~ "High Average",
            pct3 %in% 25:74 ~ "Average",
            pct3 %in% 9:24 ~ "Low Average",
            pct3 %in% 2:8 ~ "Below Average",
            pct3 < 2 ~ "Exceptionally Low",
            TRUE ~ as.character(range)
          )
        ) %>%
        tidytable::mutate(percentile = pct1) %>%
        tidytable::select(-c(pct1, pct2, pct3))
    } else if (.score_type == "t_score") {
      .x <-
        .x |>
        tidytable::mutate(z = (.score - 50) / 10) %>%
        tidytable::mutate(pct1 = round(stats::pnorm(z) * 100, 1)) %>%
        tidytable::mutate(pct2 = tidytable::case_when(
          pct1 < 1 ~ ceiling(pct1),
          pct1 > 99 ~ floor(pct1),
          TRUE ~ round(pct1)
        )) %>%
        tidytable::mutate(pct3 = pct2) %>%
        tidytable::mutate(
          range = tidytable::case_when(
            pct3 >= 98 ~ "Exceptionally High",
            pct3 %in% 91:97 ~ "Above Average",
            pct3 %in% 75:90 ~ "High Average",
            pct3 %in% 25:74 ~ "Average",
            pct3 %in% 9:24 ~ "Low Average",
            pct3 %in% 2:8 ~ "Below Average",
            pct3 < 2 ~ "Exceptionally Low",
            TRUE ~ as.character(range)
          )
        ) %>%
        tidytable::mutate(percentile = pct1) %>%
        tidytable::select(-c(pct1, pct2, pct3))
    } else if (.score_type == "standard_score") {
      .x <-
        .x |>
        tidytable::mutate(z = (.score - 100) / 15) %>%
        tidytable::mutate(pct1 = round(stats::pnorm(z) * 100, 1)) %>%
        tidytable::mutate(pct2 = tidytable::case_when(
          pct1 < 1 ~ ceiling(pct1),
          pct1 > 99 ~ floor(pct1),
          TRUE ~ round(pct1)
        )) %>%
        tidytable::mutate(pct3 = pct2) %>%
        tidytable::mutate(
          range = tidytable::case_when(
            pct3 >= 98 ~ "Exceptionally High",
            pct3 %in% 91:97 ~ "Above Average",
            pct3 %in% 75:90 ~ "High Average",
            pct3 %in% 25:74 ~ "Average",
            pct3 %in% 9:24 ~ "Low Average",
            pct3 %in% 2:8 ~ "Below Average",
            pct3 < 2 ~ "Exceptionally Low",
            TRUE ~ as.character(range)
          )
        ) %>%
        tidytable::mutate(percentile = pct1) %>%
        tidytable::select(-c(pct1, pct2, pct3))
    }
  }


#' Import Neurocognitive Index Scores
#'
#' @param patient Name of patient
#'
#' @return A table
#' @export
#'
gpluck_get_index_scores <- function(patient) {
  ## Import/Tidy Excel Index Score File

  patient <- patient

  ## Import data

  df <- readxl::read_xlsx(here::here(patient, "index_scores.xlsx")) |>
    janitor::clean_names()

  names <- c("scale", "score", "scaled_score", "t_score", "percentile", "reliability", "ci_95", "composition")

  names(df) <- names

  df <- as.data.frame(df)

  ## Mutate columns

  df <- bwu::gpluck_make_columns(
    table = df,
    raw_score = "",
    range = "",
    test = "index",
    test_name = "Composite Scores",
    domain = "",
    subdomain = "",
    narrow = "",
    pass = "",
    verbal = "",
    timed = "",
    test_type = "npsych_test",
    score_type = "standard_score",
    absort = "",
    description = "",
    result = ""
  )

  ## Test score ranges

  df <- bwu::gpluck_make_score_ranges(table = df, test_type = "npsych_test")

  ## Domains

  df <-
    df |>
    dplyr::mutate(
      domain = dplyr::case_when(
        scale == "General Ability" ~ "Intelligence/General Ability",
        scale == "Cognitive Proficiency" ~ "Intelligence/General Ability",
        scale == "Crystallized Knowledge" ~ "Intelligence/General Ability",
        scale == "Fluid Reasoning" ~ "Intelligence/General Ability",
        scale == "Working Memory" ~ "Intelligence/General Ability",
        scale == "Processing Speed" ~ "Intelligence/General Ability",
        TRUE ~ as.character(domain)
      )
    )

  ## Subdomain

  df <-
    df |>
    dplyr::mutate(
      subdomain = dplyr::case_when(
        scale == "General Ability" ~ "General Intelligence",
        scale == "Cognitive Proficiency" ~ "Cognitive Proficiency",
        scale == "Crystallized Knowledge" ~ "General Intelligence",
        scale == "Fluid Reasoning" ~ "General Intelligence",
        scale == "Working Memory" ~ "Cognitive Proficiency",
        scale == "Processing Speed" ~ "Cognitive Proficiency",
        TRUE ~ as.character(subdomain)
      )
    )

  ## Narrow subdomain

  df <-
    df |>
    dplyr::mutate(
      narrow = dplyr::case_when(
        scale == "General Ability" ~ "General Ability",
        scale == "Cognitive Proficiency" ~ "Cognitive Proficiency",
        scale == "Crystallized Knowledge" ~ "Crystallized Knowledge",
        scale == "Fluid Reasoning" ~ "Fluid Reasoning",
        scale == "Working Memory" ~ "Working Memory",
        scale == "Processing Speed" ~ "Processing Speed",
        TRUE ~ as.character(narrow)
      )
    )

  ## PASS model

  df <-
    df |>
    dplyr::mutate(
      pass = dplyr::case_when(
        scale == "General Ability" ~ "",
        scale == "Cognitive Proficiency" ~ "",
        scale == "Crystallized Knowledge" ~ "",
        scale == "Fluid Reasoning" ~ "",
        scale == "Working Memory" ~ "",
        scale == "Processing Speed" ~ "",
        TRUE ~ as.character(pass)
      )
    )

  ## Verbal vs Nonverbal

  df <-
    df |>
    dplyr::mutate(
      verbal = dplyr::case_when(
        scale == "General Ability" ~ "",
        scale == "Cognitive Proficiency" ~ "",
        scale == "Crystallized Knowledge" ~ "Verbal",
        scale == "Fluid Reasoning" ~ "Nonverbal",
        scale == "Working Memory" ~ "Verbal",
        scale == "Processing Speed" ~ "Nonverbal",
        TRUE ~ as.character(verbal)
      )
    )

  ## Timed vs Untimed

  df <-
    df |>
    dplyr::mutate(
      timed = dplyr::case_when(
        scale == "General Ability" ~ "",
        scale == "Cognitive Proficiency" ~ "",
        scale == "Crystallized Knowledge" ~ "Untimed",
        scale == "Fluid Reasoning" ~ "Timed",
        scale == "Working Memory" ~ "Untimed",
        scale == "Processing Speed" ~ "Timed",
        TRUE ~ as.character(timed)
      )
    )

  ## Scale descriptions

  df <-
    df |>
    dplyr::mutate(
      description = dplyr::case_when(
        scale ==
          "General Ability" ~
          "An estimate of higher cognitive reasoning and acquired knowledge (*g*)",
        scale ==
          "Cognitive Proficiency" ~
          "A composite estimate of working memory^[(ref:working-memory)] and processing speed^[(ref:processing-speed)] (i.e., *attentional fluency*)",
        scale ==
          "Crystallized Knowledge" ~
          "Crystallized intelligence (*G*c)",
        scale ==
          "Fluid Reasoning" ~
          "An estimate of fluid intelligence (*G*f)",
        scale ==
          "Working Memory" ~
          "A composite estimate of short-term working memory^[(ref:working-memory)]",
        scale ==
          "Processing Speed" ~
          "A composite estimate of complex processing speed and efficiency^[(ref:processing-speed)]",
        TRUE ~ as.character(description)
      )
    )

  ## Glue result

  df <-
    df |>
    dplyr::mutate(
      result = dplyr::case_when(
        scale == "General Ability" ~ glue::glue(
          "{description} was {range} and ranked at the {percentile}th percentile, indicating performance as good as or better than {percentile}% of same-age peers from the general population.\n"
        ),
        scale == "Cognitive Proficiency" ~ glue::glue(
          "{description} was {range} and a relative strength|weakness.\n"
        ),
        scale == "Crystallized Knowledge" ~ glue::glue(
          "{description} was classified as {range} and ranked at the {percentile}th percentile.\n"
        ),
        scale == "Fluid Reasoning" ~ glue::glue(
          "{description} was classified as {range}.\n"
        ),
        scale == "Working Memory" ~ glue::glue("{description} fell in the {range} range and was and a relative strength|weakness.\n"
        ),
        scale == "Processing Speed" ~ glue::glue(
          "{description} was {range} and a relative strength|weakness.\n"
        ),
        TRUE ~ as.character(result)
      )
    )

  ## Relocate variables

  g <-
    df |>
    dplyr::relocate(
      c(raw_score, score, percentile, range, ci_95), .before = test) |>
    dplyr::relocate(
      c(scaled_score, t_score, reliability, composition), .after = result) |>
    dplyr::filter(scale %in% c("General Ability", "Cognitive Proficiency", "Crystallized Knowledge", "Fluid Reasoning", "Working Memory", "Processing Speed"))

  ## Write out CSV

  readr::write_csv(g, here::here(patient, "csv", "g.csv"), append = FALSE, col_names = TRUE)
}
