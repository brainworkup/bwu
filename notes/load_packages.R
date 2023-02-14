# Load libraries ----------------------------------------------------------
## brainworkup (bwu)
library(bwu)
## knitr
library(knitr)
library(tinytex)
library(xfun)
# startup
library(here)
library(fs)
library(tufte)
library(shiny)
library(miniUI)
library(rmarkdown)
library(bookdown)
library(ymlthis)
## tidyverse
library(tidyverse)
library(gt)
library(kableExtra)
## strings
library(glue)
library(gluedown)
# PDF scraping
library(tabulizer)
library(tabulizerjars)
library(rJava)
library(pdftools)
library(pdftables)
## presentations
library(xaringan)
library(xaringanthemer)
library(xaringanExtra)
## fonts
library(ascii)
library(gfonts)
library(showtext) # {showtext} for custom fonts
library(concaveman)
library(extrafont)
## ggplot2/general plotting
library(grid) # {grid} for creating graphical objects
library(gridExtra) # {gridExtra} for additional functions for “grid” graphics
library(cowplot) # {cowplot} for composing ggplots
library(ggridges) # {ggridges} for ridge plots
library(GGally)
library(ggsci) # {ggsci} for nice color palettes
library(ggthemes) # {ggthemes} for additional themes
library(patchwork) # {patchwork} for multi-panel plots
library(ggforce) # {ggforce} for sina plots and other cool stuff
library(ggrepel) # {ggrepel} for nice text labeling
library(ggtext) # {ggtext} for advanced text rendering
library(ggdist)
library(ggdark) # {ggdark} for themes and inverting colors
library(highcharter) # Drilldown
library(scales)
## packages/tools/etc
library(devtools)
library(remotes)
## rmarkdown
library(blogdown)
library(pagedown)
library(komadown)
# ## .Rmd templates
library(tint)
# library(hrbrthemes)
library(distill)
library(linl)
# library(rmdformats)
## C++
library(Rcpp)
## formatting
library(printr)
library(formatR)
## markdown
library(commonmark)
library(markdown)
## graphics devices
library(Cairo)
library(svglite)
library(gdtools)
library(magick)
## tidymodeling related
library(tidymodels)
library(tidyselect)
library(tidytext)
library(tidybayes)
## tables
library(huxtable)
library(xtable)
library(DT)
library(rhandsontable)
library(formattable)
library(gtsummary)
## string manipulation
library(stringi)
library(arrayhelpers)
## fast data frames
library(data.table)
library(collapse)
library(vroom)
## shiny
library(flexdashboard)
library(shinydashboard)
library(shinyjs)
library(shinytest)
library(rsconnect)
library(thematic)
library(bslib)
library(bsplus)
## plotly
library(plotly)
## CSS/HTML
library(sass)
library(htmlwidgets)
library(widgetframe)
library(crosstalk)
library(manipulateWidget)
