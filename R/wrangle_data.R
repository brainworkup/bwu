#' @title Read/Load Neuropsych Eval CSV Files
#' @description This function reads .csv files of patient data and writes four different files of the same data that are categorized by neuropsychological test type.
#' @importFrom here here
#' @importFrom dplyr filter distinct mutate group_by ungroup
#' @importFrom purrr map set_names list_rbind
#' @importFrom forcats as_factor
#' @importFrom stats qnorm
#' @importFrom readr read_csv write_csv
#' @param patient character, Name of patient, e.g. "Biggie"
#' @return List with 4 elements, each element is a dataframe of patient data
#' @rdname load_data
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
        data <- readr::read_csv(file.path(data_path, filename), na = c("", "NA", "--", "-"))
        data$filename <- filename
        return(data)
      }
    ) |>
    purrr::list_rbind(names_to = "filename") |>
    # Add a check for 'percentile' column before filtering
    purrr::map(
      function(data) {
        if ("percentile" %in% names(data)) {
          data <- dplyr::filter(data, !is.na(percentile))
        }
        return(data)
      }
    ) |>
    dplyr::distinct() |>
    dplyr::mutate(
      z = qnorm(percentile / 100),
      domain = as.character(domain),
      subdomain = as.character(subdomain),
      narrow = as.character(narrow),
      pass = as.character(pass),
      verbal = forcats::as_factor(verbal),
      timed = forcats::as_factor(timed)
    )

  # Subset neurocognitive data
  neurocog <-
    neuropsych |>
    dplyr::filter(test_type == "npsych_test") |>
    # domain
    group_by(domain, .add = TRUE) |>
    dplyr::mutate(z_mean_domain = mean(z), z_sd_domain = sd(z)) |>
    dplyr::ungroup() |>
    # subdomain
    dplyr::group_by(subdomain, .add = TRUE) |>
    dplyr::mutate(z_mean_subdomain = mean(z), z_sd_subdomain = sd(z)) |>
    dplyr::ungroup() |>
    # narrow
    dplyr::group_by(narrow, .add = TRUE) |>
    dplyr::mutate(z_mean_narrow = mean(z), z_sd_narrow = sd(z)) |>
    dplyr::ungroup() |>
    # pass
    dplyr::group_by(pass, .add = TRUE) |>
    dplyr::mutate(z_mean_pass = mean(z), z_sd_pass = sd(z)) |>
    dplyr::ungroup() |>
    # verbal
    dplyr::group_by(verbal, .add = TRUE) |>
    dplyr::mutate(z_mean_verbal = mean(z), z_sd_verbal = sd(z)) |>
    dplyr::ungroup() |>
    # timed
    dplyr::group_by(timed, .add = TRUE) |>
    dplyr::mutate(z_mean_timed = mean(z), z_sd_timed = sd(z)) |>
    dplyr::ungroup()

  # Subset neurobehavioral data
  neurobehav <-
    neuropsych |>
    dplyr::filter(test_type == "rating_scale") |>
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

  # return(list(
  #   "neuropsych" = neuropsych,
  #   "neurocog" = neurocog,
  #   "neurobehav" = neurobehav,
  #   "validity" = validity
  # ))
}



#' Read Neuropsych Data for Subsetting
#' @description This function reads in the neuropsych data for subsetting.
#' @param pheno Character vector for phenotype. Options are "adhd" or "emotion".
#' @return A tibble containing various subsets of the data.
#' @rdname read_data
#' @export
read_data <- function(pheno) {
  # Check phenotype type and file path
  if (pheno == "adhd" || pheno == "emotion") {
    csv <- "neurobehav.csv"
  } else {
    csv <- "neurocog.csv"
  }
  file_path <- file.path(csv)

  # Read in the CSV file
  data <- readr::read_csv(file_path)

  return(data)
}


#' @title Filters Data by Domain and Scale
#' @description This function filters a dataframe by domain and scale.
#' @param data A dataframe or tibble
#' @param domain The domain name that the user wants to filter by
#' @param scale A text file containing a list of scales
#' @return Returns a filtered data frame
#' @rdname filter_data
#' @export
filter_data <- function(data, domain, scale) {
  data <- data |>
    dplyr::filter(domain %in% domains) |>
    dplyr::filter(scale %in% scales)
  return(data)
}
