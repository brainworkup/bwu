## ---- 01-filter-verbal ---------
filter_domain <- c(
  ## NAB/NABS
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
  "Oral Production",
  "Writing",
  "Bill Payment",
  ## from EF
  "Word Generation",
  ## WAIS/WISC/WPPSI
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
  "D-KEFS Color Naming",
  "D-KEFS Word Reading",
  # NEPSY
  "Comprehension of Instructions",
  "Word Generation-Semantic",
  "Word Generation-Initial Letter",
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
  "Early Literacy Index",
  # NIH EXAMINER
  "Letter Fluency",
  "Category Fluency"
)

## ---- 02-glue-verbal ---------------------
dt <-
  neurocog |>
  tidytable::filter(scale %in% filter_domain) |>
  tidytable::arrange(desc(percentile)) |>
  tidytable::distinct(.keep_all = FALSE)

dt |>
  glue::glue_data() |>
  purrr::modify(purrr::lift(paste0)) |>
  cat(dt$result,
    file = "02.04_verbal.md",
    fill = TRUE,
    append = TRUE
  )

## ---- 03-table-verbal ------------
tb <-
  bwu::make_tibble(
    tibb = verbal,
    data = neurocog,
    pheno = "Verbal/Language"
  ) |>
  tidytable::filter(Scale %in% filter_domain) |>
  tidytable::arrange(Test)

## ---- 04-kable-verbal -----------------
kableExtra::kbl(
  tb[, 1:4],
  "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc"),
  caption = "(ref:verbal)"
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
  kableExtra::add_footnote("(ref:fn-vrb)")

## ---- 05-df-verbal -----------------------------
df <-
  neurocog |>
  tidytable::filter(domain == "Verbal/Language") |>
  tidytable::filter(!is.na(percentile)) |>
  tidytable::arrange(test_name) |>
  tidytable::filter(scale %in% filter_domain)

## ---- 06-plot-subdomain-verbal ------------------
bwu::dotplot(
  data = df,
  x = df$z_mean_sub,
  y = df$subdomain,
  domain = "verbal"
)

## ---- 07-plot-narrow-verbal --------------------
bwu::dotplot(
  data = df,
  x = df$z_mean_narrow,
  y = df$narrow,
  domain = "verbal"
)
