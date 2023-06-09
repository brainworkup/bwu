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
  "Bicycle Drawing",
  # RBANS
  "Visuospatial/Constructional Index",
  "Figure Copy",
  "Line Orientation"
)

## ---- 02-glue-spatial ---------------------
xfun::cache_rds({
  dt <-
    neurocog |>
    tidytable::filter(scale %in% filter_domain) |>
    tidytable::arrange(desc(percentile)) |>
    tidytable::distinct(.keep_all = FALSE)

  dt |>
    glue::glue_data() |>
    purrr::modify(purrr::lift(paste0)) |>
    cat(dt$result,
      file = "02.05_spatial.md",
      fill = TRUE,
      append = TRUE
    )
})

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
  kableExtra::footnote("(ref:fn-spt)")

## ---- 05-df-spatial -----------------------------
spatial <-
  neurocog |>
  tidytable::filter(domain == "Visual Perception/Construction") |>
  tidytable::filter(!is.na(percentile)) |>
  tidytable::arrange(test_name) |>
  tidytable::filter(scale %in% filter_domain)

## ---- 06-plot-subdomain-spatial ------------------
ggplot2::ggplot(data = spatial) +
  geom_segment(
    aes(x = z_mean_sub,
        y = reorder(subdomain, z_mean_sub),
        xend = 0,
        yend = subdomain),
    linewidth = 0.5) +
  geom_point(
    aes(x = z_mean_sub, y = reorder(subdomain, z_mean_sub)),
    shape = 21,
    linewidth = 0.5,
    color = "black",
    fill =
      c("#190D33", "#27123A", "#351742", "#421E4A", "#502653",
        "#5C2E5A", "#683863", "#73436A", "#7B4E70", "#815875",
        "#866079", "#89697D", "#8B7280", "#8C7A81", "#8E8385",
        "#908A87", "#919289", "#929A8A", "#94A38D", "#96AB8F",
        "#99B392", "#9CBD95", "#A2C79A", "#ACD3A0", "#B9DFA9",
        "#C8EAB3", "#D8F2BD", "#E6F9C7", "#F3FCD0", "#FEFED8"),
    k = length(unique(spatial$subdomain)),
    size = 6
  ) +
  theme_fivethirtyeight() +
  theme(panel.background = element_rect(fill = "white")) +
  theme(plot.background = element_rect(fill = "white")) +
  theme(panel.border = element_rect(color = "white"))

## ---- 07-plot-narrow-spatial --------------------
bwu::dotplot(
  data = df,
  x = df$z_mean_narrow,
  y = df$narrow,
  domain = "spatial"
)
