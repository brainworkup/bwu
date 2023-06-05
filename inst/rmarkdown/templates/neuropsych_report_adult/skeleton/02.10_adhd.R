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
  "Inattention/Memory Problems",
  "Hyperactivity/Restlessness",
  "Impulsivity/Emotional Lability",
  "Problems with Self-Concept",
  "DSM-5 Inattentive Symptoms",
  "DSM-5 Hyperactive-Impulsive Symptoms",
  "DSM-5 ADHD Symptoms Total",
  "ADHD Index",
  "CAARS-SR Inattention/Memory Problems",
  "CAARS-SR Hyperactivity/Restlessness",
  "CAARS-SR Impulsivity/Emotional Lability",
  "CAARS-SR Problems with Self-Concept",
  "CAARS-SR DSM-5 Inattentive Symptoms",
  "CAARS-SR DSM-5 Hyperactive-Impulsive Symptoms",
  "CAARS-SR DSM-5 ADHD Symptoms Total",
  "CAARS-SR ADHD Index",
  "CAARS-OR Inattention/Memory Problems",
  "CAARS-OR Hyperactivity/Restlessness",
  "CAARS-OR Impulsivity/Emotional Lability",
  "CAARS-OR Problems with Self-Concept",
  "CAARS-OR DSM-5 Inattentive Symptoms",
  "CAARS-OR DSM-5 Hyperactive-Impulsive Symptoms",
  "CAARS-OR DSM-5 ADHD Symptoms Total",
  "CAARS-OR ADHD Index",
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
  "Working Memory",
  "CEFI-SR Full Scale",
  "CEFI-SR Attention",
  "CEFI-SR Emotion Regulation",
  "CEFI-SR Flexibility",
  "CEFI-SR Inhibitory Control",
  "CEFI-SR Initiation",
  "CEFI-SR Organization",
  "CEFI-SR Planning",
  "CEFI-SR Self-Monitoring",
  "CEFI-SR Working Memory",
  "CEFI-OR Full Scale",
  "CEFI-OR Attention",
  "CEFI-OR Emotion Regulation",
  "CEFI-OR Flexibility",
  "CEFI-OR Inhibitory Control",
  "CEFI-OR Initiation",
  "CEFI-OR Organization",
  "CEFI-OR Planning",
  "CEFI-OR Self-Monitoring",
  "CEFI-OR Working Memory"
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
    file = "02.10_adhd.md",
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
  purrr::modify(purrr::lift(paste0)) |>
  cat(dt$result,
    file = "02.10_adhd.md",
    fill = TRUE,
    append = TRUE
  )

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
  domain = "ADHD"
)

## ---- 07-df-executive ----
df2 <-
  neurobehav |>
  tidytable::filter(domain == "Executive Functioning") |>
  tidytable::filter(scale %in% filter_domain) |>
  tidytable::filter(!is.na(percentile)) |>
  tidytable::filter(filename %in% c("cefi_sr.csv", "cefi_or.csv"))

## ---- 08-plot-executive-adhd-subdomain -----
bwu::dotplot(
  data = df2,
  x = df2$z_mean_sub,
  y = df2$subdomain,
  domain = "Executive Functioning"
)

## ---- 08-plot-executive-adhd-narrow -----
bwu::dotplot(
  data = df2,
  x = df2$z_mean_narrow,
  y = df2$narrow,
  domain = "Executive Functioning"
)

## ---- 03-table-adhd ----
df_adhd <-
  bwu::make_tibble(
    tibb = adhd,
    data = neurobehav,
    pheno = "ADHD"
  ) |>
  tidytable::filter(Scale %in% filter_domain) |>
  tidytable::arrange(Test)

## ---- 03-table-executive ----
df_ef <-
  bwu::make_tibble(
    tibb = adhd,
    data = neurobehav,
    pheno = "Executive Functioning"
  ) |>
  tidytable::filter(Scale %in% filter_domain) |>
  tidytable::arrange(Test)

## ---- 03-table-merge ----
df_adhd_ef <- rbind(df_adhd, df_ef)

## ---- 04-kable-adhd ----
df_adhd_ef <- df_adhd_ef
kableExtra::kbl(
  df_adhd_ef[, 1:4],
  "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc"),
  caption = "Attention and executive functions are multidimensional concepts
that contain several related processes. Both concepts require self-regulatory
skills and have some common subprocesses; therefore, it is common to treat them
together, or even to refer to both processes when talking about one or the
other."
) |>
  kableExtra::kable_paper(lightable_options = "basic") |>
  kableExtra::kable_styling(latex_options = c("scale_down", "HOLD_position", "striped")) |>
  kableExtra::column_spec(1, width = "8cm") |>
  kableExtra::pack_rows(index = table(df_adhd_ef$Test)) |>
  kableExtra::row_spec(row = 0, bold = TRUE) |>
  kableExtra::footnote("CAARS T-scores have a mean of 50 and a standard deviation of 10, and higher scores reflect reduced functioning. CEFI Standard scores have a mean of 100 and a standard deviation of 15, and lower scores reflect reduced functioning.", threeparttable = TRUE)
