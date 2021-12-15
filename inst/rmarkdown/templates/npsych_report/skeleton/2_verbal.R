## ---- 01-filter-verbal ---------
filter_domain <- c(
  # NAB
  "Language Domain",
  "Language Index",
  "NAB Language Index",
  "Auditory Comprehension",
  "Auditory Comprehension Colors",
  "Auditory Comprehension Shapes",
  "Auditory Comprehension Colors/Shapes/Numbers",
  "Naming",
  "Naming Semantic Cuing",
  "Naming Phonemic Cuing",
  # WAIS/WISC/WPPSI
  "Information",
  "Similarities",
  "Vocabulary",
  "Comprehension",
  "Receptive Vocabulary",
  "Picture Naming",
  # RBANS
  "Receptive Vocabulary",
  "Picture Naming",
  # DKEFS
  "Color Naming",
  "Word Reading",
  # NEPSY
  "Word Generation-Semantic",
  "Body Part Naming",
  "Body Part Identification",
  # "Naming vs Identification",
  "Oromotor Sequences",
  "Speeded Naming",
  ## "Speeded Naming Time",
  ## "Speeded Naming Correct",
  ## "Speeded Naming Errors",
  # CELF-3 Preschool
  "Sentence Comprehension",
  "Word Structure",
  "Expressive Vocabulary",
  "Following Directions",
  "Recalling Sentences",
  "Basic Concepts",
  "Word Classes",
  "Phonological Awareness",
  "Descriptive Pragmatics Profile",
  "Preliteracy Rating Scale",
  "Core Language Score",
  "Receptive Language Index",
  "Expressive Language Index",
  "Language Content Index",
  "Language Structure Index",
  "Academic Language Readiness Index",
  "Early Literacy Index"
)

## ---- 02-glue-verbal ---------------------
dt <-
  neurocog %>%
  dplyr::filter(scale %in% filter_domain) %>%
  dplyr::arrange(desc(percentile)) %>%
  dplyr::distinct(.keep_all = FALSE)

dt %>%
  glue::glue_data() %>%
  purrr::modify(lift(paste0)) %>%
  cat(dt$result,
    file = "2_verbal.md",
    fill = TRUE,
    append = TRUE
  )

## ---- 03-table-verbal ------------
tb <-
  make_tibble(
    tibb = verbal,
    data = neurocog,
    pheno = "Verbal/Language"
  ) %>%
  filter(Scale %in% filter_domain) %>%
  arrange(Test)

## ---- 04-kable-verbal -----------------
kableExtra::kbl(
  tb[, 2:5],
  "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc"),
  caption = "(ref:verbal)"
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
  kableExtra::add_footnote("(ref:fn-verbal)")

## ---- 05-df-verbal -----------------------------
df <-
  neurocog %>%
  filter(domain == "Verbal/Language") %>%
  filter(!is.na(percentile)) %>%
  arrange(test_name) %>%
  filter(scale %in% filter_domain)

## ---- 06-plot-subdomain-verbal ------------------
dotplot(
  data = df,
  x = df$z_mean_sub,
  y = df$subdomain,
  domain = "verbal"
)

## ---- 07-plot-narrow-verbal --------------------
dotplot(
  data = df,
  x = df$z_mean_narrow,
  y = df$narrow,
  domain = "verbal"
)
