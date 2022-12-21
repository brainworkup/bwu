## ---- 01-filter-iq -------------
filter_domain <- c(
  ## ACS TOPF
  "Test of Premorbid Functioning",
  "TOPF Standard Score",
  ## WRAT5 Word Reading
  "Word Reading",
  ## NAB
  "NAB Total Index",
  ## RBANS
  "RBANS Total Index",
  ## WISC/WAIS/WPPSI
  "Full Scale IQ (FSIQ)",
  "General Ability (GAI)",
  "Cognitive Proficiency (CPI)",
  "Verbal Comprehension (VCI)",
  "Perceptual Reasoning (PRI)",
  "Fluid Reasoning (FRI)",
  "Visual Spatial (VSI)",
  "Vocabulary Acquisition (VAI)",
  "Nonverbal (NVI)",
  "Processing Speed (PSI)",
  "Working Memory (WMI)"
)

## ---- 02-glue-iq ------------
dt <-
  neurocog |>
  tidytable::filter(scale %in% filter_domain) |>
  tidytable::arrange(desc(percentile)) |>
  tidytable::distinct(.keep_all = FALSE)

dt |>
  glue::glue_data() |>
  purrr::modify(purrr::lift(paste0)) |>
  cat(dt$result,
    file = "2.2_iq.md",
    fill = TRUE,
    append = TRUE
  )

## ---- 03-table-iq ------------
tb <-
  bwu::make_tibble(
    tibb = tb,
    data = neurocog,
    pheno = "Intelligence/General Ability"
  ) |>
  tidytable::filter(Scale %in% filter_domain) |>
  tidytable::arrange(Test)

## ---- 04-kable-iq ------------------
kableExtra::kbl(
  tb[, 1:4],
  "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc"),
  caption = "(ref:iq)"
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
  kableExtra::add_footnote("(ref:fn-iq)")

## ---- 05-df-iq ------------
df <-
  neurocog |>
  tidytable::filter(domain == "Intelligence/General Ability") |>
  tidytable::filter(!is.na(percentile)) |>
  tidytable::arrange(test_name) |>
  tidytable::filter(scale %in% filter_domain) |>
  tidytable::filter(scale != "NAB Total Index") |>
  tidytable::filter(scale != "TOPF Standard Score") |>
  tidytable::filter(scale != "Working Memory (WMI)") |>
  tidytable::filter(scale != "Processing Speed (PSI)")
# tidytable::filter(scale != "Cognitive Proficiency (CPI)") |>
# tidytable::filter(scale != "General Ability (GAI)") |>

## ---- 06-plot-subdomain-iq --------------------
bwu::dotplot(
  data = df,
  x = df$z_mean_sub,
  y = df$subdomain,
  domain = "iq"
)

## ---- 07-plot-narrow-iq -------------------
bwu::dotplot(
  data = df,
  x = df$z_mean_narrow,
  y = df$narrow,
  domain = "iq"
)
