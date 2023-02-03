## ---- 01-filter-adhd ----
filter_domain <- c(
  # Brown Scales
  "Activation",
  "Focus",
  "Effort",
  "Emotion",
  "Memory",
  "Action",
  "Total Composite",
  # CAARS
  "ADHD Index",
  "Inattention/Memory Problems",
  "Hyperactivity/Restlessness",
  "Impulsivity/Emotional Lability",
  "Problems with Self-Concept",
  "DSM-5 Inattentive Symptoms",
  "DSM-5 Hyperactive-Impulsive Symptoms",
  "DSM-5 ADHD Symptoms Total",
  # CEFI
  "Full Scale",
  "Attention",
  "Emotion Regulation",
  "Flexibility",
  "Inhibitory Control",
  "Initiation",
  "Organization",
  "Planning",
  "Self-Monitoring",
  "Working Memory"
)

## ---- 02-glue-adhd-sr ----
dt <-
  neurobehav |>
  tidytable::filter(scale %in% filter_domain) |>
  tidytable::filter(test == "cefi_sr" | test == "caars_sr") |>
  tidytable::arrange(desc(percentile)) |>
  tidytable::distinct(.keep_all = FALSE)

dt |>
  glue::glue_data() |>
  purrr::modify(purrr::lift(paste0)) |>
  cat(dt$result,
    file = "2.10_adhd.md",
    fill = TRUE,
    append = TRUE
  )

## ---- 02-glue-adhd-or -----
dt <-
  neurobehav |>
  tidytable::filter(scale %in% filter_domain) |>
  tidytable::filter(test == "cefi_or" | test == "caars_or") |>
  tidytable::arrange(desc(percentile)) |>
  tidytable::distinct(.keep_all = FALSE)

dt |>
  glue::glue_data() |>
  purrr::modify(lift(paste0)) |>
  cat(dt$result,
    file = "2.10_adhd.md",
    fill = TRUE,
    append = TRUE
  )

## ---- 03-table-adhd ----
tb1 <-
  bwu::make_tibble(
    tibb = adhd,
    data = neurobehav,
    pheno = "ADHD"
  ) |>
  tidytable::filter(Scale %in% filter_domain) |>
  tidytable::arrange(Test)

## ---- 03-table-executive ----
tb2 <-
  bwu::make_tibble(
    tibb = adhd,
    data = neurobehav,
    pheno = "Executive Functions"
  ) |>
  tidytable::filter(Scale %in% filter_domain) |>
  tidytable::arrange(Test)

## ---- 03-table-merge ----
tb <- rbind(tb1, tb2)

## ---- 04-kable-adhd ----
kableExtra::kbl(
  tb[, 1:4], "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc"),
  caption = "(ref:adhd-ef)"
) |>
  kableExtra::kable_paper(lightable_options = "basic") |>
  kableExtra::kable_styling(latex_options = c(
    "scale_down", "HOLD_position", "striped"
  )) |>
  kableExtra::column_spec(1, width = "8cm") |>
  kableExtra::pack_rows(index = table(tb$Test)) |>
  kableExtra::row_spec(row = 0, bold = TRUE) |>
  kableExtra::add_footnote("(ref:fn-adhd)")

## ---- 05-df-adhd ----
df <-
  neurobehav |>
  tidytable::filter(domain == "ADHD") |>
  tidytable::filter(scale %in% filter_domain) |>
  tidytable::filter(!is.na(percentile)) |>
  tidytable::filter(filename %in% c("caars_sr.csv", "caars_or.csv"))

## ---- 06-plot-adhd-adhd-subdomain ----
bwu::dotplot(
  data = df,
  x = df$z_mean_sub,
  y = df$subdomain,
  domain = "ADHD"
)

## ---- 06-plot-adhd-adhd-narrow ----
bwu::dotplot(
  data = df,
  x = df$z_mean_narrow,
  y = df$narrow,
  domain = "Executive Functions"
)

## ---- 07-df-adhd ----
df2 <-
  neurobehav |>
  tidytable::filter(domain == "Executive Functions") |>
  tidytable::filter(scale %in% filter_domain) |>
  tidytable::filter(!is.na(percentile)) |>
  tidytable::filter(filename %in% c("cefi_sr.csv", "cefi_or.csv"))

## ---- 08-plot-executive-adhd-subdomain -----
bwu::dotplot(
  data = df2,
  x = df2$z_mean_sub,
  y = df2$subdomain,
  domain = "Executive Functions"
)

## ---- 08-plot-executive-adhd-narrow -----
bwu::dotplot(
  data = df2,
  x = df2$z_mean_narrow,
  y = df2$narrow,
  domain = "Executive Functions"
)
