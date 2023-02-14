## ---- 01-filter-executive -------------
filter_domain <- c(
  ## NAB
  "NAB Attention Index",
  "Attention Domain",
  "Orientation",
  "Digits Forward",
  "Digits Forward Longest Span",
  "Digits Backward",
  "Digits Backward Longest Span",
  "Dots",
  "Numbers & Letters Part A Speed",
  "Numbers & Letters Part A Errors",
  "Numbers & Letters Part A Efficiency",
  "Numbers & Letters Part B Efficiency",
  "Numbers & Letters Part C Efficiency",
  "Numbers & Letters Part D Efficiency",
  "Numbers & Letters Part D Disruption",
  "Driving Scenes",
  "NAB Executive Functions Index",
  "Executive Functions Domain",
  "Mazes",
  "Categories",
  "Word Generation",
  "Word Generation Perseverations",
  "Judgment",
  ## RBANS
  "Attention Index",
  ## CONCEPT FORMATION
  # "Comprehension",
  # "Similarities",
  # "Matrix Reasoning",
  # CET
  "Total Deviation Score",
  ## WAIS/WISC/WMS
  "Working Memory (WMI)",
  "Auditory Working Memory (AWMI)",
  "Arithmetic",
  "Digit Span",
  "Digit Span Forward",
  "Digit Span Backward",
  "Digit Span Sequencing",
  "Longest Digit Span Forward",
  "Longest Digit Span Backward",
  "Longest Digit Span Sequence",
  "Letter-Number Sequencing",
  "Longest Letter-Number Sequence",
  "Symbol Span",
  "Spatial Span",
  "Picture Span",
  ## WPPSI-IV
  "Picture Memory",
  "Zoo Locations",
  # PROCESSING SPEED
  "Processing Speed (PSI)",
  "Coding",
  "Cancellation",
  # "Cancellation Random",
  # "Cancellation Structured",
  "Symbol Search",
  "Bug Search",
  "Animal Coding",
  ## TMT
  "TMT, Part A",
  "TMT, Part B",
  "Trails A",
  "Trails B",
  ## Clock Drawing Test
  "Clock Drawing",
  ## DKEFS
  "D-KEFS Color Naming",
  "D-KEFS Word Reading",
  "D-KEFS Inhibition",
  "D-KEFS Switching",
  "D-KEFS Inhibition Total Errors",
  "D-KEFS Switching Total Errors",
  ## CVLT
  "Total Intrusions",
  "Total Repetitions",
  ## RCFT
  "ROCF Copy",
  "ROCFT Copy",
  ## NIH EXAMINER
  "Unstructured Task",
  "Letter Fluency",
  "Category Fluency",
  ## WMS-4 Working Memory
  "Spatial Addition",
  "Picture Span"
)

## ---- 02-glue-executive ------------
dt <-
  neurocog |>
  tidytable::filter(scale %in% filter_domain) |>
  tidytable::arrange(desc(percentile)) |>
  tidytable::distinct(.keep_all = FALSE)

dt |>
  glue::glue_data() |>
  purrr::modify(purrr::lift(paste0)) |>
  cat(dt$result,
    file = "02.06_executive.md",
    fill = TRUE,
    append = TRUE
  )

## ---- 03-table-executive ------------
tb <-
  bwu::make_tibble(
    tibb = executive,
    data = neurocog,
    pheno = "Attention/Executive"
  ) |>
  tidytable::filter(Scale %in% filter_domain) |>
  tidytable::arrange(Test)

## ---- 04-kable-executive ------------------
kableExtra::kbl(
  tb[, 1:4],
  "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc"),
  caption = "(ref:executive)"
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
  kableExtra::add_footnote("(ref:fn-exe)")

## ---- 05-df-executive ------------
df <-
  neurocog |>
  tidytable::filter(domain == "Attention/Executive") |>
  tidytable::filter(!is.na(percentile)) |>
  tidytable::arrange(test_name) |>
  tidytable::filter(scale %in% filter_domain) |>
  tidytable::filter(scale != "Orientation")

## ---- 06-plot-subdomain-executive -----------------
bwu::dotplot(
  data = df,
  x = df$z_mean_sub,
  y = df$subdomain,
  domain = "executive"
)

## ---- 07-plot-narrow-executive -------------------
bwu::dotplot(
  data = df,
  x = df$z_mean_narrow,
  y = df$narrow,
  domain = "executive"
)
