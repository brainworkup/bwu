# BWU ------------------------------------------------

# Update R packages and libraries -------------------------------------------

update.packages(ask = FALSE, checkBuilt = TRUE)

# if pak fails, reinstall from source

## Pre-built binaries

install.packages("pak", repos = sprintf(
  "https://r-lib.github.io/p/pak/stable/%s/%s/%s",
  .Platform$pkgType,
  R.Version()$os,
  R.Version()$arch
)) # stable, specific

## update User Library
update.packages(
  instlib = .libPaths()[[1L]],
  ask = FALSE,
  checkBuilt = TRUE
)

## Update System Library
### install most packages here
update.packages(
  instlib = .libPaths()[[2L]],
  ask = FALSE,
  checkBuilt = TRUE
)

## dependencies

devtools::install_deps(dependencies = TRUE)
usethis::use_package("data.table")
usethis::use_package("here")
usethis::use_package("readr")
devtools::document()

## Add files to .buildignore
usethis::use_build_ignore("_quarto.yml")
usethis::use_build_ignore("src/")
usethis::use_build_ignore("_freeze/")
usethis::use_build_ignore("README_files/")
usethis::use_build_ignore("bwu.qmd")
usethis::use_build_ignore("index.qmd")
usethis::use_build_ignore("README.html")

usethis::use_build_ignore(".quarto")
usethis::use_build_ignore("notes")
usethis::use_build_ignore(".builds.archived")

devtools::build_readme()

## renv

renv::update()

### pak

pak::lockfile_create(pkg = ".", lib = ".pak/library")

pak::lockfile_install(lockfile = "pkg.lock", lib = ".pak/library", update = TRUE)

remotes::install_github(c("ropensci/tabulizerjars", "ropensci/tabulizer"), INSTALL_opts = "--no-multiarch")

pak::pkg_install('ropensci/tabulizer')

## LaTeX

tinytex::tlmgr_update()

# other newer stuff ------------------------------------------------

render_report_ask(input = "pluck_wais4.Rmd", patient = "Lauren")

render_report_adult(input = "Lauren/Lauren.Rmd", patient = "Lauren")

render_report_adult(input = "Alejandra/Alejandra.Rmd", patient = "Alejandra")

wais4_co_pred <- predicted_score(x = 6.7, r = .5, m = 10)

stringi::stri_escape_unicode("‰")

# Update R packages and libraries -------------------------------------------

# sudo R CMD javareconf

## update User Library
update.packages(
  instlib = .libPaths()[[1L]],
  ask = FALSE,
  checkBuilt = TRUE
)

usethis::use_github_action_check_release(
  save_as = "R-CMD-check.yaml",
  ref = NULL,
  ignore = TRUE,
  open = FALSE
)

#$\text{\textperthousand}$

## LaTeX
  # Update/Install LaTeX packages -------------------------------------------

tinytex::tlmgr_update()

# install if dont exist
tinytex::tlmgr_install("txfonts")
tinytex::tlmgr_install("biblatex-apa")
tinytex::tlmgr_install("biblatex")
tinytex::tlmgr_install("koma-script")

tinytex::tlmgr_install("libertine")

\DeclareUnicodeCharacter{2030}{\forall}
U+2030
\permil from the package wasysym, works in both text mode as in math mode.
tinytex::tlmgr_update()
tinytex::reinstall_tinytex()
tinytex::install_tinytex()

update.packages(ask = FALSE, checkBuilt = TRUE)

renv::install("brainworkup/bwu")
renv::install("gadenbuie/xaringanExtra")
renv::install("r-lib/ymlthis")

## Install new packages using devtools
devtools::install_github(
  "brainworkup/bwu",
  lib = .libPaths()[[1L]],
  dependencies = TRUE,
  upgrade = "default",
  build = TRUE,
  force = TRUE
)

devtools::install_github(
  "brainworkup/bwu",
  lib = .libPaths()[[1L]],
  dependencies = TRUE,
  upgrade = "default",
  build = TRUE,
  force = TRUE
)

## PAK
## using PAK
pak::pkg_install("RCurl", dependencies = TRUE)

pak::pkg_install("tidyverse", dependencies = TRUE)
pak::pkg_install("yaml")

pak::pkg_install("brainworkup/bwu")
pak::pkg_install("tidyverse/tibble")

pak::pkg_install(c("knitr", "xfun"))

devtools::install_github("markfairbanks/tidytable")

# ************************
# devtools ----
# ************************

ut <- readRDS(here::here("data", "ut.rds"))
usethis::use_data(ut)
load("~/bwu/data/ut.rda")
tools::checkRdaFiles(here::here("data", "ut.rda"))

## Install new packages using remotes
# Enable this universe
options(repos = c(
  ropensci = 'https://ropensci.r-universe.dev',
  CRAN = 'https://cloud.r-project.org'))

remotes::install_github(
  c("ropensci/tabulizer", "ropensci/tabulizerjars"),
  lib = .libPaths()[[1L]],
  dependencies = TRUE,
  upgrade = TRUE,
  build = TRUE,
  force = TRUE
)

usethis::create_github_token()

usethis::use_r("age")
usethis::use_r("scores")
usethis::use_r("colors")

remotes::install_github(
  'yihui/xaringan',
  upgrade = TRUE,
  lib = .libPaths()[[1L]],
  dependencies = TRUE,
  build = TRUE,
  force = TRUE)

## Install new packages using CRAN
install.packages(
  c("tabulizer", "tabulizerjars"),
  lib = .libPaths()[[1L]],
  dependencies = TRUE,
  type = "source",
  upgrade = TRUE,
  build = TRUE,
  force = TRUE
)

renv::install("rJava", rebuild = TRUE)
renv::install("tabulizer", rebuild = TRUE)

# To remove duplicate packages
remove.packages(installed.packages() [duplicated(rownames(installed.packages())),1], lib = .libPaths()[.libPaths() != .Library])

paste(installed.packages() [duplicated(rownames(installed.packages())),1], lib = .libPaths()[.libPaths() != .Library])


# Edit startup ------------------------------------------------------------

# to open .Rprofile

usethis::edit_r_profile()
usethis::edit_r_environ()

file.edit("~/.Rprofile") # edit .Rprofile in HOME
file.edit(".Rprofile") # edit project specific .Rprofile

file.edit("~/.Renviron") # edit .Renviron in HOME
file.edit(".Renviron") # edit project specific .Renviron

file.edit("~/.R/Makevars")

pkgbuild::check_build_tools(debug = TRUE)

# Additional Notes --------------------------------------------------------

# important
getwd()
list.files()
read.table("file.csv", sep = ",", header = TRUE, na.strings = ".") # load any plain text file
# use args to see a functions arguments
args(lintr::default_linters)
args(rmarkdown::render)
function (input,
          output_format = NULL,
          output_file = NULL,
          output_dir = NULL,
          output_options = NULL,
          output_yaml = NULL,
          intermediates_dir = NULL,
          knit_root_dir = NULL,
          runtime = c("auto", "static", "shiny",
                      "shinyrmd", "shiny_prerendered"),
          clean = TRUE,
          params = NULL,
          knit_meta = NULL,
          envir = parent.frame(),
          run_pandoc = TRUE,
          quiet = FALSE,
          encoding = "UTF-8")
args(ggplot2::ggplot)
args(xaringan::inf_mr)
args(xaringan::infinite_moon_reader)

"Share/In/Ginn"

# Enable this universe
options(repos = c(
  rstudio = 'https://rstudio.r-universe.dev',
  CRAN = 'https://cloud.r-project.org'))

# Install some packages
install.packages(c('rmarkdown','revealjs'), lib = .libPaths()[[1L]])
install.packages(c('bookdown','htmltools'), lib = .libPaths()[[1L]])

# Enable this universe
options(repos = c(
  rlib = 'https://r-lib.r-universe.dev',
  CRAN = 'https://cloud.r-project.org'))

# Install some packages
install.packages('webshot2', lib = .libPaths()[[2L]], dependencies = TRUE)


```{r ncog-plot, results='asis'}
for (i in names(neurocog)) {
  cat('\n\n# Summary of the variable `', i, '`\n\n')
  x <- neurocog[, i]
}
```

# Tabulizer ----------------------------------------------------------

```{r}
out3 <- extract_text(nab_pdf, page = 3)
cat(out3, sep = "\n")
```

# r Java ------------------------------------------------------------------
name <- function(variables) {

}
Sys.setenv(JAVA_HOME = '/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home') Sys.getenv() Sys.getenv("JAVA_HOME")

Sys.setenv(JAVA_HOME = '/Library/Java/JavaVirtualMachines/temurin-8.jdk/Contents/Home')
%>%
# RStudio -----------------------------------------------------------------


# Character strings -------------------------------------------------------

as.character(data$MarkerName)
a <- strsplit(as.character(data$MarkerName),':')
result <- apply(do.call(rbind, a), MARGIN = 2, FUN = as.integer)

ncogL1status <- as.tibble(ncogL1status)
str(ncogL1status)
sapply(ncogL1status, class)

# Maybe import funky q-interactive csv file -------------------------------

read.table("file.csv", sep = ",", header = TRUE, na.strings = ".") # load any plain text file

# Make a data.frame from scratch ------------------------------------------

df <- data.frame(
  Panel = c("1KGP", "HRC", "TOPMed"),
  Samples = c(2504, 32470, 97256),
  Haplotypes = c(5008, 64940, 194512),
  Variants = c(49143605, 39635008, 308107085)
)

topf <- data.frame(
  raw_score = 60,
  score = 112
)

# Lookup tables -----------------------------------------------------------

## Compute percentile


```{r}
x <- table %>% mutate(z_score = ((score - 50) / 10))
probs <- c(2.6, 1.3, -0.1, 0.7, 3.3, 1.2, 2.6, 1)
```

```{r}
weighted.quantile <- function(x, probs, weights = NULL, type="Type7"){
  if(is.null(weights)){
    return(quantile(x, probs))
  }else if(type=="Harrell-Davis"){
    return(weighted.quantile.harrell.davis(x, probs, weights))
  }else{
    return(weighted.quantile.type7(x, probs, weights))
  }
}
```

```{r}
weighted.quantile(x = table$z_score, probs = probs)
```

```{r}
wquantile.generic <- function(x, probs, cdf.gen, weights = NULL) {
  if(is.null(weights)){
    return(quantile(x, probs = probs))
  }

  n <- length(x)
  if (any(is.na(weights)))
    weights <- rep(1 / n, n)
  nw <- sum(weights) / max(weights)

  indexes <- order(x)
  x <- x[indexes]
  weights <- weights[indexes]

  weights <- weights / sum(weights)
  cdf.probs <- cumsum(c(0, weights))

  sapply(probs, function(p) {
    cdf <- cdf.gen(nw, p)
    q <- cdf(cdf.probs)
    w <- tail(q, -1) - head(q, -1)
    sum(w * x)
  })
}
```


# knitr -------------------------------------------------------------------

library(knitr)
(f = system.file("examples", "knitr-minimal.Rnw", package = "knitr"))
knit(f)  # compile to tex

purl(f)  # tangle R code
purl(f, documentation = 0)  # extract R code only
purl(f, documentation = 2)  # also include documentation

unlink(c("knitr-minimal.tex", "knitr-minimal.R", "figure"), recursive = TRUE)

# BDI-2 -------------------------------------------------------------------


simple_map <- function(x) {
  out <- vector("list", length(x))
  for (i in seq_along(x)) {
    out[i] <- x[[i]]
  }
  out
}

```{r}
z <- (sqrt(18) - 2.48)/1.66
```
<-

  <-
---

<-
# Format table using Huxtable ---------------------------------------------

library(huxtable)
library(dplyr)
ht <- hux(df)
ht %>%
  set_all_padding(4) %>%
  set_outer_padding(0) %>%
  set_number_format(0) %>%
  set_bold(row = 1, col = everywhere) %>%
  set_bottom_border(row = 1, col = everywhere) %>%
  set_width(0.6) %>%
  set_caption("(ref:gwas-refs)") %>%
  set_position("wrapright") |>
  set_number_format(fmt_pretty())

# Tidyverse packages ------------------------------------------------------

# PDF convert -------------------------------------------------------------

tf <- tempfile(fileext = ".pdf")
download.file("https://rud.is/dl/unit42-ransomware-threat-report-2021.pdf", tf)

library(stringi)
library(pdftools)

l <- pdf_text(tf)

stri_split_lines(l[[7]])[[1]]

# see output in the two details blocks below

base::unlink(tf)

# try w leah
tf <- tempfile(fileext = ".pdf")
tf <- brio::read_file("/Users/joey/Dropbox (University of Southern California)/npsych_reports/2021/Tahay-Leah/Lh Ty 9yo eval mixed ld adhd asd-09609a6f-d73d-4dcd-a2b2-d04bf5acc1b7.pdf", tf)

readr::read_file("", tf)

library(stringi)
library(pdftools)

iq <- pdf_text("")

iq.1 <- stri_split_lines(iq[[15]])[[1]]
iq.1
# see output in the two details blocks below

unlnk(tf)

get_table <- function(url) {
  txt <- pdftools::pdf_text(url)
  p <- grep("score summarycondensed consolidated statements.{0,10}comprehensive income",
            txt,
            ignore.case = TRUE)[1]
  L <- tabulizer::extract_tables(url, pages = p)
  i <- which.max(lengths(L))
  data.frame(L[[i]])
}

gt <- get_table("https://rud.is/dl/unit42-ransomware-threat-report-2021.pdf")


get_table_pdf <- function(pdf) {
  txt <- pdftools::pdf_text(pdf)
  p <- grep("score summary",
            txt,
            ignore.case = TRUE)[1]
  L <- tabulizer::extract_tables(pdf, pages = p)
  i <- which.max(lengths(L))
  data.frame(L[[i]])
}

gt <- get_table("https://rud.is/dl/unit42-ransomware-threat-report-2021.pdf")

cog <- get_table_pdf("/Users/joey/Dropbox (University of Southern California)/npsych_reports/2021/Tahay-Leah/Lh Ty 9yo eval mixed ld adhd asd-09609a6f-d73d-4dcd-a2b2-d04bf5acc1b7.pdf")


txt <- pdf_text("http://arxiv.org/pdf/1406.4806.pdf")

# some tables
cat(txt[18])
cat(txt[19])


library(tidyverse)
library(tabulizer)

gti_table <- extract_tables(
  "http://visionofhumanity.org/app/uploads/2017/11/Global-Terrorism-Index-2017.pdf",
  output = "data.frame",
  pages = c(106, 106, 107, 107), # include pages twice to extract two tables per page
  area = list(
    c(182, 38, 787, 287),
    c(182, 298, 787, 543),
    c(78, 48, 781, 298),
    c(78, 308, 643, 558)
  ),
  guess = FALSE
)

gti_table_clean <- reduce(gti_table, bind_rows) %>% # bind elements of list to 1 df
  as_tibble() %>%
  filter(!(X %in% c("GTI RANK", ""))) %>% # remove rownames and empty rows
  rename(
    gti_rank = X,
    county = X.1,
    gti_score = X.2,
    change_score = CHANGE.IN
  ) %>%
  mutate_at(vars(gti_rank, gti_score, change_score), as.numeric) %>% # convert to numeric
  print()

```{r}
library(rio)
library(pdftools)
library(tabulizer)

pdf_file <- tabulizer::extract_tables("/Users/joey/Dropbox (University of Southern California)/npsych_reports/2021/Tahay-Leah/Lh Ty 9yo eval mixed ld adhd asd-09609a6f-d73d-4dcd-a2b2-d04bf5acc1b7.pdf")
```


gti_table <- extract_tables(
  "/Users/joey/Dropbox (University of Southern California)/npsych_reports/2021/Tahay-Leah/Lh Ty 9yo eval mixed ld adhd asd-09609a6f-d73d-4dcd-a2b2-d04bf5acc1b7.pdf",
  output = "data.frame",
  pages = c(16, 19, 15, 22, 23), # include pages twice to extract two tables per page
  area = list(
    c(175, 50, 272, 562),
    c(196, 50, 372, 562),
    c(162, 50, 392, 562),
    c(151, 50, 263, 562),
    c(156,50,357,562)
  ),
  guess = FALSE
)

gti_table_clean <- reduce(gti_table, bind_rows) %>% # bind elements of list to 1 df
  as_tibble() %>%
  filter(!(X %in% c("GTI RANK", ""))) %>% # remove rownames and empty rows
  rename(
    gti_rank = X,
    county = X.1,
    gti_score = X.2,
    change_score = CHANGE.IN
  ) %>%
  mutate_at(vars(gti_rank, gti_score, change_score), as.numeric) %>% # convert to numeric
  print()

area1 <- list(c(175, 50, 272, 562))
## Change "pages" to the specific page for the specific patient
wisc5_tb1 <- tabulizer::extract_tables(
  cognitive.pdf,
  pages = 16,
  guess = FALSE,
  method = "stream", # check this
  output = "matrix",
  outdir = out_dir_csv,
  area = area1
)



# Extract Functions -------------------------------------------------------

pluck_locate_areas <- function(pdf, pages = NULL) {
  area <- locate_areas(
    file = pdf,
    pages = pages)
}

```{r}
table1 <- table
table2 <- table
table3 <- table
table4 <- table
```

```{r}
# Row bind
measure <- bind_rows(table1, table2, table3, table4)
measure <- tibble::as_tibble(measure)
# Convert "-", "NA", "", "--" etc to NA
measure <- dplyr::na_if(measure, "")
measure <- dplyr::na_if(measure, "NA")
# Convert char to numeric
to_double <- c("raw_score", "score", "percentile")
measure <- measure |> hablar::convert(dbl(all_of(to_double)))
## select variables
keep <- c("scale", "raw_score", "score", "percentile", "absort")
measure <- measure |> dplyr::select(all_of(keep))
```

```{r}
# function to add/mutate columns
gpluck_make_columns <- function(
    measure = measure,
    range = NA,
    test,
    test_name,
    domain = c(
      "Intelligence",
      "Academic Skills",
      "Verbal/Language",
      "Visual Perception/Construction",
      "Attention/Executive",
      "Memory",
      "Motor",
      "Social Cognition",
      "Behavioral/Emotional/Social"
    ),
    subdomain = NA,
    narrow = NA,
    test_type = c(
      "npsych_test",
      "rating_scale_self",
      "rating_scale_parent",
      "rating_scale_teacher"
    ),
    score_type = c(
      "standard_score",
      "t_score",
      "z_score",
      "scaled_score",
      "raw_score",
      "percentile"),
    timed = c(
      "Timed",
      "Untimed",
      NA),
    verbal = c(
      "Verbal",
      "Nonverbal",
      "Verbal/Nonverbal",
      NA),
    pass = c(
      "Attention",
      "Planning",
      "Sequential",
      "Simultaneous",
      NA))  {

  measure <-
    mutate(
      measure,
      range = range,
      test = test,
      test_name = test_name,
      domain = domain,
      subdomain = subdomain,
      narrow = narrow,
      test_type = test_type,
      score_type = score_type,
      timed = timed,
      verbal = verbal,
      pass = pass,
      absort2 = paste0(test_name, "_", 01:nrow(measure)),
      description = "a measure of..."
    )
}
```

```{r}
## Create score/classification ranges and subdomain categories
gpluck_make_score_ranges <- function(measure, percentile = percentile, range = range) {
  measure <-
    measure |>
    mutate(
      range = case_when(
        percentile >= 98 ~ "Exceptionally High",
        percentile %in% 91:97 ~ "Above Average",
        percentile %in% 75:90 ~ "High-Average",
        percentile %in% 25:74 ~ "Average",
        percentile %in% 9:24 ~ "Low-Average",
        percentile %in% 2:8 ~ "Below Average",
        percentile < 2 ~ "Exceptionally Low",
        TRUE ~ as.character(range)
      )
    )
}
```

```{r}
cvlt3 <- gpluck_create_score_ranges(measure = cvlt3)
```

```{r}
# make_domain_labels
measure <-
  measure |>
  mutate(
    subdomain = case_when(
      scale == "Attention Index" ~ "Broad Attention",
      scale == "Orientation" ~ "Orientation",
      scale == "Orientation to Self" ~ "Orientation",
      scale == "Orientation to Time" ~ "Orientation",
      scale == "Orientation to Place" ~ "Orientation",
      scale == "Orientation to Situation" ~ "Orientation",
      scale == "Digits Forward" ~ "Auditory/Verbal Attention",
      scale == "Digits Forward Longest Span" ~ "Auditory/Verbal Attention",
      scale == "Digits Backward" ~ "Auditory/Verbal Working Memory",
      scale == "Digits Backward Longest Span" ~ "Auditory/Verbal Working Memory",
      scale == "Numbers & Letters Part A Speed" ~ "Processing Speed",
      scale == "Numbers & Letters Part A Errors" ~ "Response Monitoring",
      scale == "Numbers & Letters Part A Efficiency" ~ "Selective Attention",
      scale == "Numbers & Letters Part B Efficiency" ~ "Selective Attention",
      scale == "Numbers & Letters Part C Efficiency" ~ "Selective Attention",
      scale == "Numbers & Letters Part D Efficiency" ~ "Selective Attention",
      scale == "Numbers & Letters Part D Disruption" ~ "Cognitive Flexibility",
      scale == "Dots" ~ "Visual/Nonverbal Working Memory",
      scale == "Driving Scenes" ~ "Visual/Nonverbal Attention",
      TRUE ~ as.character(subdomain)
    )
  )
```


# Code Runner vscode ------------------------------------------------------

{
  "name": "r",
  "displayName": "%displayName%",
  "description": "%description%",
  "version": "1.0.0",
  "publisher": "vscode",
  "license": "MIT",
  "engines": {
    "vscode": "*"
  },
  "scripts": {
    "update-grammar": "node ../node_modules/vscode-grammar-updater/bin Ikuyadeu/vscode-R syntax/r.json ./syntaxes/r.tmLanguage.json"
  },
  "contributes": {
    "languages": [
      {
        "id": "r",
        "extensions": [
          ".r",
          ".rhistory",
          ".rprofile",
          ".rt"
        ],
        "aliases": [
          "R",
          "r"
        ],
        "configuration": "./language-configuration.json"
      }
    ],
    "grammars": [
      {
        "language": "r",
        "scopeName": "source.r",
        "path": "./syntaxes/r.tmLanguage.json"
      }
    ]
  },
  "repository": {
    "type": "git",
    "url": "https://github.com/microsoft/vscode.git"
  }
}

dependencies <- c(
  "knitr",
  "rmarkdown",
  "here",
  "fs",
  "miniUI",
  "magrittr",
  "htmltools",
  "purrr",
  "rlang",
  "rstudioapi",
  "png",
  "rJava",
  "stats",
  "dplyr",
  "stringr",
  "shiny",
  "usethis",
  "tabulizer",
  "bookdown"
)
