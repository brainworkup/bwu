## ---- 01-filter ----
filter_domain <- c(
  # ACS TOPF
  "Test of Premorbid Functioning",
  # NAB
  "NAB Total Index",
  # RBANS
  "RBANS Total Index",
  # WISC-5
  "Full Scale IQ (FSIQ)",
  "General Ability (GAI)",
  "Verbal Comprehension (VCI)",
  "Fluid Reasoning (FRI)",
  # WAIS-IV
  "Verbal Comprehension (VCI)",
  "Perceptual Reasoning (PRI)",
  "Attention Domain",
  "Digits Forward",
  "Digits Backward",
  "Numbers & Letters Part A Efficiency",
  "Numbers & Letters Part B Efficiency",
  "Numbers & Letters Part C Efficiency",
  "Numbers & Letters Part D Efficiency",
  "Executive Functions Domain",
  "Mazes",
  "Categories",
  "Word Generation",
  "Judgment",
  "Attention Index",
  "Digit Span",
  "Coding",
  "Total Deviation Score",
  "Letter-Number Sequencing",
  "Cancellation",
  "Symbol Span",
  "TMT, Part A",
  "TMT, Part B",
  "Working Memory (WMI)",
  "Processing Speed (PSI)",
  "Auditory Working Memory (AWMI)",
  "Arithmetic",
  "Picture Span",
  "Symbol Search",
  "Cancellation",
  "Digit Span Forward",
  "Digit Span Backward",
  "Digit Span Sequencing",
  "Longest Digit Span Forward",
  "Longest Digit Span Backward",
  "Longest Digit Span Sequence",
  "Longest Letter-Number Sequence",
  "Animal Sorting",
  "Auditory Attention",
  "Response Set",
  "Naming",
  "Inhibition",
  "Switching",
  "Inhibition Total Errors",
  "Word Generation Semantic",
  "Word Generation Initial Letter"
)

## ---- 02-glue ----
dt <-
  neurocog %>%
  dplyr::filter(scale %in% filter_domain) %>%
  dplyr::arrange(desc(percentile)) %>%
  dplyr::distinct(.keep_all = FALSE)

dt %>%
  glue::glue_data() %>%
  purrr::modify(lift(paste0)) %>%
  cat(dt$result,
      # will change the file name
      file = "nt_iq.md",
      fill = TRUE,
      append = TRUE
  )

## ---- 03-table ----
domain <-
  npsych.data::make_tibble(
    tibb = domain,
    data = neurocog,
    pheno = "Domain"
  ) %>%
  dplyr::filter(Scale %in% filter_domain) %>%
  dplyr::arrange(Test)

## ---- 04-kable ----
kableExtra::kbl(
  domain[, 2:5],
  "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc"),
  caption = "(ref:domain)"
) %>%
  kableExtra::kable_paper(., lightable_options = "basic") %>%
  kableExtra::kable_styling(., latex_options = c(
    "scale_down",
    "HOLD_position",
    "striped"
  )) %>%
  kableExtra::column_spec(., 1, width = "8cm") %>%
  kableExtra::pack_rows(., index = table(domain$Test)) %>%
  kableExtra::row_spec(., row = 0, bold = TRUE) %>%
  kableExtra::row_spec(., row = 1, bold = TRUE) %>%
  kableExtra::add_indent(., c(2:3)) %>%
  kableExtra::footnote(., symbol = "(ref:fn-domain)")

## ---- 05-df ----
df <-
  neurocog %>%
  dplyr::filter(domain == "Domain") %>%
  dplyr::filter(!is.na(percentile)) %>%
  dplyr::arrange(test_name) %>%
  dplyr::filter(scale %in% filter_domain)

## ---- 06-plot-subdomain ----
npsych.data::dotplot(
  data = df,
  x = df$z_mean_sub,
  y = df$subdomain,
  domain = "domain"
)

## ---- 07-plot-narrow ----
npsych.data::dotplot(
  data = df,
  x = df$z_mean_narrow,
  y = df$narrow,
  domain = "domain"
)
