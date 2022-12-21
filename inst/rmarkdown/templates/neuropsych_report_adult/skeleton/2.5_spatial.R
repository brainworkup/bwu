## ---- 01-filter-spatial ---------
filter_domain <- c(
  # NAB
  "Spatial Domain",
  "NAB Spatial Index",
  "Visual Discrimination",
  "Design Construction",
  "Figure Drawing Copy",
  "Map Reading",
  # WAIS/WISC/WPPSI
  "Block Design",
  "Block Design No Time Bonus",
  "Block Design Partial Score",
  "Matrix Reasoning",
  "Figure Weights",
  "Visual Puzzles",
  "Object Assembly",
  "Picture Concepts",
  # ROCFT
  "ROCF Copy",
  "ROCFT Copy",
  # NEPSY
  "Design Copying",
  "Design Copying General",
  "Design Copying Process",
  "Design Copying Motor",
  "Arrows",
  "Geometric Puzzles",
  "Clocks",
  "Clock Drawing",
  "Bicycle Drawing"
)

## ---- 02-glue-spatial ---------------------
dt <-
  neurocog |>
  tidytable::filter(scale %in% filter_domain) |>
  tidytable::arrange(desc(percentile)) |>
  tidytable::distinct(.keep_all = FALSE)

dt |>
  glue::glue_data() |>
  purrr::modify(purrr::lift(paste0)) |>
  cat(dt$result,
    file = "2.5_spatial.md",
    fill = TRUE,
    append = TRUE
  )

## ---- 03-table-spatial ------------
tb <-
  bwu::make_tibble(
    tibb = tb,
    data = neurocog,
    pheno = "Visual Perception/Construction"
  ) |>
  tidytable::filter(Scale %in% filter_domain) |>
  tidytable::arrange(Test)

## ---- 04-kable-spatial -----------------
kableExtra::kbl(
  tb[, 1:4],
  "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc"),
  caption = "(ref:spatial)"
) |>
  kableExtra::kable_paper(lightable_options = "basic") |>
  kableExtra::kable_styling(latex_options = c(
    "scale_down",
    "HOLD_position",
    "striped"
  )) |>
  kableExtra::column_spec(1, width = "8cm") |>
  kableExtra::pack_rows(index = table(tb$Test)) |>
  kableExtra::row_spec(row = 0, bold = TRUE) |>
  kableExtra::add_footnote("(ref:fn-spt)")

## ---- 05-df-spatial -----------------------------
df <-
  neurocog |>
  tidytable::filter(domain == "Visual Perception/Construction") |>
  tidytable::filter(!is.na(percentile)) |>
  tidytable::arrange(test_name) |>
  tidytable::filter(scale %in% filter_domain)

## ---- 06-plot-subdomain-spatial ------------------
bwu::dotplot(
  data = df,
  x = df$z_mean_sub,
  y = df$subdomain,
  domain = "spatial"
)

## ---- 07-plot-narrow-spatial --------------------
bwu::dotplot(
  data = df,
  x = df$z_mean_narrow,
  y = df$narrow,
  domain = "spatial"
)
