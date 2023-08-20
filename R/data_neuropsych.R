#' This function reads .csv files of patient data and writes four different files of the same data that are categorized by neuropsychological test type.
#' @importFrom here here
#' @importFrom dplyr filter distinct mutate group_by ungroup
#' @importFrom purrr map set_names list_rbind
#' @importFrom forcats as_factor
#' @importFrom stats qnorm
#' @importFrom readr read_csv write_csv
#' @param patient character, Name of patient, e.g. "Biggie"
#' @return List with 4 elements, each element is a dataframe of patient data
#' @rdname load_neuro_data
#' @export
load_data <- function(patient) {
  # Ensure patient is specified
  if (missing(patient)) {
    stop("Patient must be specified.")
  }

  # Define path for the data
  data_path <- here::here(patient, "csv")
  files <- dir(data_path, pattern = "*.csv")

  # Read and process neuropsych data
  neuropsych <-
    files |>
    purrr::set_names() |>
    purrr::map(
      function(filename) {
        dat <- readr::read_csv(file.path(data_path, filename), na = c("", "NA", "--", "-"))
        dat$filename <- filename
        return(dat)
      }
    ) |>
    purrr::list_rbind(names_to = "filename") |>
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


#' Read data from a csv file.
#' @param pheno Character vector for phenotype. Options are "adhd" or "emotion".
#' @return A tibble containing the data.
#' @export
#' @importFrom readr read_csv
#' @importFrom dplyr filter arrange distinct desc mutate
#' @rdname read_data
read_data <- function(pheno) {
  if (pheno == "adhd" || pheno == "emotion") {
    csv <- "neurobehav.csv"
  } else {
    csv <- "neurocog.csv"
  }
  file_path <- file.path(csv)
  data <- readr::read_csv(file_path)
  return(data)
}

#' @title Filters data by domain and scale
#' @importFrom dplyr filter
#' @param data A dataframe or tibble
#' @param domain The domain name that the user wants to filter by
#' @param scale A text file containing a list of scales
#' @return Returns a filtered data frame
#' @rdname filter_domain_scale
#' @export
filter_data <- function(data, domain, scale) {
  data <- data |>
    dplyr::filter(domain %in% domains, !is.na(percentile)) |>
    dplyr::filter(scale %in% scales)
  return(data)
}
