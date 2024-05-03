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

true
You can install the development version of `bwu` like so:

```r
pak::pak("brainworkup/bwu")
#> ℹ Loading metadata database
#> ✔ Loading metadata database ... done
#>
#>
#> → Will install 123 packages.
#> → Will update 1 package.
#> → Will download 77 CRAN packages (100.22 MB), cached: 47 (41.21 MB).
#> + askpass                    1.1         ⬇ (23.20 kB)
#> + assertthat                 0.2.1
#> + backports                  1.4.1
#> + base64enc                  0.1-3       ⬇ (34.81 kB)
#> + bigD                       0.2.0       ⬇ (1.16 MB)
#> + bit                        4.0.5
#> + bit64                      4.0.5
#> + bitops                     1.0-7       ⬇ (32.51 kB)
#> + bookdown                   0.35        ⬇ (1.09 MB)
#> + broom                      1.0.5
#> + bslib                      0.5.1       ⬇ (5.90 MB)
#> + bwu           0.0.1.9002 → 0.0.1.9002 👷🔧 (GitHub: 27ae68c)
#> + cachem                     1.0.8       ⬇ (69.43 kB)
#> + callr                      3.7.3       ⬇ (431.09 kB)
#> + cellranger                 1.1.0
#> + cli                        3.6.1       ⬇ (1.38 MB)
#> + clipr                      0.8.0       ⬇ (51.12 kB)
#> + colorspace                 2.1-0
#> + commonmark                 1.9.0       ⬇ (357.18 kB)
#> + crayon                     1.5.2       ⬇ (162.31 kB)
#> + curl                       5.0.2       ⬇ (811.87 kB)
#> + data.table                 1.14.8
#> + digest                     0.6.33      ⬇ (297.88 kB)
#> + dplyr                      1.1.2
#> + ellipsis                   0.3.2       ⬇ (39.03 kB)
#> + evaluate                   0.21        ⬇ (81.80 kB)
#> + fansi                      1.0.4       ⬇ (387.75 kB)
#> + farver                     2.1.1
#> + fastmap                    1.1.1       ⬇ (201.10 kB)
#> + fontawesome                0.5.2       ⬇ (1.36 MB)
#> + forcats                    1.0.0       ⬇ (422.45 kB)
#> + fs                         1.6.3       ⬇ (625.41 kB)
#> + generics                   0.1.3
#> + ggplot2                    3.4.3       ⬇ (3.34 MB)
#> + ggtext                     0.1.2       ⬇ (1.26 MB)
#> + ggthemes                   4.2.4       ⬇ (435.69 kB)
#> + glue                       1.6.2
#> + gridtext                   0.1.5       ⬇ (955.55 kB)
#> + gt                         0.9.0
#> + gtable                     0.3.4       ⬇ (218.00 kB)
#> + gtExtras                   0.4.5       ⬇ (4.19 MB)
#> + here                       1.0.1
#> + highcharter                0.9.4       ⬇ (1.63 MB)
#> + highr                      0.10        ⬇ (38.98 kB)
#> + hms                        1.1.3
#> + htmltools                  0.5.6       ⬇ (355.65 kB)
#> + htmlwidgets                1.6.2       ⬇ (803.88 kB)
#> + httr                       1.4.7       ⬇ (474.94 kB)
#> + igraph                     1.5.1       ⬇ (9.38 MB)
#> + isoband                    0.2.7
#> + janitor                    2.2.0
#> + jpeg                       0.1-10      ⬇ (455.37 kB)
#> + jquerylib                  0.1.4       ⬇ (526.36 kB)
#> + jsonlite                   1.8.7       ⬇ (1.13 MB)
#> + juicyjuice                 0.1.0       ⬇ (1.13 MB)
#> + kableExtra                 1.3.4
#> + knitr                      1.43        ⬇ (1.47 MB)
#> + labeling                   0.4.2
#> + lifecycle                  1.0.3       ⬇ (123.60 kB)
#> + lubridate                  1.9.2
#> + magrittr                   2.0.3       ⬇ (232.37 kB)
#> + markdown                   1.8         ⬇ (196.68 kB)
#> + memoise                    2.0.1       ⬇ (47.96 kB)
#> + mime                       0.12        ⬇ (36.62 kB)
#> + munsell                    0.5.0
#> + openssl                    2.1.0       ⬇ (2.89 MB)
#> + paletteer                  1.5.0       ⬇ (436.69 kB)
#> + pillar                     1.9.0       ⬇ (648.66 kB)
#> + pkgconfig                  2.0.3       ⬇ (18.18 kB)
#> + png                        0.1-8
#> + prismatic                  1.1.1       ⬇ (788.48 kB)
#> + processx                   3.8.2       ⬇ (316.26 kB)
#> + ps                         1.7.5       ⬇ (314.49 kB)
#> + purrr                      1.0.2       ⬇ (524.51 kB)
#> + quantmod                   0.4.25      ⬇ (1.06 MB)
#> + R6                         2.5.1       ⬇ (83.05 kB)
#> + rappdirs                   0.3.3       ⬇ (47.30 kB)
#> + RColorBrewer               1.1-3
#> + Rcpp                       1.0.11      ⬇ (3.31 MB)
#> + reactable                  0.4.4       ⬇ (1.06 MB)
#> + reactR                     0.4.4       ⬇ (612.72 kB)
#> + readr                      2.1.4
#> + readxl                     1.4.3       ⬇ (1.56 MB)
#> + rematch                    1.0.1
#> + rematch2                   2.1.2       ⬇ (45.50 kB)
#> + rJava                      1.0-6
#> + rjson                      0.2.21
#> + rlang                      1.1.1       ⬇ (1.89 MB)
#> + rlist                      0.4.6.2
#> + rmarkdown                  2.24        ⬇ (2.61 MB)
#> + rprojroot                  2.0.3       ⬇ (100.78 kB)
#> + rstudioapi                 0.15.0      ⬇ (299.49 kB)
#> + rvest                      1.0.3
#> + sass                       0.4.7       ⬇ (2.41 MB)
#> + scales                     1.2.1
#> + selectr                    0.4-2
#> + snakecase                  0.11.0
#> + stringi                    1.7.12      ⬇ (14.63 MB)
#> + stringr                    1.5.0       ⬇ (311.21 kB)
#> + svglite                    2.1.1
#> + sys                        3.4.2       ⬇ (51.52 kB)
#> + systemfonts                1.0.4       ⬇ (6.85 MB)
#> + tabulapdf                  0.2.3      👷🏿‍♀️🔧 (GitHub: 08e3d76)
#> + tabulapdfjars              1.0.1      👷🏽‍♀️🔧 (GitHub: d1924e0)
#> + tibble                     3.2.1       ⬇ (682.28 kB)
#> + tidyr                      1.3.0
#> + tidyselect                 1.2.0
#> + timechange                 0.2.0
#> + tinytex                    0.46        ⬇ (134.90 kB)
#> + TTR                        0.24.3
#> + tzdb                       0.4.0
#> + utf8                       1.2.3       ⬇ (210.11 kB)
#> + V8                         4.3.3       ⬇ (9.66 MB)
#> + vctrs                      0.6.3       ⬇ (1.97 MB)
#> + viridisLite                0.4.2
#> + vroom                      1.6.3
#> + webshot                    0.5.5
#> + withr                      2.5.0       ⬇ (230.91 kB)
#> + xfun                       0.40        ⬇ (439.12 kB)
#> + XML                        3.99-0.14
#> + xml2                       1.3.5       ⬇ (478.13 kB)
#> + xts                        0.13.1
#> + yaml                       2.3.7       ⬇ (228.15 kB)
#> + zoo                        1.8-12
#> ℹ Getting 77 pkgs (100.22 MB), 47 (41.21 MB) cached
#> ✔ Cached copy of ggthemes 4.2.4 (x86_64-apple-darwin20) is the latest build
#> ✔ Cached copy of highcharter 0.9.4 (x86_64-apple-darwin20) is the latest build
#> ✔ Got askpass 1.1 (x86_64-apple-darwin20) (23.20 kB)
#> ✔ Got assertthat 0.2.1 (x86_64-apple-darwin20) (53.06 kB)
#> ✔ Got R6 2.5.1 (x86_64-apple-darwin20) (83.05 kB)
#> ✔ Got commonmark 1.9.0 (x86_64-apple-darwin20) (357.18 kB)
#> ✔ Got TTR 0.24.3 (x86_64-apple-darwin20) (543.86 kB)
#> ✔ Got ellipsis 0.3.2 (x86_64-apple-darwin20) (39.03 kB)
#> ✔ Got clipr 0.8.0 (x86_64-apple-darwin20) (51.12 kB)
#> ✔ Got generics 0.1.3 (x86_64-apple-darwin20) (78.88 kB)
#> ✔ Got callr 3.7.3 (x86_64-apple-darwin20) (431.09 kB)
#> ✔ Got curl 5.0.2 (x86_64-apple-darwin20) (811.87 kB)
#> ✔ Got bookdown 0.35 (x86_64-apple-darwin20) (1.09 MB)
#> ✔ Got fastmap 1.1.1 (x86_64-apple-darwin20) (201.10 kB)
#> ✔ Got hms 1.1.3 (x86_64-apple-darwin20) (99.18 kB)
#> ✔ Got cli 3.6.1 (x86_64-apple-darwin20) (1.38 MB)
#> ✔ Got fontawesome 0.5.2 (x86_64-apple-darwin20) (1.36 MB)
#> ✔ Got gridtext 0.1.5 (x86_64-apple-darwin20) (955.55 kB)
#> ✔ Got labeling 0.4.2 (x86_64-apple-darwin20) (61.26 kB)
#> ✔ Got ggtext 0.1.2 (x86_64-apple-darwin20) (1.26 MB)
#> ✔ Got jquerylib 0.1.4 (x86_64-apple-darwin20) (526.36 kB)
#> ✔ Got htmlwidgets 1.6.2 (x86_64-apple-darwin20) (803.88 kB)
#> ✔ Got markdown 1.8 (x86_64-apple-darwin20) (196.68 kB)
#> ✔ Got mime 0.12 (x86_64-apple-darwin20) (36.62 kB)
#> ✔ Got juicyjuice 0.1.0 (x86_64-apple-darwin20) (1.13 MB)
#> ✔ Got lubridate 1.9.2 (x86_64-apple-darwin20) (999.72 kB)
#> ✔ Got Rcpp 1.0.11 (x86_64-apple-darwin20) (3.31 MB)
#> ✔ Got ps 1.7.5 (x86_64-apple-darwin20) (314.49 kB)
#> ✔ Got rappdirs 0.3.3 (x86_64-apple-darwin20) (47.30 kB)
#> ✔ Got pillar 1.9.0 (x86_64-apple-darwin20) (648.66 kB)
#> ✔ Got rematch 1.0.1 (x86_64-apple-darwin20) (12.64 kB)
#> ✔ Got prismatic 1.1.1 (x86_64-apple-darwin20) (788.48 kB)
#> ✔ Got rlist 0.4.6.2 (x86_64-apple-darwin20) (251.46 kB)
#> ✔ Got rstudioapi 0.15.0 (x86_64-apple-darwin20) (299.49 kB)
#> ✔ Got quantmod 0.4.25 (x86_64-apple-darwin20) (1.06 MB)
#> ✔ Got reactable 0.4.4 (x86_64-apple-darwin20) (1.06 MB)
#> ✔ Got sys 3.4.2 (x86_64-apple-darwin20) (51.52 kB)
#> ✔ Got stringr 1.5.0 (x86_64-apple-darwin20) (311.21 kB)
#> ✔ Got gtExtras 0.4.5 (x86_64-apple-darwin20) (4.19 MB)
#> ✔ Got scales 1.2.1 (x86_64-apple-darwin20) (615.92 kB)
#> ✔ Got bslib 0.5.1 (x86_64-apple-darwin20) (5.90 MB)
#> ✔ Got timechange 0.2.0 (x86_64-apple-darwin20) (870.81 kB)
#> ✔ Got withr 2.5.0 (x86_64-apple-darwin20) (230.91 kB)
#> ✔ Got openssl 2.1.0 (x86_64-apple-darwin20) (2.89 MB)
#> ✔ Got tidyr 1.3.0 (x86_64-apple-darwin20) (1.34 MB)
#> ✔ Got backports 1.4.1 (x86_64-apple-darwin20) (102.61 kB)
#> ✔ Got rlang 1.1.1 (x86_64-apple-darwin20) (1.89 MB)
#> ✔ Got cachem 1.0.8 (x86_64-apple-darwin20) (69.43 kB)
#> ✔ Got xml2 1.3.5 (x86_64-apple-darwin20) (478.13 kB)
#> ✔ Got evaluate 0.21 (x86_64-apple-darwin20) (81.80 kB)
#> ✔ Got tzdb 0.4.0 (x86_64-apple-darwin20) (1.27 MB)
#> ✔ Got fansi 1.0.4 (x86_64-apple-darwin20) (387.75 kB)
#> ✔ Got glue 1.6.2 (x86_64-apple-darwin20) (156.74 kB)
#> ✔ Got highr 0.10 (x86_64-apple-darwin20) (38.98 kB)
#> ✔ Got viridisLite 0.4.2 (x86_64-apple-darwin20) (1.30 MB)
#> ✔ Got fs 1.6.3 (x86_64-apple-darwin20) (625.41 kB)
#> ✔ Got httr 1.4.7 (x86_64-apple-darwin20) (474.94 kB)
#> ✔ Got bigD 0.2.0 (x86_64-apple-darwin20) (1.16 MB)
#> ✔ Got memoise 2.0.1 (x86_64-apple-darwin20) (47.96 kB)
#> ✔ Got munsell 0.5.0 (x86_64-apple-darwin20) (243.42 kB)
#> ✔ Got readxl 1.4.3 (x86_64-apple-darwin20) (1.56 MB)
#> ✔ Got bit 4.0.5 (x86_64-apple-darwin20) (1.29 MB)
#> ✔ Got processx 3.8.2 (x86_64-apple-darwin20) (316.26 kB)
#> ✔ Got rvest 1.0.3 (x86_64-apple-darwin20) (212.30 kB)
#> ✔ Got purrr 1.0.2 (x86_64-apple-darwin20) (524.51 kB)
#> ✔ Got tidyselect 1.2.0 (x86_64-apple-darwin20) (222.38 kB)
#> ✔ Got base64enc 0.1-3 (x86_64-apple-darwin20) (34.81 kB)
#> ✔ Got utf8 1.2.3 (x86_64-apple-darwin20) (210.11 kB)
#> ✔ Got selectr 0.4-2 (x86_64-apple-darwin20) (488.55 kB)
#> ✔ Got crayon 1.5.2 (x86_64-apple-darwin20) (162.31 kB)
#> ✔ Got knitr 1.43 (x86_64-apple-darwin20) (1.47 MB)
#> ✔ Got xfun 0.40 (x86_64-apple-darwin20) (439.12 kB)
#> ✔ Got lifecycle 1.0.3 (x86_64-apple-darwin20) (123.60 kB)
#> ✔ Got pkgconfig 2.0.3 (x86_64-apple-darwin20) (18.18 kB)
#> ✔ Got forcats 1.0.0 (x86_64-apple-darwin20) (422.45 kB)
#> ✔ Got gtable 0.3.4 (x86_64-apple-darwin20) (218.00 kB)
#> ✔ Got htmltools 0.5.6 (x86_64-apple-darwin20) (355.65 kB)
#> ✔ Got rprojroot 2.0.3 (x86_64-apple-darwin20) (100.78 kB)
#> ✔ Got rjson 0.2.21 (x86_64-apple-darwin20) (214.58 kB)
#> ✔ Got tibble 3.2.1 (x86_64-apple-darwin20) (682.28 kB)
#> ✔ Got bitops 1.0-7 (x86_64-apple-darwin20) (32.51 kB)
#> ✔ Got reactR 0.4.4 (x86_64-apple-darwin20) (612.72 kB)
#> ✔ Got V8 4.3.3 (x86_64-apple-darwin20) (9.66 MB)
#> ✔ Got jsonlite 1.8.7 (x86_64-apple-darwin20) (1.13 MB)
#> ✔ Got readr 2.1.4 (x86_64-apple-darwin20) (1.97 MB)
#> ✔ Got jpeg 0.1-10 (x86_64-apple-darwin20) (455.37 kB)
#> ✔ Got cellranger 1.1.0 (x86_64-apple-darwin20) (101.94 kB)
#> ✔ Got paletteer 1.5.0 (x86_64-apple-darwin20) (436.69 kB)
#> ✔ Got rematch2 2.1.2 (x86_64-apple-darwin20) (45.50 kB)
#> ✔ Got digest 0.6.33 (x86_64-apple-darwin20) (297.88 kB)
#> ✔ Got yaml 2.3.7 (x86_64-apple-darwin20) (228.15 kB)
#> ✔ Got rmarkdown 2.24 (x86_64-apple-darwin20) (2.61 MB)
#> ✔ Got magrittr 2.0.3 (x86_64-apple-darwin20) (232.37 kB)
#> ✔ Got tinytex 0.46 (x86_64-apple-darwin20) (134.90 kB)
#> ✔ Got vctrs 0.6.3 (x86_64-apple-darwin20) (1.97 MB)
#> ✔ Got igraph 1.5.1 (x86_64-apple-darwin20) (9.38 MB)
#> ✔ Got ggplot2 3.4.3 (x86_64-apple-darwin20) (3.34 MB)
#> ✔ Got sass 0.4.7 (x86_64-apple-darwin20) (2.41 MB)
#> ✔ Got systemfonts 1.0.4 (x86_64-apple-darwin20) (6.85 MB)
#> ✔ Got stringi 1.7.12 (x86_64-apple-darwin20) (14.63 MB)
#> ✔ Installed bwu 0.0.1.9002 (github::brainworkup/bwu@27ae68c) (216ms)
#> ✔ Installed R6 2.5.1  (276ms)
#> ✔ Installed RColorBrewer 1.1-3  (311ms)
#> ✔ Installed TTR 0.24.3  (332ms)
#> ✔ Installed askpass 1.1  (343ms)
#> ✔ Installed assertthat 0.2.1  (385ms)
#> ✔ Installed backports 1.4.1  (409ms)
#> ✔ Installed base64enc 0.1-3  (444ms)
#> ✔ Installed bigD 0.2.0  (469ms)
#> ✔ Installed bit64 4.0.5  (497ms)
#> ✔ Installed Rcpp 1.0.11  (613ms)
#> ✔ Installed V8 4.3.3  (669ms)
#> ✔ Installed XML 3.99-0.14  (712ms)
#> ✔ Installed bit 4.0.5  (706ms)
#> ✔ Installed bitops 1.0-7  (702ms)
#> ✔ Installed bookdown 0.35  (749ms)
#> ✔ Installed broom 1.0.5  (365ms)
#> ✔ Installed cachem 1.0.8  (26ms)
#> ✔ Installed callr 3.7.3  (52ms)
#> ✔ Installed cellranger 1.1.0  (28ms)
#> ✔ Installed bslib 0.5.1  (347ms)
#> ✔ Installed cli 3.6.1  (129ms)
#> ✔ Installed clipr 0.8.0  (91ms)
#> ✔ Installed commonmark 1.9.0  (29ms)
#> ✔ Installed colorspace 2.1-0  (144ms)
#> ✔ Installed crayon 1.5.2  (69ms)
#> ✔ Installed curl 5.0.2  (69ms)
#> ✔ Installed digest 0.6.33  (52ms)
#> ✔ Installed data.table 1.14.8  (159ms)
#> ✔ Installed dplyr 1.1.2  (86ms)
#> ✔ Installed ellipsis 0.3.2  (127ms)
#> ✔ Installed evaluate 0.21  (137ms)
#> ✔ Installed fansi 1.0.4  (85ms)
#> ✔ Installed farver 2.1.1  (74ms)
#> ✔ Installed fastmap 1.1.1  (79ms)
#> ✔ Installed fontawesome 0.5.2  (100ms)
#> ✔ Installed forcats 1.0.0  (107ms)
#> ✔ Installed fs 1.6.3  (101ms)
#> ✔ Installed generics 0.1.3  (85ms)
#> ✔ Installed ggplot2 3.4.3  (73ms)
#> ✔ Installed ggtext 0.1.2  (104ms)
#> ✔ Installed ggthemes 4.2.4  (67ms)
#> ✔ Installed glue 1.6.2  (66ms)
#> ✔ Installed gridtext 0.1.5  (68ms)
#> ✔ Installed gtExtras 0.4.5  (64ms)
#> ✔ Installed gt 0.9.0  (76ms)
#> ✔ Installed gtable 0.3.4  (69ms)
#> ✔ Installed here 1.0.1  (67ms)
#> ✔ Installed highr 0.10  (43ms)
#> ✔ Installed highcharter 0.9.4  (186ms)
#> ✔ Installed hms 1.1.3  (119ms)
#> ✔ Installed htmltools 0.5.6  (69ms)
#> ✔ Installed htmlwidgets 1.6.2  (79ms)
#> ✔ Installed httr 1.4.7  (76ms)
#> ✔ Installed isoband 0.2.7  (41ms)
#> ✔ Installed janitor 2.2.0  (47ms)
#> ✔ Installed igraph 1.5.1  (222ms)
#> ✔ Installed jpeg 0.1-10  (65ms)
#> ✔ Installed jquerylib 0.1.4  (82ms)
#> ✔ Installed jsonlite 1.8.7  (133ms)
#> ✔ Installed juicyjuice 0.1.0  (76ms)
#> ✔ Installed kableExtra 1.3.4  (89ms)
#> ✔ Installed labeling 0.4.2  (22ms)
#> ✔ Installed knitr 1.43  (135ms)
#> ✔ Installed lifecycle 1.0.3  (109ms)
#> ✔ Installed lubridate 1.9.2  (90ms)
#> ✔ Installed magrittr 2.0.3  (86ms)
#> ✔ Installed markdown 1.8  (86ms)
#> ✔ Installed memoise 2.0.1  (117ms)
#> ✔ Installed mime 0.12  (129ms)
#> ✔ Installed munsell 0.5.0  (76ms)
#> ✔ Installed paletteer 1.5.0  (29ms)
#> ✔ Installed openssl 2.1.0  (132ms)
#> ✔ Installed pillar 1.9.0  (95ms)
#> ✔ Installed pkgconfig 2.0.3  (68ms)
#> ✔ Installed png 0.1-8  (71ms)
#> ✔ Installed prismatic 1.1.1  (75ms)
#> ✔ Installed processx 3.8.2  (75ms)
#> ✔ Installed ps 1.7.5  (96ms)
#> ✔ Installed purrr 1.0.2  (79ms)
#> ✔ Installed quantmod 0.4.25  (77ms)
#> ✔ Installed rappdirs 0.3.3  (65ms)
#> ✔ Installed reactR 0.4.4  (73ms)
#> ✔ Installed reactable 0.4.4  (79ms)
#> ✔ Installed readr 2.1.4  (99ms)
#> ✔ Installed readxl 1.4.3  (86ms)
#> ✔ Installed rematch2 2.1.2  (75ms)
#> ✔ Installed rematch 1.0.1  (96ms)
#> ✔ Installed rjson 0.2.21  (111ms)
#> ✔ Installed rlang 1.1.1  (75ms)
#> ✔ Installed rlist 0.4.6.2  (67ms)
#> ✔ Installed rprojroot 2.0.3  (27ms)
#> ✔ Installed rmarkdown 2.24  (161ms)
#> ✔ Installed rstudioapi 0.15.0  (107ms)
#> ✔ Installed rvest 1.0.3  (87ms)
#> ✔ Installed sass 0.4.7  (82ms)
#> ✔ Installed scales 1.2.1  (83ms)
#> ✔ Installed selectr 0.4-2  (132ms)
#> ✔ Installed snakecase 0.11.0  (107ms)
#> ✔ Installed stringr 1.5.0  (42ms)
#> ✔ Installed svglite 2.1.1  (48ms)
#> ✔ Installed sys 3.4.2  (25ms)
#> ✔ Installed stringi 1.7.12  (284ms)
#> ✔ Installed tibble 3.2.1  (66ms)
#> ✔ Installed systemfonts 1.0.4  (191ms)
#> ✔ Installed tidyr 1.3.0  (88ms)
#> ✔ Installed tidyselect 1.2.0  (108ms)
#> ✔ Installed timechange 0.2.0  (105ms)
#> ✔ Installed tinytex 0.46  (74ms)
#> ✔ Installed tzdb 0.4.0  (64ms)
#> ✔ Installed utf8 1.2.3  (65ms)
#> ✔ Installed vctrs 0.6.3  (75ms)
#> ✔ Installed viridisLite 0.4.2  (87ms)
#> ✔ Installed webshot 0.5.5  (47ms)
#> ✔ Installed vroom 1.6.3  (137ms)
#> ✔ Installed withr 2.5.0  (70ms)
#> ✔ Installed xfun 0.40  (113ms)
#> ✔ Installed xml2 1.3.5  (94ms)
#> ✔ Installed xts 0.13.1  (85ms)
#> ✔ Installed yaml 2.3.7  (63ms)
#> ✔ Installed zoo 1.8-12  (62ms)
#> ✔ Installed tabulapdf 0.2.3 (github::ropensci/tabulapdf@08e3d76) (66ms)
#> ✔ Installed rJava 1.0-6  (79ms)
#> ✔ Installed tabulapdfjars 1.0.1 (github::ropensci/tabulapdfjars@d1924e0) (110ms)
#> ✔ 1 pkg + 128 deps: kept 4, upd 1, added 123, dld 98 (110.65 MB) [29.8s]
```

## Example

This is a basic example which shows you how to solve a common problem:

```r
library(bwu)
#> Registered S3 method overwritten by 'quantmod':
#>   method            from
#>   as.zoo.data.frame zoo
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

```r
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

---

<!-- README.md is generated from README.Rmd. Please edit that file -->
