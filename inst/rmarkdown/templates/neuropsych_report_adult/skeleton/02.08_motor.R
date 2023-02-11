## ---- 01-filter-motor -------------
filter_domain <- c(
  # Grooved Pegboard
  "Right-Hand Time",
  "Left-Hand Time",
  "Dominant Hand",
  "Nondominant Hand",
  # NEPSY-2
  "Fingertip Tapping Dominant Hand",
  "Fingertip Tapping Nondominant Hand",
  "Fingertip Tapping Repetitions",
  "Fingertip Tapping Sequences",
  "FT Dominant Hand vs. Nondominant Hand",
  "Dominant vs. Nondominant",
  "Repetitions vs. Sequences",
  "Imitating Hand Positions",
  "Imitating Hand Positions-Dominant",
  "Imitating Hand Positions-Nondominant",
  "Visuomotor Precision"
  # "Visuomotor Precision Time",
  # "Visuomotor Precision Errors",
  # "Visuomotor Precision Pencil Lifts"
)

## ---- 02-glue-motor ------------
dt <-
  neurocog |>
  tidytable::filter(scale %in% filter_domain) |>
  tidytable::arrange(desc(percentile)) |>
  tidytable::distinct(.keep_all = FALSE)

dt |>
  glue::glue_data() |>
  purrr::modify(purrr::lift(paste0)) |>
  cat(dt$result,
    file = "2.8_motor.md",
    fill = TRUE,
    append = TRUE
  )

## ---- 03-table-motor ------------
tb <-
  bwu::make_tibble(
    tibb = motor,
    data = neurocog,
    pheno = "Motor"
  ) |>
  tidytable::filter(Scale %in% filter_domain) |>
  tidytable::arrange(Test)

## ---- 04-kable-motor ------------------
kableExtra::kbl(
  tb[, 1:4],
  "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc"),
  caption = "(ref:motor)"
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
  kableExtra::add_footnote("(ref:fn-mtr)")

## ---- 05-df-motor ------------
df <-
  neurocog |>
  tidytable::filter(domain == "Motor") |>
  tidytable::filter(!is.na(percentile)) |>
  tidytable::arrange(test_name) |>
  tidytable::filter(scale %in% filter_domain)

## ---- 06-plot-subdomain-motor -----------------
bwu::dotplot(
  data = df,
  x = df$z_mean_sub,
  y = df$subdomain,
  domain = "motor"
)

## ---- 07-plot-narrow-motor -------------------
bwu::dotplot(
  data = df,
  x = df$z_mean_narrow,
  y = df$narrow,
  domain = "motor"
)
