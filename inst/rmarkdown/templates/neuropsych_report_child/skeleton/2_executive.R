## ---- 01-filter-executive -------------
filter_domain <- c(
  ## NAB
  "NAB Attention Index",
  "Attention Domain",
  # "Orientation",
  "Digits Forward",
  "Digits Forward Longest Span",
  "Digits Backward",
  "Digits Backward Longest Span",
  "Dots",
  # "Numbers & Letters Part A Speed",
  # "Numbers & Letters Part A Errors",
  "Numbers & Letters Part A Efficiency",
  "Numbers & Letters Part B Efficiency",
  "Numbers & Letters Part C Efficiency",
  "Numbers & Letters Part D Efficiency",
  # "Numbers & Letters Part D Disruption",
  "Driving Scenes",
  "NAB Executive Functions Index",
  "Executive Functions Domain",
  "Mazes",
  "Categories",
  "Word Generation",
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
  # WORKING MEMORY
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
  ## NEPSY-2
  "Animal Sorting",
  # "Animal Sorting Correct Sorts",
  # "Animal Sorting Novel Sort Errors",
  # "Animal Sorting Repeated Sort Errors",
  # "Animal Sorting Errors",
  "Auditory Attention",
  "Response Set",
  "Naming",
  "Inhibition",
  "Switching",
  "Inhibition Total Errors",
  # "Naming Time",
  # "Inhibition Time",
  # "Switching Time",
  "Naming Errors",
  "Inhibition Errors",
  "Switching Errors",
  # "Naming Uncorrected Errors",
  # "Inhibition Uncorrected Errors",
  # "Switching Uncorrected Errors",
  # "Naming Self-Corrected Errors",
  # "Inhibition Self-Corrected Errors",
  # "Switching Self-Corrected Errors",
  "Statue",
  # "Statue-Body Movement",
  # "Statue-Eye Opening",
  # "Statue-Vocalization",
  "Clocks",
  ## DKEFS
  # "Color Naming",
  # "Word Reading",
  "Inhibition",
  "Inhibition/Switching",
  "Inhibition Total Errors",
  "Inhibition/Switching Total Errors",
  ## CVLT
  "Total Intrusions",
  "Total Repetitions",
  ## RCFT
  "ROCF Copy",
  # "RCFT Copy"
  ## NIH EXAMINER
  "Unstructured Task",
  "Letter Fluency",
  "Category Fluency"
)

## ---- 02-glue-executive ------------
dt <-
  neurocog %>%
  dplyr::filter(scale %in% filter_domain) %>%
  dplyr::arrange(desc(percentile)) %>%
  dplyr::distinct(.keep_all = FALSE)

dt %>%
  glue::glue_data() %>%
  purrr::modify(lift(paste0)) %>%
  cat(dt$result,
    file = "2_executive.md",
    fill = TRUE,
    append = TRUE
  )

## ---- 03-table-executive ------------
tb <-
  npsych.data::make_tibble(
    tibb = executive,
    data = neurocog,
    pheno = "Attention/Executive"
  ) %>%
  dplyr::filter(Scale %in% filter_domain) %>%
  dplyr::arrange(Test)

## ---- 04-kable-executive ------------------
kableExtra::kbl(
  tb[, 1:4],
  "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc"),
  caption = "(ref:executive)"
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
  kableExtra::add_footnote("(ref:fn-exe)")

## ---- 05-df-executive ------------
df <-
  neurocog %>%
  dplyr::filter(domain == "Attention/Executive") %>%
  dplyr::filter(!is.na(percentile)) %>%
  dplyr::arrange(test_name) %>%
  dplyr::filter(scale %in% filter_domain)

## ---- 06-plot-subdomain-executive -----------------
npsych.data::dotplot(
  data = df,
  x = df$z_mean_sub,
  y = df$subdomain,
  domain = "executive"
)

## ---- 07-plot-narrow-executive -------------------
npsych.data::dotplot(
  data = df,
  x = df$z_mean_narrow,
  y = df$narrow,
  domain = "executive"
)
