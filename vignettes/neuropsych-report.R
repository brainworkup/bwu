params <-
list(first_name = "Biggie", last_name = "Smalls", mrn = "000000000", 
    dob = structure(19062, class = "Date"), sex = "Male", race = "White/Caucasian", 
    hand = "Right", educ = "Dropped outta high school", doe1 = structure(19062, class = "Date"), 
    doe2 = structure(19062, class = "Date"), doe3 = structure(19062, class = "Date"), 
    doe4 = structure(19062, class = "Date"), he_she = "he", his_her = "his", 
    him_her = "him", he_she_cap = "He", his_her_cap = "His", 
    him_her_cap = "Him", dx1 = "ADHD", dx2 = "depression", refdoc = "Dr Dre")

## ----patient, include=F-------------------------------------------------------
patient <- params$first_name
pronoun <- params$his_her

## ---- setup, include = FALSE, results='hide', warning=FALSE-------------------
library(knitr)
knitr::knit_hooks$set(crop = knitr::hook_pdfcrop)
knitr::knit_hooks$set(optipng = knitr::hook_optipng)

# Fix subfigs for rmarkdown -> latex
if (identical(knitr:::pandoc_to(), "latex")) {
  knitr::knit_hooks$set(plot = knitr::hook_plot_tex)
}

knitr::opts_chunk$set(
  echo = FALSE,
  dev = c("CairoPNG", "CairoPDF"),
  dev.args = list(pointsize = 8),
  crop = TRUE,
  par = TRUE,
  fig.width = 5,
  fig.height = 3,
  dpi = 300,
  fig.pos = "!ht",
  root.dir = normalizePath("./"),
  cache = FALSE,
  cache.path = "./cache/report-",
  # Code block options
  eval = TRUE,
  include = TRUE,
  message = FALSE,
  warning = FALSE,
  results = "asis",
  error = TRUE
)
knitr::opts_knit$set(width = 50)
options(digits = 1, warnPartialMatchArgs = FALSE)
options(knitr.kable.NA = "--")

## -----------------------------------------------------------------------------
knitr::knit_engines$set(marginfigure = function(options) {
  options$type <- "marginfigure"
  eng_block <- knitr::knit_engines$get("block")
  eng_block(options)
})

