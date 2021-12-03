## ---- 01-glue-iq -------------
dom <- "Intelligence/General Ability"
iq <- neurocog %>%
  filter(domain == dom) %>%
  arrange(desc(percentile)) %>%
  distinct(.keep_all = FALSE)
trait <- iq
lst(person, range, scale) %>%
  glue::glue_data(
    "(ref:first-name)'s score on {scale}, a measure of {description}, fell in the *{range}* range.",
    range = trait$range,
    scale = trait$scale,
    score = trait$score,
    percentile = trait$percentile,
    description = trait$description
  ) %>%
  purrr::modify(lift(paste0)) %>%
  cat()

## ---- 02-make-df-iq ------------
filter_intelligence <- c(
  # ACS TOPF
  "Test of Premorbid Functioning",
  # NAB
  "Total NAB Index",
  # RBANS
  "RBANS Total Index",
  # WISC/WAIS/WPPSI
  "Full Scale IQ (FSIQ)",
  "General Ability (GAI)",
  "Cognitive Proficiency (CPI)",
  "Verbal Comprehension (VCI)",
  "Perceptual Reasoning (PRI)",
  "Fluid Reasoning (FRI)",
  "Visual Spatial (VSI)",
  "Vocabulary Acquisition (VAI)",
  "Nonverbal (NVI)"
)
iq <-
  make_tibble(
    tibb = iq,
    data = neurocog,
    pheno = "Intelligence/General Ability"
  ) %>%
  filter(Scale %in% filter_intelligence) %>%
  arrange(Test)

## ---- 03-make-kable-iq ------------------
kableExtra::kbl(
  iq[, 2:5],
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
  kableExtra::pack_rows(., index = table(iq$Test)) %>%
  kableExtra::row_spec(., row = 0, bold = TRUE) %>%
  # kableExtra::row_spec(., row = 1, bold = TRUE) %>%
  # kableExtra::add_indent(., c(2:3)) %>%
  kableExtra::add_footnote("(ref:fn-iq)")

## ---- 04-make-df-iq ------------
g <-
  neurocog %>%
  filter(domain == "Intelligence/General Ability") %>%
  filter(!is.na(percentile)) %>%
  arrange(test_name) %>%
  filter(scale %in% filter_intelligence) %>%
  filter(scale != "Cognitive Proficiency (CPI)") %>%
  filter(scale != "General Ability (GAI)")

## ---- 05-plot-iq-subdomain --------------------
dotplot(
  data = g,
  x = g$z_mean_sub,
  y = g$subdomain,
  domain = "iq"
)

## ---- 06-plot-iq-narrow -------------------
dotplot(
  data = g,
  x = g$z_mean_narrow,
  y = g$narrow,
  domain = "iq"
)
