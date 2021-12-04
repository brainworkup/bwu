## ---- 01-glue ----
dom <- "Domain"
domain <- neurocog %>%
  filter(domain == dom) %>%
  arrange(desc(percentile)) %>%
  distinct(.keep_all = FALSE)
trait <- domain
lst(person, range, scale) %>%
  glue::glue_data(
    "(ref:first-name)'s score on *{description}* fell in the *{range}* range.",
    range = trait$range,
    scale = trait$scale,
    score = trait$score,
    percentile = trait$percentile,
    description = trait$description
  ) %>%
  purrr::modify(lift(paste0)) %>%
  cat()

## ---- 02-make-df ----
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
domain <-
  make_tibble(tibb = domain,
              data = neurocog,
              pheno = "Domain") %>%
  filter(Scale %in% filter_domain) %>%
  arrange(Test)

## ---- 03-make-kable ----
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
  kableExtra::kable_styling(., latex_options = c("scale_down",
                                                 "HOLD_position",
                                                 "striped")) %>%
  kableExtra::column_spec(., 1, width = "8cm") %>%
  kableExtra::pack_rows(., index = table(domain$Test)) %>%
  kableExtra::row_spec(., row = 0, bold = TRUE) %>%
  kableExtra::row_spec(., row = 1, bold = TRUE) %>%
  kableExtra::add_indent(., c(2:3)) %>%
  kableExtra::add_footnote("(ref:fn-domain)")

## ---- 04-make-df ----
df <-
  neurocog %>%
  filter(domain == "Domain") %>%
  filter(!is.na(percentile)) %>%
  arrange(test_name) %>%
  filter(scale %in% filter_domain)

## ---- 05-plot-subdomain ----
dotplot(
  data = df,
  x = df$z_mean_sub,
  y = df$subdomain,
  domain = "domain"
)

## ---- 06-plot-narrow ----
dotplot(
  data = df,
  x = df$z_mean_narrow,
  y = df$narrow,
  domain = "domain"
)
