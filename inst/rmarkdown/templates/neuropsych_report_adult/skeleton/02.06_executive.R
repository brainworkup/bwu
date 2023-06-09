## ---- 01-filter-executive -------------
filter_executive <- c(
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
xfun::cache_rds({
  dt <-
    neurocog |>
    tidytable::filter(scale %in% filter_executive) |>
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
})

## ---- 03-table-executive ------------
tb <-
  bwu::make_tibble(tibb = executive,
    data = neurocog,
    pheno = "Attention/Executive") |>
  tidytable::filter(Scale %in% filter_executive) |>
  tidytable::arrange(Test) |>
  tidytable::filter(
    Scale %in% c(
      "NAB Attention Index",
      "Digits Forward",
      "Digits Forward Longest Span",
      "Digits Backward",
      "Digits Backward Longest Span",
      "Dots",
      "Numbers & Letters Part A Efficiency",
      "Numbers & Letters Part B Efficiency",
      "Numbers & Letters Part C Efficiency",
      "Numbers & Letters Part D Efficiency",
      "Driving Scenes",
      "NAB Executive Functions Index",
      "Mazes",
      "Categories",
      "Word Generation",
      "Word Generation Perseverations",
      "Judgment",
      "Working Memory (WMI)",
      "Arithmetic",
      "Digit Span",
      "Longest Digit Span Forward",
      "Longest Digit Span Backward",
      "Longest Digit Span Sequence",
      "Letter-Number Sequencing",
      "Symbol Span",
      "Spatial Span",
      "Picture Span",
      "Processing Speed (PSI)",
      "Coding",
      "Cancellation",
      "Symbol Search",
      "TMT, Part A",
      "TMT, Part B",
      "Unstructured Task",
      "Attention Index"
    )
  )

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
  kableExtra::footnote("(ref:fn-exe)")

## ---- 05-df-executive ------------
executive <-
  neurocog |>
  tidytable::filter(domain == "Attention/Executive") |>
  tidytable::filter(!is.na(percentile)) |>
  tidytable::arrange(test_name) |>
  tidytable::filter(scale %in% filter_executive) |>
  tidytable::filter(scale != "Orientation")

## ---- 06-plot-subdomain-executive -----------------
library(ggplot2)
library(ggthemes)
library(ggpubr)
library(scales)

ggplot2::ggplot(data = executive) +
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
    k = length(unique(executive$subdomain)),
    size = 6
  ) +
  theme_fivethirtyeight() +
  theme(panel.background = element_rect(fill = "white")) +
  theme(plot.background = element_rect(fill = "white")) +
  theme(panel.border = element_rect(color = "white"))

## ---- 07-plot-narrow-executive -------------------
bwu::dotplot(
  data = df,
  x = df$z_mean_narrow,
  y = df$narrow,
  domain = "executive"
)
