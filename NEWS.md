---
output:
  html_document:
    fig_caption: yes
    keep_md: yes
    toc: yes
    highlight: pygments
    theme: flatly
    number_sections: yes
  pdf_document:
    fig_caption: yes
    latex_engine: xelatex
    keep_tex: yes
---

## bwu 1.0.0.9000 (UNRELEASED)

-   updated to R 4.2

## bwu 1.0.0.9001

-   updated wais4 pluck .Rmd file

## bwu 1.0.1.9000

-   fixed emotion.R

-   changed data import back to readr

## bwu 1.0.2.9000

-   added mmpi3

-   deleted/cleaned up extra knitr::readchunk code blocks

## bwu 1.1.0.9000

-   changed skeleton yaml header to use "eval" as a yes/no variable

-   deleted extra R functions (eg marginnote, sans serif)

-   many other tweaks

-   added "knit with date" function for knitr button in Rstudio

## bwu 1.1.0.9001

-   made more chunks cacheable

-   updated the renv paths/workspace

## bwu 1.1.0.9002

-   updated/changed cefi.Rmd and caars.Rmd to make "glue" for each score

## bwu 1.1.0.9003

-   added read_npsych function to glue non-PDF tables together
-   updated .csv files in skeleton (topf, rcft, etc)
-   added pluck-test.Rmd for topf, rocf, examiner, pegboard

## bwu 1.1.1.9000

-   changed read_npsych.R to read_npsych_csv.R
-   added pluck_npsych_csv.Rmd
-   changed version
-   added t2z2p function to convert t-scores to z-scores to percentiles

## bwu 1.1.1.9001

-   recoded t2z2p function to more inclusive

## bwu 1.1.1.9002

-   gpluck_t2z2p works!
-   also added pluck_npsych_csv.Rmd

## bwu 1.1.1.9003

-   fixed .md files
-   fixed pluck_npsych_csv.Rmd

## bwu 0.1.1.9004

-   did not mean to issue a "1.x" release; backtracking now

## bwu 0.1.1.9005

-   fixed a bunch of bugs, but not sure if they are stable fixes yet
-   most bugs were in pluck .rmd files
-   also fixed skeleton (minor)

## bwu 0.1.2.9000

-   changed name of nse, sirf, etc
-   many other tweaks

## bwu 0.1.2.9001

-   changed and/or fixed several .Rmd and .md and .R files.

## bwu 0.1.2.9002

-   added datasets for ut, letters, categories, pegboard, rocft as .rds files in "inst/extdata"

## bwu 0.1.2.9003

-   switching to tidytable vs tidyverse

## bwu 0.1.2.9004

-   fixed dotplot; tried to change theme

-   added 'plant_neuropsych' Rmd to create table for individual scores/tests

-   added new function to better compute missing percentiles and ranges

## bwu 0.1.2.9005

-   changed names from "pluck_npsych_csv.Rmd" to "pluck_csv.Rmd"
-   other fixes

## bwu 0.1.2.9006

-   would not compile

## bwu 0.1.2.9007

-   created dev branch to fix problems w dplyr and tidytable

## bwu 0.1.2.9008

-   using quarto for nse 1

## bwu 0.1.2.9009

-   checking

## bwu 0.0.0.9013

-   Big change back to 0.0.1.0013 version

## bwu 0.0.0.9014

-   Trying to fix bugs in .Rmd files
-   This includes switching to data.table and data.frame from tibble

## bwu 0.0.1.9000

-   Added function to incoporate index-scores from Excel neuropsych app

## bwu 0.0.1.9001

-   Added TMT scoring function

## bwu 0.0.1.9002

-   switched to pak for package management
-   creating a new quarto site

## bwu 0.0.1.9003

## bwu 0.0.1.9004

-   Many updates for Feedback slide

## bwu 0.0.1.9005

-   Added validity indicators

## bwu 0.0.2.9000

-   Enough changes to strucutre for updated version

## bwu 0.0.2.9001

-   Added way to extract NSE text from Otter.AI

## bwu 0.0.3.9000

-   used sinew to format all functions

## bwu 0.0.4.9001

-   update

## 0.0.1.9000

## 0.0.2.9001

## 0.0.3.9000

-   wasn't great

## 0.0.4.9000

-   ADULT+CHILD templates, based more off tufte

## bwu 0.0.1.9000

-   Back to 0.0.1.9000

## bwu 0.0.1.9003

-   Updating a bunch of files etc

## bwu 0.0.1.9004

-   using bwu to write reports temporarily
-   updated pluck_caars, pai

## bwu 0.0.1.9000

-   removed tabulapdf for tabulapdf
