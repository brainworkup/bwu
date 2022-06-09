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

