## ---- 01-filter-iq -------------
filter_domain <- c(
  ## ACS TOPF
  "Test of Premorbid Functioning",
  "TOPF Standard Score",
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
  neurocog %>%
  dplyr::filter(scale %in% filter_domain) %>%
  dplyr::arrange(desc(percentile)) %>%
  dplyr::distinct(.keep_all = FALSE)

dt %>%
  glue::glue_data() %>%
  purrr::modify(lift(paste0)) %>%
  cat(dt$result,
    file = "2_iq.md",
    fill = TRUE,
    append = TRUE
  )

## ---- 03-table-iq ------------
tb <-
  bwu::make_tibble(
    tibb = tb,
    data = neurocog,
    pheno = "Intelligence/General Ability"
  ) %>%
  dplyr::filter(Scale %in% filter_domain) %>%
  dplyr::arrange(Test)

## ---- 04-kable-iq ------------------
kableExtra::kbl(
  tb[, 1:4],
  "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc"),
  caption = "(ref:iq)"
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
  kableExtra::add_footnote("(ref:fn-iq)")

## ---- 05-df-iq ------------
df <-
  neurocog %>%
  dplyr::filter(domain == "Intelligence/General Ability") %>%
  dplyr::filter(!is.na(percentile)) %>%
  dplyr::arrange(test_name) %>%
  dplyr::filter(scale %in% filter_domain) # %>%
# dplyr::filter(scale != "Cognitive Proficiency (CPI)") %>%
# dplyr::filter(scale != "General Ability (GAI)") %>%
# dplyr::filter(scale != "NAB Total Index")

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
