## ---- 01-filter-adaptive -------------
filter_domain <- c(
  ### adaptive
  "General Adaptive Composite",
  "Conceptual Skills Index",
  "Communication",
  "Functional Academics",
  "Self-Direction",
  "adaptive Skills Index",
  "Leisure",
  "adaptive",
  "Practical Skills Index",
  "Community Use",
  "School Living",
  "Home Living",
  "Health and Safety",
  "Self-Care",
  "Work"
)

## ---- 02-glue-adaptive ------------
xfun::cache_rds({
  dt <-
    neurobehav |>
    tidytable::filter(scale %in% filter_domain) |>
    tidytable::arrange(desc(percentile)) |>
    tidytable::distinct(.keep_all = FALSE)

  dt |>
    glue::glue_data() |>
    purrr::modify(purrr::lift(paste0)) |>
    cat(dt$result,
      file = "02.09_adaptive.md",
      fill = TRUE,
      append = TRUE
    )
})

## ---- 03-table-adaptive ------------
tb <-
  bwu::make_tibble(
    tibb = adaptive,
    data = neurobehav,
    pheno = "Adaptive Functioning"
  ) |>
  tidytable::filter(Scale %in% filter_domain) |>
  tidytable::arrange(Test)

## ---- 04-kable-adaptive ------------------
kableExtra::kbl(
  tb[, 1:4],
  "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc"),
  caption = "(ref:adaptive)"
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
  kableExtra::add_footnote("(ref:fn-adaptive)")

## ---- 05-df-adaptive ------------
df <-
  neurobehav |>
  tidytable::filter(domain == "Adaptive Functioning") |>
  tidytable::filter(!is.na(percentile)) |>
  tidytable::arrange(test_name) |>
  tidytable::filter(scale %in% filter_domain)

## ---- 06-plot-subdomain-adaptive -----------------
bwu::dotplot(
  data = df,
  x = df$z_mean_sub,
  y = df$subdomain,
  domain = "adaptive"
)

## ---- 07-plot-narrow-adaptive -------------------
bwu::dotplot(
  data = df,
  x = df$z_mean_narrow,
  y = df$narrow,
  domain = "adaptive"
)
