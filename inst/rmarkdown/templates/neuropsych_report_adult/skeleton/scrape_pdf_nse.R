# R Script for NeuroPsych
# This script is designed to extract the patient's scores from the
# PDFs we have created from the NeuroPsych website. It will
# extract the CAARS scores and the CEFI scores and save them
# as CSV files in the folder for each patient.

# First, we need to get the name of the patient. This is passed
# as a command line argument. If the user does not provide the
# argument, we will stop the script.

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 1) {
  stop("Usage: scrape_pdf_nse.R <patient>")
}

patient <- args[1]

# caars_sr
rmarkdown::render("pluck_caars.Rmd", params = "ask")
Sys.sleep(1)

# caars_or
rmarkdown::render("pluck_caars.Rmd", params = "ask")
Sys.sleep(1)

# cefi_sr
rmarkdown::render("pluck_cefi.Rmd", params = "ask")
Sys.sleep(1)

# cefi or
rmarkdown::render("pluck_cefi.Rmd", params = "ask")
Sys.sleep(1)
