# Load the knitr package
library(knitr)

# Predefined list of input files
file_list <- c(
  "_02-01_iq.qmd",
  # "_02-02_academics.qmd",
  "_02-03_verbal.qmd",
  "_02-04_spatial.qmd",
  "_02-05_executive.qmd",
  "_02-06_memory.qmd",
  # "_02-07_motor.qmd",
  # "_02-08_social.qmd",
  "_02-09_adhd.qmd",
  "_02-10_emotion.qmd",
  # "_02-11_adaptive.qmd",
  "_03-00_sirf.qmd"
)

# Loop through the list to knit each file
for (file in file_list) {
  cat("Knitting file:", file, "\n")
  # Knit each Quarto file to execute R code chunks
  # Note: This assumes that the Quarto files are in the working directory
  knit(file, output = NULL) # You can specify the output file if needed
}

# Now you can proceed to generate the full Quarto report if needed
# Note: This assumes that the Quarto files are in the working directory
