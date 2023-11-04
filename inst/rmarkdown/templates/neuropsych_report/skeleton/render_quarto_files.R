# Load the necessary library
library(purrr)

Sys.setenv(PATIENT = "Ashish", RETURN_PLOT = TRUE)
patient <- Sys.getenv("PATIENT")
return_plot <- Sys.getenv("RETURN_PLOT")

# Patient file
patient_file <- "Biggie.qmd"

# Create a vector of file names
file_names <- c(
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

# Create a list of parameters
params <- list(
  patient = "Biggie",
  first_name = "Biggie",
  last_name = "Smalls",
  mrn = ,
  dob = ,
  doe1 = ,
  doe2 = ,
  doe3 = ,
  sex = "male",
  sex_cap = "Male",
  age = 31,
  education = 17,
  handedness = "right",
  he_she = "he",
  he_she_cap = "He",
  his_her = "his",
  his_her_cap = "His",
  him_her = "him",
  him_her_cap = "Him",
  dx1 = "attention-deficit/hyperactivity disorder (ADHD)",
  dx2 = "anxiety",
  dx3 = "depression",
  referral = "",
  observer = "",
  observer_relation = "brother"
)

# Use `walk` to loop through each file and run `quarto_render`
walk(file_names, ~ quarto::quarto_render(
  input = .,
  execute_params = params
))

Sys.setenv(RETURN_PLOT = FALSE)
return_plot <- Sys.getenv("RETURN_PLOT")

# Maybe before this try to render the project
# Render the report
quarto::quarto_render(
  input = patient_file,
  execute_params = params
)

# If need to rerender individual domains
iq <- "_02-01_iq.qmd"
academics <- "_02-02_academics.qmd"
verbal <- "_02-03_verbal.qmd"
spatial <- "_02-04_spatial.qmd"
executive <- "_02-05_executive.qmd"
memory <- "_02-06_memory.qmd"
motor <- "_02-07_motor.qmd"
social <- "_02-08_social.qmd"
adhd <- "_02-09_adhd.qmd"
emotion <- "_02-10_emotion.qmd"
adaptive <- "_02-11_adaptive.qmd"
sirf <- "_03-00_sirf.qmd"

quarto::quarto_render(
  input = verbal,
  execute_params = params
)

quarto::quarto_render(
  input = spatial,
  execute_params = params
)

quarto::quarto_render(
  input = executive,
  execute_params = params
)

quarto::quarto_render(
  input = memory,
  execute_params = params
)

quarto::quarto_render(
  input = adhd,
  execute_params = params
)

quarto::quarto_render(
  input = emotion,
  execute_params = params
)
