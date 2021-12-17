## ---- 01-filter-spatial ---------
filter_domain <- c(
  # NAB
  "Spatial Domain",
  "NAB Spatial Index",
  "Visual Discrimination",
  "Design Construction",
  # WAIS/WISC/WPPSI
  "Block Design",
  "Block Design No Time Bonus",
  "Matrix Reasoning",
  "Figure Weights",
  "Visual Puzzles",
  "Object Assembly",
  "Picture Concepts",
  # RCFT
  "RCFT Copy",
  # NEPSY
  "Design Copying",
  "Arrows",
  "Geometric Puzzles"
)

## ---- 02-glue-spatial ---------------------
dt <-
  neurocog %>%
  dplyr::filter(scale %in% filter_domain) %>%
  dplyr::arrange(desc(percentile)) %>%
  dplyr::distinct(.keep_all = FALSE)

dt %>%
  glue::glue_data() %>%
  purrr::modify(lift(paste0)) %>%
  cat(dt$result,
    file = "2_spatial.md",
    fill = TRUE,
    append = TRUE
  )

## ---- 03-table-spatial ------------
tb <-
  make_tibble(
    tibb = spatial,
    data = neurocog,
    pheno = "Visual Perception/Construction"
  ) %>%
  filter(Scale %in% filter_domain) %>%
  arrange(Test)

## ---- 04-kable-spatial -----------------
kableExtra::kbl(
  tb[, 2:5],
  "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc"),
  caption = "(ref:spatial)"
) %>%
  kableExtra::kable_paper(., lightable_options = "basic") %>%
  kableExtra::kable_styling(., latex_options = c(
    "scale_down",
    "HOLD_position",
    "striped"
  )) %>%
  kableExtra::column_spec(., 1, width = "8cm") %>%
  kableExtra::pack_rows(., index = table(tb$Test)) %>%
  kableExtra::row_spec(., row = 0, bold = TRUE) %>%
  kableExtra::add_footnote("(ref:fn-spt)")

## ---- 05-df-spatial -----------------------------
df <-
  neurocog %>%
  filter(domain == "Visual Perception/Construction") %>%
  filter(!is.na(percentile)) %>%
  arrange(test_name) %>%
  filter(scale %in% filter_domain)

## ---- 06-plot-subdomain-spatial ------------------
dotplot(
  data = df,
  x = df$z_mean_sub,
  y = df$subdomain,
  domain = "spatial"
)

## ---- 07-plot-narrow-spatial --------------------
dotplot(
  data = df,
  x = df$z_mean_narrow,
  y = df$narrow,
  domain = "spatial"
)
