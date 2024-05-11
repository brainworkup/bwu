
<!-- README.md is generated from README.Rmd. Please edit that file -->

<img src="hex-bwu.png" width="20%"/>

# bwu (BrainWorkUp) R Package

<!-- badges: start -->

[![R-CMD-check](https://github.com/brainworkup/bwu/actions/workflows/r.yml/badge.svg)](https://github.com/brainworkup/bwu/actions/workflows/r.yml)
[![R-CMD-check](https://github.com/brainworkup/bwu/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/brainworkup/bwu/actions/workflows/R-CMD-check.yaml)

<!-- badges: end -->

The goal of `bwu` is to facilitate neuropsychological evaluation data
processing, report writing, and presentation of results.

## Installation

You can install the development version of `bwu` like so:

``` r
pak::pak("brainworkup/bwu")
#> 
#> ✔ Updated metadata database: 2.22 MB in 2 files.
#> 
#> ℹ Updating metadata database
#> ✔ Updating metadata database ... done
#> 
#> 
#> → Will install 112 packages.
#> → Will update 1 package.
#> → Will download 102 CRAN packages (116.85 MB), cached: 11 (24.18 MB).
#> + assertthat                0.2.1        ⬇ (53.75 kB)
#> + backports                 1.4.1        ⬇ (104.25 kB)
#> + base64enc                 0.1-3        ⬇ (34.91 kB)
#> + bigD                      0.2.0        ⬇ (1.16 MB)
#> + bit                       4.0.5        ⬇ (1.29 MB)
#> + bit64                     4.0.5        ⬇ (608.98 kB)
#> + bitops                    1.0-7        ⬇ (32.77 kB)
#> + bookdown                  0.39        
#> + broom                     1.0.5        ⬇ (1.89 MB)
#> + bslib                     0.7.0        ⬇ (5.33 MB)
#> + bwu          0.0.1.9005 → 0.0.1.9005  👷🏼🔧 (GitHub: 68f6771)
#> + cachem                    1.0.8        ⬇ (69.61 kB)
#> + cellranger                1.1.0        ⬇ (103.58 kB)
#> + cli                       3.6.2        ⬇ (1.40 MB)
#> + clipr                     0.8.0        ⬇ (51.67 kB)
#> + colorspace                2.1-0        ⬇ (2.65 MB)
#> + commonmark                1.9.1        ⬇ (357.98 kB)
#> + crayon                    1.5.2        ⬇ (163.57 kB)
#> + curl                      5.2.1        ⬇ (815.44 kB)
#> + data.table                1.15.4       ⬇ (2.63 MB)
#> + digest                    0.6.35       ⬇ (363.39 kB)
#> + dplyr                     1.1.4        ⬇ (1.61 MB)
#> + ellipsis                  0.3.2        ⬇ (39.35 kB)
#> + evaluate                  0.23         ⬇ (83.61 kB)
#> + fansi                     1.0.6        ⬇ (389.81 kB)
#> + farver                    2.1.1        ⬇ (1.99 MB)
#> + fastmap                   1.1.1        ⬇ (201.27 kB)
#> + fontawesome               0.5.2        ⬇ (1.36 MB)
#> + forcats                   1.0.0        ⬇ (424.77 kB)
#> + fs                        1.6.4       
#> + generics                  0.1.3        ⬇ (81.24 kB)
#> + ggplot2                   3.5.1       
#> + ggtext                    0.1.2        ⬇ (1.26 MB)
#> + ggthemes                  5.1.0        ⬇ (444.08 kB)
#> + glue                      1.7.0        ⬇ (160.13 kB)
#> + gridtext                  0.1.5        ⬇ (956.23 kB)
#> + gt                        0.10.1       ⬇ (4.70 MB)
#> + gtable                    0.3.5       
#> + gtExtras                  0.5.0        ⬇ (4.40 MB)
#> + here                      1.0.1        ⬇ (51.21 kB)
#> + highcharter               0.9.4        ⬇ (1.63 MB)
#> + highr                     0.10         ⬇ (39.16 kB)
#> + hms                       1.1.3        ⬇ (100.24 kB)
#> + htmltools                 0.5.8.1     
#> + htmlwidgets               1.6.4        ⬇ (805.45 kB)
#> + igraph                    2.0.3        ⬇ (10.36 MB)
#> + isoband                   0.2.7        ⬇ (1.88 MB)
#> + janitor                   2.2.0        ⬇ (286.79 kB)
#> + jpeg                      0.1-10       ⬇ (455.67 kB)
#> + jquerylib                 0.1.4        ⬇ (526.41 kB)
#> + jsonlite                  1.8.8        ⬇ (1.14 MB)
#> + juicyjuice                0.1.0        ⬇ (1.13 MB)
#> + kableExtra                1.4.0        ⬇ (2.04 MB)
#> + knitr                     1.46        
#> + labeling                  0.4.3        ⬇ (61.59 kB)
#> + lifecycle                 1.0.4        ⬇ (124.76 kB)
#> + lubridate                 1.9.3        ⬇ (1.01 MB)
#> + magrittr                  2.0.3        ⬇ (233.70 kB)
#> + markdown                  1.12         ⬇ (207.07 kB)
#> + memoise                   2.0.1        ⬇ (49.08 kB)
#> + mime                      0.12         ⬇ (36.75 kB)
#> + munsell                   0.5.1        ⬇ (244.73 kB)
#> + paletteer                 1.6.0        ⬇ (447.11 kB)
#> + pillar                    1.9.0        ⬇ (651.77 kB)
#> + pkgconfig                 2.0.3        ⬇ (18.49 kB)
#> + png                       0.1-8        ⬇ (404.58 kB)
#> + prismatic                 1.1.2       
#> + purrr                     1.0.2        ⬇ (527.83 kB)
#> + quantmod                  0.4.26       ⬇ (1.06 MB)
#> + R6                        2.5.1        ⬇ (83.25 kB)
#> + rappdirs                  0.3.3        ⬇ (47.51 kB)
#> + RColorBrewer              1.1-3        ⬇ (53.31 kB)
#> + Rcpp                      1.0.12       ⬇ (3.31 MB)
#> + reactable                 0.4.4        ⬇ (1.06 MB)
#> + reactR                    0.5.0        ⬇ (619.71 kB)
#> + readr                     2.1.5        ⬇ (1.97 MB)
#> + readxl                    1.4.3        ⬇ (1.55 MB)
#> + rematch                   2.0.0        ⬇ (16.62 kB)
#> + rematch2                  2.1.2        ⬇ (45.73 kB)
#> + rJava                     1.0-11       ⬇ (790.86 kB)
#> + rjson                     0.2.21       ⬇ (214.77 kB)
#> + rlang                     1.1.3        ⬇ (1.91 MB)
#> + rlist                     0.4.6.2      ⬇ (251.30 kB)
#> + rmarkdown                 2.26         ⬇ (2.63 MB)
#> + rprojroot                 2.0.4        ⬇ (105.91 kB)
#> + rstudioapi                0.16.0       ⬇ (314.99 kB)
#> + sass                      0.4.9        ⬇ (2.41 MB)
#> + scales                    1.3.0        ⬇ (708.87 kB)
#> + snakecase                 0.11.1       ⬇ (160.61 kB)
#> + stringi                   1.8.4       
#> + stringr                   1.5.1        ⬇ (313.90 kB)
#> + svglite                   2.1.3        ⬇ (926.89 kB)
#> + systemfonts               1.0.6        ⬇ (7.10 MB)
#> + tabulapdf                 1.0.5-2     👷🏽🔧 (GitHub: 6bd4946)
#> + tibble                    3.2.1        ⬇ (689.38 kB)
#> + tidyr                     1.3.1        ⬇ (1.32 MB)
#> + tidyselect                1.2.1        ⬇ (224.46 kB)
#> + timechange                0.3.0        ⬇ (879.08 kB)
#> + tinytex                   0.51        
#> + TTR                       0.24.4       ⬇ (551.08 kB)
#> + tzdb                      0.4.0        ⬇ (1.26 MB)
#> + utf8                      1.2.4        ⬇ (210.11 kB)
#> + V8                        4.4.2        ⬇ (10.62 MB)
#> + vctrs                     0.6.5        ⬇ (1.98 MB)
#> + viridisLite               0.4.2        ⬇ (1.30 MB)
#> + vroom                     1.6.5        ⬇ (3.13 MB)
#> + withr                     3.0.0        ⬇ (241.08 kB)
#> + xfun                      0.43         ⬇ (491.18 kB)
#> + XML                       3.99-0.16.1  ⬇ (1.96 MB)
#> + xml2                      1.3.6        ⬇ (528.14 kB)
#> + xts                       0.13.2       ⬇ (922.67 kB)
#> + yaml                      2.3.8        ⬇ (231.23 kB)
#> + zoo                       1.8-12       ⬇ (1.03 MB)
#> ℹ Getting 102 pkgs (116.85 MB), 11 (24.18 MB) cached
#> ✔ Got RColorBrewer 1.1-3 (x86_64-apple-darwin20) (53.32 kB)
#> ✔ Got R6 2.5.1 (x86_64-apple-darwin20) (83.20 kB)
#> ✔ Got bit 4.0.5 (x86_64-apple-darwin20) (1.29 MB)
#> ✔ Got TTR 0.24.4 (x86_64-apple-darwin20) (552.98 kB)
#> ✔ Got bitops 1.0-7 (x86_64-apple-darwin20) (32.81 kB)
#> ✔ Got cellranger 1.1.0 (x86_64-apple-darwin20) (103.63 kB)
#> ✔ Got clipr 0.8.0 (x86_64-apple-darwin20) (51.28 kB)
#> ✔ Got commonmark 1.9.1 (x86_64-apple-darwin20) (358.00 kB)
#> ✔ Got evaluate 0.23 (x86_64-apple-darwin20) (83.61 kB)
#> ✔ Got crayon 1.5.2 (x86_64-apple-darwin20) (163.39 kB)
#> ✔ Got curl 5.2.1 (x86_64-apple-darwin20) (815.41 kB)
#> ✔ Got fastmap 1.1.1 (x86_64-apple-darwin20) (201.36 kB)
#> ✔ Got XML 3.99-0.16.1 (x86_64-apple-darwin20) (1.96 MB)
#> ✔ Got fontawesome 0.5.2 (x86_64-apple-darwin20) (1.36 MB)
#> ✔ Got fs 1.6.4 (x86_64-apple-darwin20) (641.03 kB)
#> ✔ Got generics 0.1.3 (x86_64-apple-darwin20) (80.13 kB)
#> ✔ Got here 1.0.1 (x86_64-apple-darwin20) (51.21 kB)
#> ✔ Got glue 1.7.0 (x86_64-apple-darwin20) (160.31 kB)
#> ✔ Got Rcpp 1.0.12 (x86_64-apple-darwin20) (3.31 MB)
#> ✔ Got bwu 0.0.1.9005 (source) (4.84 MB)
#> ✔ Got ggtext 0.1.2 (x86_64-apple-darwin20) (1.26 MB)
#> ✔ Got highcharter 0.9.4 (x86_64-apple-darwin20) (1.63 MB)
#> ✔ Got lifecycle 1.0.4 (x86_64-apple-darwin20) (124.96 kB)
#> ✔ Got htmlwidgets 1.6.4 (x86_64-apple-darwin20) (805.49 kB)
#> ✔ Got jpeg 0.1-10 (x86_64-apple-darwin20) (455.58 kB)
#> ✔ Got magrittr 2.0.3 (x86_64-apple-darwin20) (233.53 kB)
#> ✔ Got memoise 2.0.1 (x86_64-apple-darwin20) (49.00 kB)
#> ✔ Got isoband 0.2.7 (x86_64-apple-darwin20) (1.88 MB)
#> ✔ Got munsell 0.5.1 (x86_64-apple-darwin20) (245.21 kB)
#> ✔ Got pillar 1.9.0 (x86_64-apple-darwin20) (651.70 kB)
#> ✔ Got pkgconfig 2.0.3 (x86_64-apple-darwin20) (18.54 kB)
#> ✔ Got rappdirs 0.3.3 (x86_64-apple-darwin20) (47.62 kB)
#> ✔ Got knitr 1.46 (x86_64-apple-darwin20) (1.05 MB)
#> ✔ Got V8 4.4.2 (x86_64-apple-darwin20) (10.62 MB)
#> ✔ Got farver 2.1.1 (x86_64-apple-darwin20) (1.99 MB)
#> ✔ Got prismatic 1.1.2 (x86_64-apple-darwin20) (744.00 kB)
#> ✔ Got rlist 0.4.6.2 (x86_64-apple-darwin20) (255.38 kB)
#> ✔ Got purrr 1.0.2 (x86_64-apple-darwin20) (526.85 kB)
#> ✔ Got reactR 0.5.0 (x86_64-apple-darwin20) (619.84 kB)
#> ✔ Got scales 1.3.0 (x86_64-apple-darwin20) (709.68 kB)
#> ✔ Got tidyselect 1.2.1 (x86_64-apple-darwin20) (224.22 kB)
#> ✔ Got gt 0.10.1 (x86_64-apple-darwin20) (4.70 MB)
#> ✔ Got readxl 1.4.3 (x86_64-apple-darwin20) (1.55 MB)
#> ✔ Got kableExtra 1.4.0 (x86_64-apple-darwin20) (2.04 MB)
#> ✔ Got tibble 3.2.1 (x86_64-apple-darwin20) (689.71 kB)
#> ✔ Got rlang 1.1.3 (x86_64-apple-darwin20) (1.91 MB)
#> ✔ Got rmarkdown 2.26 (x86_64-apple-darwin20) (2.63 MB)
#> ✔ Got tidyr 1.3.1 (x86_64-apple-darwin20) (1.32 MB)
#> ✔ Got xml2 1.3.6 (x86_64-apple-darwin20) (527.77 kB)
#> ✔ Got yaml 2.3.8 (x86_64-apple-darwin20) (231.30 kB)
#> ✔ Got backports 1.4.1 (x86_64-apple-darwin20) (103.87 kB)
#> ✔ Got vctrs 0.6.5 (x86_64-apple-darwin20) (1.98 MB)
#> ✔ Got xts 0.13.2 (x86_64-apple-darwin20) (922.67 kB)
#> ✔ Got fansi 1.0.6 (x86_64-apple-darwin20) (390.24 kB)
#> ✔ Got bit64 4.0.5 (x86_64-apple-darwin20) (608.59 kB)
#> ✔ Got forcats 1.0.0 (x86_64-apple-darwin20) (424.41 kB)
#> ✔ Got bookdown 0.39 (x86_64-apple-darwin20) (1.09 MB)
#> ✔ Got bigD 0.2.0 (x86_64-apple-darwin20) (1.16 MB)
#> ✔ Got ggthemes 5.1.0 (x86_64-apple-darwin20) (449.75 kB)
#> ✔ Got vroom 1.6.5 (x86_64-apple-darwin20) (3.13 MB)
#> ✔ Got cli 3.6.2 (x86_64-apple-darwin20) (1.40 MB)
#> ✔ Got janitor 2.2.0 (x86_64-apple-darwin20) (286.84 kB)
#> ✔ Got gtable 0.3.5 (x86_64-apple-darwin20) (218.80 kB)
#> ✔ Got htmltools 0.5.8.1 (x86_64-apple-darwin20) (361.66 kB)
#> ✔ Got jquerylib 0.1.4 (x86_64-apple-darwin20) (526.39 kB)
#> ✔ Got broom 1.0.5 (x86_64-apple-darwin20) (1.89 MB)
#> ✔ Got markdown 1.12 (x86_64-apple-darwin20) (207.02 kB)
#> ✔ Got png 0.1-8 (x86_64-apple-darwin20) (404.57 kB)
#> ✔ Got tabulapdf 1.0.5-2 (source) (12.09 MB)
#> ✔ Got rprojroot 2.0.4 (x86_64-apple-darwin20) (105.85 kB)
#> ✔ Got rjson 0.2.21 (x86_64-apple-darwin20) (214.75 kB)
#> ✔ Got rstudioapi 0.16.0 (x86_64-apple-darwin20) (314.73 kB)
#> ✔ Got dplyr 1.1.4 (x86_64-apple-darwin20) (1.61 MB)
#> ✔ Got lubridate 1.9.3 (x86_64-apple-darwin20) (1.01 MB)
#> ✔ Got tinytex 0.51 (x86_64-apple-darwin20) (140.79 kB)
#> ✔ Got juicyjuice 0.1.0 (x86_64-apple-darwin20) (1.13 MB)
#> ✔ Got reactable 0.4.4 (x86_64-apple-darwin20) (1.06 MB)
#> ✔ Got withr 3.0.0 (x86_64-apple-darwin20) (242.22 kB)
#> ✔ Got ellipsis 0.3.2 (x86_64-apple-darwin20) (39.40 kB)
#> ✔ Got cachem 1.0.8 (x86_64-apple-darwin20) (69.58 kB)
#> ✔ Got highr 0.10 (x86_64-apple-darwin20) (39.16 kB)
#> ✔ Got zoo 1.8-12 (x86_64-apple-darwin20) (1.03 MB)
#> ✔ Got readr 2.1.5 (x86_64-apple-darwin20) (1.97 MB)
#> ✔ Got tzdb 0.4.0 (x86_64-apple-darwin20) (1.26 MB)
#> ✔ Got labeling 0.4.3 (x86_64-apple-darwin20) (61.56 kB)
#> ✔ Got mime 0.12 (x86_64-apple-darwin20) (36.77 kB)
#> ✔ Got rematch2 2.1.2 (x86_64-apple-darwin20) (45.83 kB)
#> ✔ Got sass 0.4.9 (x86_64-apple-darwin20) (2.41 MB)
#> ✔ Got igraph 2.0.3 (x86_64-apple-darwin20) (10.35 MB)
#> ✔ Got snakecase 0.11.1 (x86_64-apple-darwin20) (160.53 kB)
#> ✔ Got utf8 1.2.4 (x86_64-apple-darwin20) (210.11 kB)
#> ✔ Got jsonlite 1.8.8 (x86_64-apple-darwin20) (1.14 MB)
#> ✔ Got base64enc 0.1-3 (x86_64-apple-darwin20) (34.86 kB)
#> ✔ Got xfun 0.43 (x86_64-apple-darwin20) (489.62 kB)
#> ✔ Got data.table 1.15.4 (x86_64-apple-darwin20) (2.63 MB)
#> ✔ Got colorspace 2.1-0 (x86_64-apple-darwin20) (2.65 MB)
#> ✔ Got digest 0.6.35 (x86_64-apple-darwin20) (363.45 kB)
#> ✔ Got rJava 1.0-11 (x86_64-apple-darwin20) (791.57 kB)
#> ✔ Got rematch 2.0.0 (x86_64-apple-darwin20) (16.64 kB)
#> ✔ Got stringr 1.5.1 (x86_64-apple-darwin20) (314.03 kB)
#> ✔ Got viridisLite 0.4.2 (x86_64-apple-darwin20) (1.30 MB)
#> ✔ Got svglite 2.1.3 (x86_64-apple-darwin20) (926.92 kB)
#> ✔ Got bslib 0.7.0 (x86_64-apple-darwin20) (5.33 MB)
#> ✔ Got assertthat 0.2.1 (x86_64-apple-darwin20) (53.89 kB)
#> ✔ Got gridtext 0.1.5 (x86_64-apple-darwin20) (956.22 kB)
#> ✔ Got systemfonts 1.0.6 (x86_64-apple-darwin20) (7.10 MB)
#> ✔ Got timechange 0.3.0 (x86_64-apple-darwin20) (879.00 kB)
#> ✔ Got paletteer 1.6.0 (x86_64-apple-darwin20) (447.50 kB)
#> ✔ Got hms 1.1.3 (x86_64-apple-darwin20) (100.42 kB)
#> ✔ Got quantmod 0.4.26 (x86_64-apple-darwin20) (1.06 MB)
#> ✔ Got stringi 1.8.4 (x86_64-apple-darwin20) (14.63 MB)
#> ✔ Got gtExtras 0.5.0 (x86_64-apple-darwin20) (4.40 MB)
#> ✔ Got ggplot2 3.5.1 (x86_64-apple-darwin20) (4.98 MB)
#> ✔ Installed R6 2.5.1  (765ms)
#> ✔ Installed RColorBrewer 1.1-3  (804ms)
#> ✔ Installed Rcpp 1.0.12  (797ms)
#> ✔ Installed TTR 0.24.4  (778ms)
#> ✔ Installed V8 4.4.2  (759ms)
#> ✔ Installed XML 3.99-0.16.1  (742ms)
#> ✔ Installed assertthat 0.2.1  (723ms)
#> ✔ Installed backports 1.4.1  (698ms)
#> ✔ Installed base64enc 0.1-3  (708ms)
#> ✔ Installed bigD 0.2.0  (689ms)
#> ✔ Installed bit64 4.0.5  (667ms)
#> ✔ Installed bit 4.0.5  (645ms)
#> ✔ Installed bitops 1.0-7  (620ms)
#> ✔ Installed bookdown 0.39  (605ms)
#> ✔ Installed broom 1.0.5  (632ms)
#> ✔ Installed bslib 0.7.0  (720ms)
#> ✔ Installed cachem 1.0.8  (179ms)
#> ✔ Installed cellranger 1.1.0  (117ms)
#> ✔ Installed cli 3.6.2  (121ms)
#> ✔ Installed clipr 0.8.0  (118ms)
#> ✔ Installed colorspace 2.1-0  (118ms)
#> ✔ Installed commonmark 1.9.1  (115ms)
#> ✔ Installed crayon 1.5.2  (161ms)
#> ✔ Installed curl 5.2.1  (173ms)
#> ✔ Installed data.table 1.15.4  (118ms)
#> ✔ Installed digest 0.6.35  (118ms)
#> ✔ Installed dplyr 1.1.4  (120ms)
#> ✔ Installed ellipsis 0.3.2  (124ms)
#> ✔ Installed evaluate 0.23  (118ms)
#> ✔ Installed fansi 1.0.6  (170ms)
#> ✔ Installed farver 2.1.1  (142ms)
#> ✔ Installed fastmap 1.1.1  (113ms)
#> ✔ Installed fontawesome 0.5.2  (116ms)
#> ✔ Installed forcats 1.0.0  (117ms)
#> ✔ Installed fs 1.6.4  (121ms)
#> ✔ Installed generics 0.1.3  (118ms)
#> ✔ Installed ggplot2 3.5.1  (182ms)
#> ✔ Installed ggtext 0.1.2  (142ms)
#> ✔ Installed ggthemes 5.1.0  (118ms)
#> ✔ Installed glue 1.7.0  (120ms)
#> ✔ Installed gridtext 0.1.5  (128ms)
#> ✔ Installed gtExtras 0.5.0  (122ms)
#> ✔ Installed gt 0.10.1  (119ms)
#> ✔ Installed gtable 0.3.5  (187ms)
#> ✔ Installed here 1.0.1  (129ms)
#> ✔ Installed highcharter 0.9.4  (119ms)
#> ✔ Installed highr 0.10  (118ms)
#> ✔ Installed hms 1.1.3  (116ms)
#> ✔ Installed htmltools 0.5.8.1  (121ms)
#> ✔ Installed htmlwidgets 1.6.4  (119ms)
#> ✔ Installed igraph 2.0.3  (224ms)
#> ✔ Installed isoband 0.2.7  (135ms)
#> ✔ Installed janitor 2.2.0  (118ms)
#> ✔ Installed jpeg 0.1-10  (117ms)
#> ✔ Installed jquerylib 0.1.4  (116ms)
#> ✔ Installed jsonlite 1.8.8  (117ms)
#> ✔ Installed juicyjuice 0.1.0  (114ms)
#> ✔ Installed kableExtra 1.4.0  (202ms)
#> ✔ Installed knitr 1.46  (170ms)
#> ✔ Installed labeling 0.4.3  (135ms)
#> ✔ Installed lifecycle 1.0.4  (118ms)
#> ✔ Installed lubridate 1.9.3  (132ms)
#> ✔ Installed magrittr 2.0.3  (130ms)
#> ✔ Installed markdown 1.12  (123ms)
#> ✔ Installed memoise 2.0.1  (196ms)
#> ✔ Installed mime 0.12  (142ms)
#> ✔ Installed munsell 0.5.1  (116ms)
#> ✔ Installed paletteer 1.6.0  (117ms)
#> ✔ Installed pillar 1.9.0  (117ms)
#> ✔ Installed pkgconfig 2.0.3  (117ms)
#> ✔ Installed png 0.1-8  (104ms)
#> ✔ Installed prismatic 1.1.2  (172ms)
#> ✔ Installed purrr 1.0.2  (146ms)
#> ✔ Installed quantmod 0.4.26  (130ms)
#> ✔ Installed rappdirs 0.3.3  (117ms)
#> ✔ Installed reactR 0.5.0  (119ms)
#> ✔ Installed reactable 0.4.4  (119ms)
#> ✔ Installed readr 2.1.5  (124ms)
#> ✔ Installed readxl 1.4.3  (186ms)
#> ✔ Installed rematch2 2.1.2  (144ms)
#> ✔ Installed rematch 2.0.0  (121ms)
#> ✔ Installed rjson 0.2.21  (119ms)
#> ✔ Installed rlang 1.1.3  (122ms)
#> ✔ Installed rlist 0.4.6.2  (118ms)
#> ✔ Installed rmarkdown 2.26  (119ms)
#> ✔ Installed rprojroot 2.0.4  (171ms)
#> ✔ Installed rstudioapi 0.16.0  (180ms)
#> ✔ Installed sass 0.4.9  (115ms)
#> ✔ Installed scales 1.3.0  (120ms)
#> ✔ Installed snakecase 0.11.1  (116ms)
#> ✔ Installed stringr 1.5.1  (41ms)
#> ✔ Installed stringi 1.8.4  (222ms)
#> ✔ Installed svglite 2.1.3  (178ms)
#> ✔ Installed systemfonts 1.0.6  (257ms)
#> ✔ Installed tibble 3.2.1  (204ms)
#> ✔ Installed tidyr 1.3.1  (131ms)
#> ✔ Installed tidyselect 1.2.1  (126ms)
#> ✔ Installed timechange 0.3.0  (125ms)
#> ✔ Installed tinytex 0.51  (119ms)
#> ✔ Installed tzdb 0.4.0  (181ms)
#> ✔ Installed utf8 1.2.4  (154ms)
#> ✔ Installed vctrs 0.6.5  (126ms)
#> ✔ Installed viridisLite 0.4.2  (123ms)
#> ✔ Installed vroom 1.6.5  (122ms)
#> ✔ Installed withr 3.0.0  (126ms)
#> ✔ Installed xfun 0.43  (124ms)
#> ✔ Installed xml2 1.3.6  (188ms)
#> ✔ Installed xts 0.13.2  (145ms)
#> ✔ Installed yaml 2.3.8  (124ms)
#> ✔ Installed zoo 1.8-12  (122ms)
#> ✔ Installed rJava 1.0-11  (62ms)
#> ℹ Packaging tabulapdf 1.0.5-2
#> ✔ Packaged tabulapdf 1.0.5-2 (1.7s)
#> ℹ Building tabulapdf 1.0.5-2
#> ✔ Built tabulapdf 1.0.5-2 (4.2s)
#> ✔ Installed tabulapdf 1.0.5-2 (github::ropensci/tabulapdf@6bd4946) (71ms)
#> ℹ Packaging bwu 0.0.1.9005
#> ✔ Packaged bwu 0.0.1.9005 (2.2s)
#> ℹ Building bwu 0.0.1.9005
#> ✔ Built bwu 0.0.1.9005 (7.5s)
#> ✔ Installed bwu 0.0.1.9005 (github::brainworkup/bwu@68f6771) (134ms)
#> ✔ 1 pkg + 117 deps: kept 5, upd 1, added 112, dld 113 (NA B) [54.9s]
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(bwu)
#> Registered S3 method overwritten by 'quantmod':
#>   method            from
#>   as.zoo.data.frame zoo
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
