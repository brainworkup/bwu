# R Script for NeuroPsych
args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 1) {
  stop("Usage: neuropsych.R <patient>")
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
