options(repos = c(
  yihui = 'https://yihui.r-universe.dev',
  CRAN = 'https://cloud.r-project.org'
))

install.packages('knitr')

library(rmarkdown)
library(bookdown)
library(komadown)


tinytex::pdflatex('koma_tufte.tex')
tinytex::xelatex('koma_tufte.tex')
tinytex::lualatex('koma_tufte.tex')

update.packages(ask = FALSE, checkBuilt = TRUE)
tinytex::tlmgr_update()

bookdown::render_book("koma_tufte_2.Rmd")
