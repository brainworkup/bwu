# Extract KTEA3 Tables

## Setup

# load libraries
library(tabulizer)
library(rJava)
library(tidyverse)
library(miniUI)
library(here)
library(pdftools)
library(fs)
library(data.table)
library(magrittr)
library(kableExtra)
library(formattable)
library(sparkline)
library(DT)
library(ggiraph)

## set file path
## update this in new project directroy
path = here::here("data-raw", "neurocog-raw")
(file_names <- dir(path, pattern = ".pdf", full.names = TRUE))
cognitive.pdf <- file_names[2]

# basc3_prs_child.pdf <- file_names[]
# basc3_srp_child.pdf <- file_names[]
# brown_parent.pdf <- file_names[]

patient <- "kb"

# Create directory
dir_create(here::here("04_DTF", "kb", "csv"))

# Create link to directory
out_dir = here::here("04_DTF", "kb", "csv")

## Core Composite Score Summary Table
## Supplemental Composite Score Summary Table
## Change "pages" to the specific page for the specific patient
ktea3_tb1 <- extract_tables(
  cognitive.pdf,
  pages = 2,
  guess = TRUE,
  method = "lattice",
  output = "matrix",
  outdir = out_dir,
  area = list(c(178.647,16.343,391.317,596.213))
)
# 173,15,392,596 orig
# kol, lattice, 178.647,16.343,391.317,596.213
ktea3_tb1 <- as.data.frame(ktea3_tb1)

ktea3_tb1 <- setnames(ktea3_tb1, c("scale", "raw_score", "sum_subtest", "score", "ci_95", "percentile", "category", "age_equiv", "gsv"))

## delete first row and then rename
ktea3_tb1 <- as_tibble(ktea3_tb1)[-1, ]

ktea3_tb1[1,1] <- c("Academic Skills Battery (ASB) Composite")

## Supplemental Composite Score Summary Table
## change "pages"
ktea3_tb2 <- extract_tables(
  cognitive.pdf,
  pages = 3,
  guess = TRUE,
  method = "lattice",
  output = "matrix",
  outdir = out_dir,
  area = list(c(177.891,17.108,621.591,594.683))
)
#area = list(c(172,15,611,595))
# kb 177.891,17.108,621.591,594.683
# convert to tibble
ktea3_tb2 <- as.data.frame(ktea3_tb2)

# set names
ktea3_tb2 <- setnames(ktea3_tb2, c("scale", "raw_score", "sum_subtest", "score", "ci_95", "percentile", "category", "age_equiv", "gsv"))

# Combine tables
ktea3 <- dplyr::bind_rows(ktea3_tb1,ktea3_tb2)
ktea3 <- as_tibble(ktea3)

# Convert "-" to NA
ktea3 <- dplyr::na_if(ktea3, "-")

# Convert char to numeric
library(hablar)
ktea3 <- ktea3 %>% convert(dbl(percentile))

# Add/mutate columns
ktea3 <- dplyr::mutate(ktea3, range = "", test = "ktea3", test_name = "KTEA-3", domain = "", subdomain = "", subdomain_narrow = "", domain_broad = "Academics", domain_test = "", test_type = "npsych_test", score_type = "standard_score", timed = "", absort = paste0("KTEA3_",01:49))

## Create score/classification ranges, domain categories, and test descriptions
ktea3 <- ktea3 %>%
  mutate(
    range = case_when(
      percentile >= 98 ~ "Exceptionally high score",
      percentile %in% 91:97 ~ "Above average score",
      percentile %in% 75:90 ~ "High average score",
      percentile %in% 25:74 ~ "Average score",
      percentile %in% 9:24 ~ "Low average score",
      percentile %in% 2:8 ~ "Below average score",
      percentile < 2 ~ "Exceptionally low score",
      TRUE ~ as.character(range)
    )
  ) %>%
  mutate(
    domain_test = case_when(
      ktea3$scale == "Nonsense Word Decoding" ~ "Decoding",
      ktea3$scale == "Academic Fluency Composite" ~ "Academic Fluency",
      ktea3$scale == "Writing Fluency" ~ "Academic Fluency",
      ktea3$scale == "Math Fluency" ~ "Academic Fluency",
      ktea3$scale == "Decoding Fluency" ~ "Academic Fluency",
      TRUE ~ as.character(domain_test)
    )
  ) %>%
  mutate(
    domain = case_when(
      ktea3$scale == "Academic Skills Battery (ASB) Composite" ~ "Academic Skills",
      ktea3$scale == "Nonsense Word Decoding" ~ "Academic Skills",
      ktea3$scale == "Academic Fluency Composite" ~ "Academic Skills",
      ktea3$scale == "Writing Fluency" ~ "Academic Skills",
      ktea3$scale == "Math Fluency" ~ "Academic Skills",
      ktea3$scale == "Decoding Fluency" ~ "Academic Skills",
      ktea3$scale == "Math Concepts & Applications" ~ "Academic Skills",
      ktea3$scale == "Letter & Word Recognition" ~ "Academic Skills",
      ktea3$scale == "Written Expression" ~ "Academic Skills",
      ktea3$scale == "Math Computation" ~ "Academic Skills",
      ktea3$scale == "Spelling" ~ "Academic Skills",
      ktea3$scale == "Reading Comprehension" ~ "Academic Skills",
      ktea3$scale == "Reading Composite" ~ "Academic Skills",
      ktea3$scale == "Math Composite" ~ "Academic Skills",
      ktea3$scale == "Written Language Composite" ~ "Academic Skills",
      ktea3$scale == "Sound-Symbol Composite" ~ "Academic Skills",
      ktea3$scale == "Phonological Processing" ~ "Academic Skills",
      ktea3$scale == "Decoding Composite" ~ "Academic Skills",
      ktea3$scale == "Reading Fluency Composite" ~ "Academic Skills",
      ktea3$scale == "Silent Reading Fluency" ~ "Academic Skills",
      ktea3$scale == "Word Recognition Fluency" ~ "Academic Skills",
      ktea3$scale == "Reading Understanding Composite" ~ "Academic Skills",
      ktea3$scale == "Reading Vocabulary" ~ "Academic Skills",
      ktea3$scale == "Oral Language Composite" ~ "Verbal/Language",
      ktea3$scale == "Associational Fluency" ~ "Verbal/Language",
      ktea3$scale == "Listening Comprehension" ~ "Verbal/Language",
      ktea3$scale == "Oral Expression" ~ "Verbal/Language",
      ktea3$scale == "Oral Fluency Composite" ~ "Verbal/Language",
      ktea3$scale == "Object Naming Facility" ~ "Academic Skills",
      ktea3$scale == "Comprehension Composite" ~ "Verbal/Language",
      ktea3$scale == "Listening Comprehension" ~ "Verbal/Language",
      ktea3$scale == "Expression Composite" ~ "Verbal/Language",
      ktea3$scale == "Letter Naming Facility" ~ "Academic Skills",
      ktea3$scale == "Orthographic Processing Composite" ~ "Academic Skills",
      TRUE ~ as.character(domain)
    )
  ) %>%
  mutate(
    subdomain = case_when(
      ktea3$scale == "Academic Skills Battery (ASB) Composite" ~ "Broad Achievement",
      ktea3$scale == "Nonsense Word Decoding" ~ "Reading",
      ktea3$scale == "Academic Fluency Composite" ~ "Academic Fluency",
      ktea3$scale == "Writing Fluency" ~ "Writing",
      ktea3$scale == "Math Fluency" ~ "Math",
      ktea3$scale == "Decoding Fluency" ~ "Reading",
      ktea3$scale == "Math Concepts & Applications" ~ "Math",
      ktea3$scale == "Letter & Word Recognition" ~ "Reading",
      ktea3$scale == "Written Expression" ~ "Writing",
      ktea3$scale == "Math Computation" ~ "Math",
      ktea3$scale == "Spelling" ~ "Writing",
      ktea3$scale == "Reading Comprehension" ~ "Reading",
      ktea3$scale == "Reading Composite" ~ "Reading",
      ktea3$scale == "Math Composite" ~ "Math",
      ktea3$scale == "Written Language Composite" ~ "Writing",
      ktea3$scale == "Sound-Symbol Composite" ~ "Reading",
      ktea3$scale == "Phonological Processing" ~ "Receptive Language",
      ktea3$scale == "Decoding Composite" ~ "Reading",
      ktea3$scale == "Reading Fluency Composite" ~ "Reading",
      ktea3$scale == "Silent Reading Fluency" ~ "Reading",
      ktea3$scale == "Word Recognition Fluency" ~ "Reading",
      ktea3$scale == "Reading Understanding Composite" ~ "Reading",
      ktea3$scale == "Reading Vocabulary" ~ "Reading",
      ktea3$scale == "Oral Language Composite" ~ "Broad Language",
      ktea3$scale == "Associational Fluency" ~ "Expressive Language",
      ktea3$scale == "Listening Comprehension" ~ "Receptive Language",
      ktea3$scale == "Oral Expression" ~ "Expressive Language",
      ktea3$scale == "Oral Fluency Composite" ~ "Expressive Language",
      ktea3$scale == "Object Naming Facility" ~ "Reading",
      ktea3$scale == "Comprehension Composite" ~ "Receptive Language",
      ktea3$scale == "Listening Comprehension" ~ "Receptive Language",
      ktea3$scale == "Expression Composite" ~ "Expressive Language",
      ktea3$scale == "Letter Naming Facility" ~ "Reading",
      ktea3$scale == "Orthographic Processing Composite" ~ "Spelling",
      TRUE ~ as.character(subdomain)
    )
  ) %>%
  mutate(
    subdomain_narrow = case_when(
      ktea3$scale == "Academic Skills Battery (ASB) Composite" ~ "Academic Skills",
      ktea3$scale == "Nonsense Word Decoding" ~ "Reading",
      ktea3$scale == "Academic Fluency Composite" ~ "Academic Fluency",
      ktea3$scale == "Writing Fluency" ~ "Writing",
      ktea3$scale == "Math Fluency" ~ "Math",
      ktea3$scale == "Decoding Fluency" ~ "Reading",
      ktea3$scale == "Math Concepts & Applications" ~ "Math",
      ktea3$scale == "Letter & Word Recognition" ~ "Reading",
      ktea3$scale == "Written Expression" ~ "Writing",
      ktea3$scale == "Math Computation" ~ "Math",
      ktea3$scale == "Spelling" ~ "Writing",
      ktea3$scale == "Reading Comprehension" ~ "Reading",
      ktea3$scale == "Reading Composite" ~ "Reading",
      ktea3$scale == "Math Composite" ~ "Math",
      ktea3$scale == "Written Language Composite" ~ "Writing",
      ktea3$scale == "Sound-Symbol Composite" ~ "Reading",
      ktea3$scale == "Phonological Processing" ~ "Receptive Language",
      ktea3$scale == "Decoding Composite" ~ "Reading",
      ktea3$scale == "Reading Fluency Composite" ~ "Reading",
      ktea3$scale == "Silent Reading Fluency" ~ "Reading",
      ktea3$scale == "Word Recognition Fluency" ~ "Reading",
      ktea3$scale == "Reading Understanding Composite" ~ "Reading",
      ktea3$scale == "Reading Vocabulary" ~ "Reading",
      ktea3$scale == "Oral Language Composite" ~ "Broad Language",
      ktea3$scale == "Associational Fluency" ~ "Expressive Language",
      ktea3$scale == "Listening Comprehension" ~ "Receptive Language",
      ktea3$scale == "Oral Expression" ~ "Expressive Language",
      ktea3$scale == "Oral Fluency Composite" ~ "Expressive Language",
      ktea3$scale == "Object Naming Facility" ~ "Reading",
      ktea3$scale == "Comprehension Composite" ~ "Receptive Language",
      ktea3$scale == "Listening Comprehension" ~ "Receptive Language",
      ktea3$scale == "Expression Composite" ~ "Expressive Language",
      ktea3$scale == "Letter Naming Facility" ~ "Reading",
      ktea3$scale == "Orthographic Processing Composite" ~ "Spelling",
      TRUE ~ as.character(subdomain_narrow)
    )
  ) %>%
  mutate(
    timed = case_when(
      ktea3$scale == "Nonsense Word Decoding" ~ "FALSE",
      ktea3$scale == "Academic Fluency Composite" ~ "TRUE",
      ktea3$scale == "Writing Fluency" ~ "TRUE",
      ktea3$scale == "Math Fluency" ~ "TRUE",
      ktea3$scale == "Decoding Fluency" ~ "TRUE",
      ktea3$scale == "Academic Skills Battery (ASB) Composite" ~ "FALSE",
      ktea3$scale == "Math Concepts & Applications" ~ "FALSE",
      ktea3$scale == "Letter & Word Recognition" ~ "FALSE",
      ktea3$scale == "Written Expression" ~ "FALSE",
      ktea3$scale == "Math Computation" ~ "FALSE",
      ktea3$scale == "Spelling" ~ "FALSE",
      ktea3$scale == "Reading Comprehension" ~ "FALSE",
      ktea3$scale == "Reading Composite" ~ "FALSE",
      ktea3$scale == "Math Composite" ~ "FALSE",
      ktea3$scale == "Written Language Composite" ~ "FALSE",
      ktea3$scale == "Sound-Symbol Composite" ~ "FALSE",
      ktea3$scale == "Phonological Processing" ~ "FALSE",
      ktea3$scale == "Decoding Composite" ~ "FALSE",
      ktea3$scale == "Reading Fluency Composite" ~ "TRUE",
      ktea3$scale == "Silent Reading Fluency" ~ "TRUE",
      ktea3$scale == "Word Recognition Fluency" ~ "TRUE",
      ktea3$scale == "Reading Understanding Composite" ~ "FALSE",
      ktea3$scale == "Reading Vocabulary" ~ "FALSE",
      ktea3$scale == "Oral Language Composite" ~ "FALSE",
      ktea3$scale == "Associational Fluency" ~ "FALSE",
      ktea3$scale == "Listening Comprehension" ~ "FALSE",
      ktea3$scale == "Oral Expression" ~ "TRUE",
      ktea3$scale == "Oral Fluency Composite" ~ "FALSE",
      ktea3$scale == "Object Naming Facility" ~ "TRUE",
      ktea3$scale == "Comprehension Composite" ~ "FALSE",
      ktea3$scale == "Listening Comprehension" ~ "FALSE",
      ktea3$scale == "Expression Composite" ~ "FALSE",
      ktea3$scale == "Letter Naming Facility" ~ "TRUE",
      ktea3$scale == "Orthographic Processing Composite" ~ "FALSE",
      TRUE ~ as.character(timed)
    ) %>%
  mutate(
    score_type = case_when(
      ktea3$scale == "Nonsense Word Decoding" ~ "standard_score",
      ktea3$scale == "Academic Fluency Composite" ~ "composite_score",
      ktea3$scale == "Writing Fluency" ~ "standard_score",
      ktea3$scale == "Math Fluency" ~ "standard_score",
      ktea3$scale == "Decoding Fluency" ~ "standard_score",
      ktea3$scale == "Academic Skills Battery (ASB) Composite" ~ "composite_score",
      ktea3$scale == "Math Concepts & Applications" ~ "standard_score",
      ktea3$scale == "Letter & Word Recognition" ~ "standard_score",
      ktea3$scale == "Written Expression" ~ "standard_score",
      ktea3$scale == "Math Computation" ~ "standard_score",
      ktea3$scale == "Spelling" ~ "standard_score",
      ktea3$scale == "Reading Comprehension" ~ "standard_score",
      ktea3$scale == "Reading Composite" ~ "composite_score",
      ktea3$scale == "Math Composite" ~ "composite_score",
      ktea3$scale == "Written Language Composite" ~ "composite_score",
      ktea3$scale == "Sound-Symbol Composite" ~ "composite_score",
      ktea3$scale == "Phonological Processing" ~ "standard_score",
      ktea3$scale == "Decoding Composite" ~ "composite_score",
      ktea3$scale == "Reading Fluency Composite" ~ "TRUE",
      ktea3$scale == "Silent Reading Fluency" ~ "standard_score",
      ktea3$scale == "Word Recognition Fluency" ~ "standard_score",
      ktea3$scale == "Reading Understanding Composite" ~ "composite_score",
      ktea3$scale == "Reading Vocabulary" ~ "standard_score",
      ktea3$scale == "Oral Language Composite" ~ "composite_score",
      ktea3$scale == "Associational Fluency" ~ "standard_score",
      ktea3$scale == "Listening Comprehension" ~ "standard_score",
      ktea3$scale == "Oral Expression" ~ "standard_score",
      ktea3$scale == "Oral Fluency Composite" ~ "composite_score",
      ktea3$scale == "Object Naming Facility" ~ "standard_score",
      ktea3$scale == "Comprehension Composite" ~ "composite_score",
      ktea3$scale == "Listening Comprehension" ~ "standard_score",
      ktea3$scale == "Expression Composite" ~ "composite_score",
      ktea3$scale == "Letter Naming Facility" ~ "standard_score",
      ktea3$scale == "Orthographic Processing Composite" ~ "composite_score",
      TRUE ~ as.character(score_type)
    ) 
  )

ktea3 <- ktea3 %>% select(-sum_subtest, -category, -age_equiv, -gsv)

## write out final csv
readr::write_csv(ktea3, here("04_DTF", "kb", "csv", "ktea3.csv"), col_names = TRUE, na = "")

rm("ktea3_tb1","ktea3_tb2")
