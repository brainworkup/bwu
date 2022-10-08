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
#' @param ... Other args
#'
#' @return A table for the report
#' @export
gpluck_make_columns <- function(table,
                                scale = NULL,
                                raw_score = NULL,
                                score = NULL,
                                range = NULL,
                                percentile = NULL,
                                ci_95 = NULL,
                                test,
                                test_name,
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
                                  "rating_scale2"
                                ),
                                score_type = c(
                                  "raw_score",
                                  "scaled_score",
                                  "t_score",
                                  "standard_score",
                                  "z_score",
                                  "percentile",
                                  "base_rate",
                                  NA
                                ),
                                absort = NULL,
                                description = NULL,
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
      absort = paste0(tolower(test), "_", tolower(scale), "_", seq_len(nrow(table))),
      description = description,
      ...
    )
}
