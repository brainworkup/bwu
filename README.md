
<!-- README.md is generated from README.Rmd. Please edit that file -->

<img src="hex-bwu.png" width="20%"/>

# bwu

<!-- badges: start -->

[![R-CMD-check](https://github.com/brainworkup/bwu/actions/workflows/r.yml/badge.svg)](https://github.com/brainworkup/bwu/actions/workflows/r.yml)
[![R-CMD-check](https://github.com/brainworkup/bwu/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/brainworkup/bwu/actions/workflows/R-CMD-check.yaml)

<!-- badges: end -->

The goal of `bwu` is to facilitate neuropsychological evaluation …

## Installation

You can install the development version of `bwu` like so:

``` r
pak::pkg_install("brainworkup/bwu")
#> ℹ Loading metadata database
#> ✔ Loading metadata database ... done
#> 
#> 
#> → Will install 96 packages.
#> → Will update 1 package.
#> → Will download 51 packages with unknown size.
#> + assertthat                 0.2.1       
#> + backports                  1.4.1-9001  🔧 ⬇
#> + base64enc                  0.1-3       
#> + bit                        4.0.5       
#> + bit64                      4.0.5       
#> + bookdown                   0.34.2       ⬇
#> + brew                       1.0-8       
#> + broom                      1.0.4.9000   ⬇
#> + bslib                      0.5.0.9000   ⬇
#> + bwu           0.0.2.9000 → 0.0.1.9000  👷🔧 ⬇ (GitHub: 00f4e98)
#> + cachem                     1.0.8       
#> + cellranger                 1.1.0       
#> + cli                        3.6.1.9000  🔧 ⬇
#> + clipr                      0.8.0       
#> + colorspace                 2.1-1       🔧 ⬇
#> + crayon                     1.5.2       
#> + curl                       5.0.0       
#> + data.table                 1.14.8      
#> + digest                     0.6.31      
#> + dplyr                      1.1.2.9000  🔧 ⬇
#> + ellipsis                   0.3.2.9000  🔧 ⬇
#> + evaluate                   0.21.1       ⬇
#> + fansi                      1.0.4       
#> + farver                     2.1.1       
#> + fastmap                    1.1.1.9000  🔧 ⬇
#> + fontawesome                0.5.1       
#> + fs                         1.6.2       
#> + generics                   0.1.3.9000   ⬇
#> + ggplot2                    3.4.2.9000   ⬇
#> + ggthemes                   4.2.4       
#> + glue                       1.6.2.9000  🔧 ⬇
#> + gtable                     0.3.3.9000   ⬇
#> + here                       1.0.1.9005   ⬇
#> + highcharter                0.9.4       
#> + highr                      0.10.1       ⬇
#> + hms                        1.1.3.9002   ⬇
#> + htmltools                  0.5.5.9000  🔧 ⬇
#> + htmlwidgets                1.6.2       
#> + igraph                     1.4.3       
#> + isoband                    0.2.7.9000  🔧 ⬇
#> + janitor                    2.2.0       
#> + jquerylib                  0.1.4       
#> + jsonlite                   1.8.5       
#> + knitr                      1.43.1       ⬇
#> + labeling                   0.4.2       
#> + lifecycle                  1.0.3.9000   ⬇
#> + lubridate                  1.9.2.9000  🔧 ⬇
#> + magrittr                   2.0.3.9000  🔧 ⬇
#> + memoise                    2.0.1.9000   ⬇
#> + mime                       0.12.1      🔧 ⬇
#> + munsell                    0.5.0       
#> + pillar                     1.9.0.9002   ⬇
#> + pkgconfig                  2.0.3       
#> + png                        0.1-8       
#> + purrr                      1.0.1.9000  🔧 ⬇
#> + quantmod                   0.4.22      
#> + R6                         2.5.1.9000   ⬇
#> + rappdirs                   0.3.3.9000  🔧 ⬇
#> + RColorBrewer               1.1-3       
#> + readr                      2.1.4.9000  🔧 ⬇
#> + readxl                     1.4.2.9000  🔧 ⬇
#> + rematch                    1.0.1       
#> + rematch2                   2.1.2.9000   ⬇
#> + rJava                      1.0-6       
#> + rjson                      0.2.21      
#> + rlang                      1.1.1.9000  🔧 ⬇
#> + rlist                      0.4.6.2     
#> + rmarkdown                  2.22.1       ⬇
#> + rprojroot                  2.0.3.9004   ⬇
#> + rstudioapi                 0.14.0-9000  ⬇
#> + sass                       0.4.6.9000  🔧 ⬇
#> + scales                     1.2.1.9000   ⬇
#> + sinew                      0.4.0       
#> + snakecase                  0.11.0      
#> + sos                        2.1-4       
#> + stringi                    1.7.12      
#> + stringr                    1.5.0.9000   ⬇
#> + tabulizer                  0.2.3        ⬇
#> + tabulizerjars              1.0.1        ⬇
#> + tibble                     3.2.1.9005  🔧 ⬇
#> + tidyr                      1.3.0.9000  🔧 ⬇
#> + tidyselect                 1.2.0.9000   ⬇
#> + tidytable                  0.10.1      
#> + timechange                 0.2.0       
#> + tinytex                    0.45.2       ⬇
#> + TTR                        0.24.3      
#> + tzdb                       0.4.0       
#> + utf8                       1.2.3       
#> + vctrs                      0.6.2.9000  🔧 ⬇
#> + viridisLite                0.4.2       
#> + vroom                      1.6.3.9000  🔧 ⬇
#> + withr                      2.99.0.9000  ⬇
#> + xfun                       0.39.1      🔧 ⬇
#> + XML                        3.99-0.14   
#> + xts                        0.13.1      
#> + yaml                       2.3.7       
#> + zoo                        1.8-13      🔧 ⬇
#> ℹ Getting 51 pkgs with unknown sizes, 46 (51.32 MB) cached
#> ✔ Cached copy of bwu 0.0.1.9000 (source) is the latest build
#> ✔ Got digest 0.6.31 (x86_64-apple-darwin20) (280.51 kB)
#> ✔ Got crayon 1.5.2 (x86_64-apple-darwin20) (162.31 kB)
#> ✔ Got rematch 1.0.1 (x86_64-apple-darwin20) (12.64 kB)
#> ✔ Got TTR 0.24.3 (x86_64-apple-darwin20) (543.86 kB)
#> ✔ Got png 0.1-8 (x86_64-apple-darwin20) (404.54 kB)
#> ✔ Got mime 0.12.1 (x86_64-apple-darwin20) (33.12 kB)
#> ✔ Got fontawesome 0.5.1 (x86_64-apple-darwin20) (1.36 MB)
#> ✔ Got tzdb 0.4.0 (x86_64-apple-darwin20) (1.27 MB)
#> ✔ Got rlist 0.4.6.2 (x86_64-apple-darwin20) (251.46 kB)
#> ✔ Got tidyselect 1.2.0.9000 (x86_64-apple-darwin20) (215.28 kB)
#> ✔ Got XML 3.99-0.14 (x86_64-apple-darwin20) (1.94 MB)
#> ✔ Got sos 2.1-4 (x86_64-apple-darwin20) (292.67 kB)
#> ✔ Got pillar 1.9.0.9002 (x86_64-apple-darwin20) (413.04 kB)
#> ✔ Got rprojroot 2.0.3.9004 (x86_64-apple-darwin20) (98.32 kB)
#> ✔ Got data.table 1.14.8 (x86_64-apple-darwin20) (2.51 MB)
#> ✔ Got purrr 1.0.1.9000 (x86_64-apple-darwin20) (485.96 kB)
#> ✔ Got rlang 1.1.1.9000 (x86_64-apple-darwin20) (1.56 MB)
#> ✔ Got broom 1.0.4.9000 (x86_64-apple-darwin20) (1.91 MB)
#> ✔ Got readr 2.1.4.9000 (x86_64-apple-darwin20) (818.13 kB)
#> ✔ Got highr 0.10.1 (x86_64-apple-darwin20) (39.57 kB)
#> ✔ Got rappdirs 0.3.3.9000 (x86_64-apple-darwin20) (44.15 kB)
#> ✔ Got scales 1.2.1.9000 (x86_64-apple-darwin20) (611.12 kB)
#> ✔ Got fastmap 1.1.1.9000 (x86_64-apple-darwin20) (63.56 kB)
#> ✔ Got magrittr 2.0.3.9000 (x86_64-apple-darwin20) (212.99 kB)
#> ✔ Got colorspace 2.1-1 (x86_64-apple-darwin20) (2.55 MB)
#> ✔ Got hms 1.1.3.9002 (x86_64-apple-darwin20) (99.05 kB)
#> ✔ Got R6 2.5.1.9000 (x86_64-apple-darwin20) (86.49 kB)
#> ✔ Got rematch2 2.1.2.9000 (x86_64-apple-darwin20) (45.06 kB)
#> ✔ Got lifecycle 1.0.3.9000 (x86_64-apple-darwin20) (116.62 kB)
#> ✔ Got evaluate 0.21.1 (x86_64-apple-darwin20) (81.11 kB)
#> ✔ Got vctrs 0.6.2.9000 (x86_64-apple-darwin20) (1.32 MB)
#> ✔ Got tibble 3.2.1.9005 (x86_64-apple-darwin20) (499.55 kB)
#> ✔ Got htmltools 0.5.5.9000 (x86_64-apple-darwin20) (343.69 kB)
#> ✔ Got glue 1.6.2.9000 (x86_64-apple-darwin20) (146.32 kB)
#> ✔ Got xfun 0.39.1 (x86_64-apple-darwin20) (423.49 kB)
#> ✔ Got withr 2.99.0.9000 (x86_64-apple-darwin20) (231.35 kB)
#> ✔ Got backports 1.4.1-9001 (x86_64-apple-darwin20) (113.03 kB)
#> ✔ Got rmarkdown 2.22.1 (x86_64-apple-darwin20) (2.61 MB)
#> ✔ Got readxl 1.4.2.9000 (x86_64-apple-darwin20) (864.57 kB)
#> ✔ Got zoo 1.8-13 (x86_64-apple-darwin20) (2.27 MB)
#> ✔ Got memoise 2.0.1.9000 (x86_64-apple-darwin20) (48.28 kB)
#> ✔ Got sass 0.4.6.9000 (x86_64-apple-darwin20) (2.25 MB)
#> ✔ Got here 1.0.1.9005 (x86_64-apple-darwin20) (48.13 kB)
#> ✔ Got gtable 0.3.3.9000 (x86_64-apple-darwin20) (213.32 kB)
#> ✔ Got generics 0.1.3.9000 (x86_64-apple-darwin20) (77.03 kB)
#> ✔ Got stringr 1.5.0.9000 (x86_64-apple-darwin20) (301.22 kB)
#> ✔ Got tabulizer 0.2.3 (x86_64-apple-darwin20) (177.28 kB)
#> ✔ Got cli 3.6.1.9000 (x86_64-apple-darwin20) (1.28 MB)
#> ✔ Got bslib 0.5.0.9000 (x86_64-apple-darwin20) (4.98 MB)
#> ✔ Got dplyr 1.1.2.9000 (x86_64-apple-darwin20) (1.45 MB)
#> ✔ Got isoband 0.2.7.9000 (x86_64-apple-darwin20) (2.49 MB)
#> ✔ Got ellipsis 0.3.2.9000 (x86_64-apple-darwin20) (33.91 kB)
#> ✔ Got knitr 1.43.1 (x86_64-apple-darwin20) (1.05 MB)
#> ✔ Got rstudioapi 0.14.0-9000 (x86_64-apple-darwin20) (288.36 kB)
#> ✔ Got tidyr 1.3.0.9000 (x86_64-apple-darwin20) (1.17 MB)
#> ✔ Got tinytex 0.45.2 (x86_64-apple-darwin20) (134.34 kB)
#> ✔ Got ggplot2 3.4.2.9000 (x86_64-apple-darwin20) (4.88 MB)
#> ✔ Got lubridate 1.9.2.9000 (x86_64-apple-darwin20) (971.03 kB)
#> ✔ Got bookdown 0.34.2 (x86_64-apple-darwin20) (1.09 MB)
#> ✔ Got vroom 1.6.3.9000 (x86_64-apple-darwin20) (1.03 MB)
#> ✔ Got tabulizerjars 1.0.1 (x86_64-apple-darwin20) (10.91 MB)
#> ✔ Installed bwu 0.0.1.9000 (github::brainworkup/bwu@00f4e98) (212ms)
#> ✔ Installed RColorBrewer 1.1-3  (237ms)
#> ✔ Installed TTR 0.24.3  (266ms)
#> ✔ Installed XML 3.99-0.14  (335ms)
#> ✔ Installed assertthat 0.2.1  (348ms)
#> ✔ Installed base64enc 0.1-3  (371ms)
#> ✔ Installed bit64 4.0.5  (410ms)
#> ✔ Installed bit 4.0.5  (433ms)
#> ✔ Installed brew 1.0-8  (452ms)
#> ✔ Installed cachem 1.0.8  (499ms)
#> ✔ Installed cellranger 1.1.0  (519ms)
#> ✔ Installed clipr 0.8.0  (537ms)
#> ✔ Installed crayon 1.5.2  (572ms)
#> ✔ Installed curl 5.0.0  (606ms)
#> ✔ Installed data.table 1.14.8  (652ms)
#> ✔ Installed digest 0.6.31  (678ms)
#> ✔ Installed fansi 1.0.4  (185ms)
#> ✔ Installed farver 2.1.1  (77ms)
#> ✔ Installed fontawesome 0.5.1  (84ms)
#> ✔ Installed fs 1.6.2  (89ms)
#> ✔ Installed ggthemes 4.2.4  (92ms)
#> ✔ Installed highcharter 0.9.4  (94ms)
#> ✔ Installed htmlwidgets 1.6.2  (68ms)
#> ✔ Installed janitor 2.2.0  (44ms)
#> ✔ Installed igraph 1.4.3  (167ms)
#> ✔ Installed jquerylib 0.1.4  (72ms)
#> ✔ Installed jsonlite 1.8.5  (62ms)
#> ✔ Installed labeling 0.4.2  (73ms)
#> ✔ Installed munsell 0.5.0  (59ms)
#> ✔ Installed pkgconfig 2.0.3  (81ms)
#> ✔ Installed png 0.1-8  (59ms)
#> ✔ Installed quantmod 0.4.22  (80ms)
#> ✔ Installed rematch 1.0.1  (21ms)
#> ✔ Installed rJava 1.0-6  (124ms)
#> ✔ Installed rjson 0.2.21  (123ms)
#> ✔ Installed rlist 0.4.6.2  (69ms)
#> ✔ Installed sinew 0.4.0  (71ms)
#> ✔ Installed snakecase 0.11.0  (64ms)
#> ✔ Installed sos 2.1-4  (62ms)
#> ✔ Installed tidytable 0.10.1  (29ms)
#> ✔ Installed timechange 0.2.0  (38ms)
#> ✔ Installed stringi 1.7.12  (213ms)
#> ✔ Installed tzdb 0.4.0  (106ms)
#> ✔ Installed utf8 1.2.3  (84ms)
#> ✔ Installed viridisLite 0.4.2  (103ms)
#> ✔ Installed xts 0.13.1  (66ms)
#> ✔ Installed yaml 2.3.7  (67ms)
#> ✔ Installed rlang 1.1.1.9000  (65ms)
#> ✔ Installed pillar 1.9.0.9002  (82ms)
#> ✔ Installed tidyselect 1.2.0.9000  (66ms)
#> ✔ Installed here 1.0.1.9005  (71ms)
#> ✔ Installed evaluate 0.21.1  (70ms)
#> ✔ Installed cli 3.6.1.9000  (73ms)
#> ✔ Installed rappdirs 0.3.3.9000  (64ms)
#> ✔ Installed rematch2 2.1.2.9000  (98ms)
#> ✔ Installed scales 1.2.1.9000  (78ms)
#> ✔ Installed generics 0.1.3.9000  (81ms)
#> ✔ Installed rprojroot 2.0.3.9004  (80ms)
#> ✔ Installed gtable 0.3.3.9000  (80ms)
#> ✔ Installed R6 2.5.1.9000  (69ms)
#> ✔ Installed withr 2.99.0.9000  (92ms)
#> ✔ Installed isoband 0.2.7.9000  (91ms)
#> ✔ Installed lifecycle 1.0.3.9000  (82ms)
#> ✔ Installed ellipsis 0.3.2.9000  (84ms)
#> ✔ Installed fastmap 1.1.1.9000  (112ms)
#> ✔ Installed vctrs 0.6.2.9000  (91ms)
#> ✔ Installed memoise 2.0.1.9000  (111ms)
#> ✔ Installed backports 1.4.1-9001  (85ms)
#> ✔ Installed sass 0.4.6.9000  (78ms)
#> ✔ Installed rmarkdown 2.22.1  (150ms)
#> ✔ Installed bslib 0.5.0.9000  (354ms)
#> ✔ Installed bookdown 0.34.2  (131ms)
#> ✔ Installed htmltools 0.5.5.9000  (120ms)
#> ✔ Installed tinytex 0.45.2  (65ms)
#> ✔ Installed rstudioapi 0.14.0-9000  (106ms)
#> ✔ Installed tabulizer 0.2.3  (68ms)
#> ✔ Installed lubridate 1.9.2.9000  (38ms)
#> ✔ Installed tabulizerjars 1.0.1  (149ms)
#> ✔ Installed xfun 0.39.1  (68ms)
#> ✔ Installed knitr 1.43.1  (83ms)
#> ✔ Installed highr 0.10.1  (82ms)
#> ✔ Installed mime 0.12.1  (84ms)
#> ✔ Installed zoo 1.8-13  (63ms)
#> ✔ Installed colorspace 2.1-1  (122ms)
#> ✔ Installed broom 1.0.4.9000  (180ms)
#> ✔ Installed purrr 1.0.1.9000  (133ms)
#> ✔ Installed ggplot2 3.4.2.9000  (89ms)
#> ✔ Installed vroom 1.6.3.9000  (76ms)
#> ✔ Installed tibble 3.2.1.9005  (71ms)
#> ✔ Installed tidyr 1.3.0.9000  (87ms)
#> ✔ Installed stringr 1.5.0.9000  (87ms)
#> ✔ Installed magrittr 2.0.3.9000  (65ms)
#> ✔ Installed dplyr 1.1.2.9000  (68ms)
#> ✔ Installed glue 1.6.2.9000  (108ms)
#> ✔ Installed hms 1.1.3.9002  (72ms)
#> ✔ Installed readr 2.1.4.9000  (74ms)
#> ✔ Installed readxl 1.4.2.9000  (64ms)
#> ✔ 1 pkg + 101 deps: kept 5, upd 1, added 96, dld 61 (62.21 MB) [23.7s]
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(bwu)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(dots)
#>       raw             age          percentile             n        
#>  Min.   : 1.00   Min.   : 3.50   Min.   :0.001355   Min.   :152.0  
#>  1st Qu.:10.00   1st Qu.:11.30   1st Qu.:0.256329   1st Qu.:305.0  
#>  Median :14.00   Median :29.00   Median :0.472222   Median :373.0  
#>  Mean   :14.08   Mean   :37.59   Mean   :0.491065   Mean   :402.1  
#>  3rd Qu.:18.00   3rd Qu.:63.80   3rd Qu.:0.740458   3rd Qu.:524.0  
#>  Max.   :27.00   Max.   :94.20   Max.   :0.998750   Max.   :524.0  
#>        m               md              sd          normValue    
#>  Min.   :13.40   Min.   :13.00   Min.   :4.271   Min.   :20.01  
#>  1st Qu.:13.40   1st Qu.:13.00   1st Qu.:4.806   1st Qu.:43.45  
#>  Median :14.25   Median :14.00   Median :5.062   Median :49.30  
#>  Mean   :14.25   Mean   :14.12   Mean   :4.920   Mean   :49.71  
#>  3rd Qu.:14.73   3rd Qu.:15.00   3rd Qu.:5.062   3rd Qu.:56.45  
#>  Max.   :17.16   Max.   :17.00   Max.   :5.124   Max.   :80.23
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/v1/examples>.

## Developmental Changes in Working Memory

### Figure 1

<img src="man/figures/README-wm-1.svg" width="50%" align="center/"/>

### Figure 2

<img src="man/figures/README-unnamed-chunk-4-1.gif" width="50%" align="center/"/>

------------------------------------------------------------------------

<!-- README.md is generated from README.Rmd. Please edit that file -->
