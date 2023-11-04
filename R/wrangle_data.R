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
  data_path <- here(patient, "csv")
  files <- dir(data_path, pattern = "*.csv")

  # Read and process neuropsych data
  neuropsych <-
    files |>
    set_names() |>
    map(
      function(filename) {
        dat <- read_csv(file.path(data_path, filename), na = c("", "NA", "--", "-"))
        dat$filename <- filename
        return(dat)
      }
    ) |>
    list_rbind(names_to = "filename") |>
    filter(!is.na(percentile)) |>
    distinct() |>
    mutate(
      z = qnorm(percentile / 100),
      domain = as.character(domain),
      subdomain = as.character(subdomain),
      narrow = as.character(narrow),
      pass = as.character(pass),
      verbal = as_factor(verbal),
      timed = as_factor(timed)
    )

  # Subset neurocognitive data
  neurocog <-
    neuropsych |>
    filter(test_type == "npsych_test") |>
    # domain
    group_by(domain, .add = TRUE) |>
    mutate(z_mean_domain = mean(z), z_sd_domain = sd(z)) |>
    ungroup() |>
    # subdomain
    group_by(subdomain, .add = TRUE) |>
    mutate(z_mean_subdomain = mean(z), z_sd_subdomain = sd(z)) |>
    ungroup() |>
    # narrow
    group_by(narrow, .add = TRUE) |>
    mutate(z_mean_narrow = mean(z), z_sd_narrow = sd(z)) |>
    ungroup() |>
    # pass
    group_by(pass, .add = TRUE) |>
    mutate(z_mean_pass = mean(z), z_sd_pass = sd(z)) |>
    ungroup() |>
    # verbal
    group_by(verbal, .add = TRUE) |>
    mutate(z_mean_verbal = mean(z), z_sd_verbal = sd(z)) |>
    ungroup() |>
    # timed
    group_by(timed, .add = TRUE) |>
    mutate(z_mean_timed = mean(z), z_sd_timed = sd(z)) |>
    ungroup()

  # Subset neurobehavioral data
  neurobehav <-
    neuropsych |>
    filter(test_type == "rating_scale") |>
    # domain
    group_by(domain, .add = TRUE) |>
    mutate(z_mean_domain = mean(z), z_sd_domain = sd(z)) |>
    ungroup() |>
    # subdomain
    group_by(subdomain, .add = TRUE) |>
    mutate(z_mean_subdomain = mean(z), z_sd_subdomain = sd(z)) |>
    ungroup() |>
    # narrow
    group_by(narrow, .add = TRUE) |>
    mutate(z_mean_narrow = mean(z), z_sd_narrow = sd(z)) |>
    ungroup()

  # Subset validity data
  validity <-
    neuropsych |>
    filter(
      test_type %in% c("performance_validity", "symptom_validity")
    ) |>
    # domain
    group_by(domain, .add = TRUE) |>
    mutate(z_mean_domain = mean(z), z_sd_domain = sd(z)) |>
    ungroup() |>
    # subdomain
    group_by(subdomain, .add = TRUE) |>
    mutate(z_mean_subdomain = mean(z), z_sd_subdomain = sd(z)) |>
    ungroup() |>
    # narrow
    group_by(narrow, .add = TRUE) |>
    mutate(z_mean_narrow = mean(z), z_sd_narrow = sd(z)) |>
    ungroup()

  # Write processed data to CSVs
  write_csv(neuropsych, here(patient, "neuropsych.csv"))
  write_csv(neurocog, here(patient, "neurocog.csv"))
  write_csv(neurobehav, here(patient, "neurobehav.csv"))
  write_csv(validity, here(patient, "validity.csv"))

  return(list(
    "neuropsych" = neuropsych,
    "neurocog" = neurocog,
    "neurobehav" = neurobehav,
    "validity" = validity
  ))
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
