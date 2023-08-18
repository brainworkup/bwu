#' This function reads .csv files of patient data and writes four different files of the same data that are categorized by neuropsychological test type.
#' @param patient character, Name of patient, e.g. "Biggie"
#' @export
#' @return List with 4 elements, each element is a dataframe of patient data
neuro_data <- function(patient) {
  # Ensure patient is specified
  if (missing(patient)) {
    stop("Patient must be specified.")
  }

  # Define path for the data
  data_path <- here::here(patient, "csv")
  files <- dir(data_path, pattern = "*.csv")

  # Read and process neuropsych data
  neuropsych <- files |>
    purrr::set_names() |>
    purrr::map(
      ~ readr::read_csv(file.path(data_path, .), na = c("", "NA", "--", "-"), .id = "filename")
    ) |>
    purrr::list_rbind() |>
    dplyr::filter(!is.na(percentile)) |>
    dplyr::distinct() |>
    dplyr::mutate(
      z = stats::qnorm(percentile / 100),
      domain = forcats::as_factor(domain),
      subdomain = forcats::as_factor(subdomain),
      narrow = forcats::as_factor(narrow),
      pass = forcats::as_factor(pass),
      verbal = forcats::as_factor(verbal),
      timed = forcats::as_factor(timed)
    )

  # Process data for the various subsets (neurocog, neurobehav, validity)
  # Subset neurocognitive data
  neurocog <-
    neuropsych |>
    dplyr::filter(test_type == "npsych_test") |>
    # domain
    dplyr::group_by(domain, .add = TRUE) |>
    dplyr::filter(!is.na(percentile)) |>
    dplyr::mutate(z_mean_domain = mean(z), z_sd_domain = sd(z)) |>
    dplyr::ungroup() |>
    # subdomain
    dplyr::group_by(subdomain, .add = TRUE) |>
    dplyr::filter(!is.na(percentile)) |>
    dplyr::mutate(z_mean_subdomain = mean(z), z_sd_subdomain = sd(z)) |>
    dplyr::ungroup() |>
    # narrow
    dplyr::group_by(narrow, .add = TRUE) |>
    dplyr::filter(!is.na(percentile)) |>
    dplyr::mutate(z_mean_narrow = mean(z), z_sd_narrow = sd(z)) |>
    dplyr::ungroup() |>
    # pass
    dplyr::group_by(pass, .add = TRUE) |>
    dplyr::filter(!is.na(percentile)) |>
    dplyr::mutate(z_mean_pass = mean(z), z_sd_pass = sd(z)) |>
    dplyr::ungroup() |>
    # verbal
    dplyr::group_by(verbal, .add = TRUE) |>
    dplyr::filter(!is.na(percentile)) |>
    dplyr::mutate(z_mean_verbal = mean(z), z_sd_verbal = sd(z)) |>
    dplyr::ungroup() |>
    # timed
    dplyr::group_by(timed, .add = TRUE) |>
    dplyr::filter(!is.na(percentile)) |>
    dplyr::mutate(z_mean_timed = mean(z), z_sd_timed = sd(z)) |>
    dplyr::ungroup()

  # Subset neurobehavioral data
  neurobehav <-
    neuropsych |>
    dplyr::filter(test_type == "rating_scale") |>
    # domain
    dplyr::group_by(domain, .add = TRUE) |>
    dplyr::filter(!is.na(percentile)) |>
    dplyr::mutate(z_mean_domain = mean(z), z_sd_domain = sd(z)) |>
    dplyr::ungroup() |>
    # subdomain
    dplyr::group_by(subdomain, .add = TRUE) |>
    dplyr::filter(!is.na(percentile)) |>
    dplyr::mutate(z_mean_subdomain = mean(z), z_sd_subdomain = sd(z)) |>
    dplyr::ungroup() |>
    # narrow
    dplyr::group_by(narrow, .add = TRUE) |>
    dplyr::filter(!is.na(percentile)) |>
    dplyr::mutate(z_mean_narrow = mean(z), z_sd_narrow = sd(z)) |>
    dplyr::ungroup()

  # Subset validity data
  validity <-
    neuropsych |>
    dplyr::filter(
      test_type %in% c("performance_validity", "symptom_validity")
    ) |>
    # domain
    dplyr::group_by(domain, .add = TRUE) |>
    dplyr::mutate(z_mean_domain = mean(z), z_sd_domain = sd(z)) |>
    dplyr::ungroup() |>
    # subdomain
    dplyr::group_by(subdomain, .add = TRUE) |>
    dplyr::mutate(z_mean_subdomain = mean(z), z_sd_subdomain = sd(z)) |>
    dplyr::ungroup() |>
    # narrow
    dplyr::group_by(narrow, .add = TRUE) |>
    dplyr::mutate(z_mean_narrow = mean(z), z_sd_narrow = sd(z)) |>
    dplyr::ungroup()

  # Write processed data to CSVs
  readr::write_csv(neuropsych, here::here(patient, "neuropsych.csv"))
  readr::write_csv(neurocog, here::here(patient, "neurocog.csv"))
  readr::write_csv(neurobehav, here::here(patient, "neurobehav.csv"))
  readr::write_csv(validity, here::here(patient, "validity.csv"))

  return(list(
    "neuropsych" = neuropsych,
    "neurocog" = neurocog,
    "neurobehav" = neurobehav,
    "validity" = validity
  ))
}
