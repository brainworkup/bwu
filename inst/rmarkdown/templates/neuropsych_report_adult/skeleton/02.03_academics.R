## ---- 01-filter-academics ----
filter_domain <- c(
  ## WRAT5
  "Word Reading",
  "Math Computation",
  "Spelling",
  "Sentence Comprehension",
  "Reading Composite",
  ## CELF-3 Preschool
  "Academic Language Readiness Index",
  ## KTEA-3
  "Academic Skills Battery (ASB) Composite",
  "Math Concepts & Applications",
  "Letter & Word Recognition",
  "Written Expression",
  "Math Computation",
  "Spelling",
  "Reading Comprehension",
  "Reading Composite",
  "Math Composite",
  "Written Language Composite",
  "Sound-Symbol Composite",
  "Phonological Processing",
  "Nonsense Word Decoding",
  "Decoding Composite",
  "Reading Fluency Composite",
  "Silent Reading Fluency",
  "Word Recognition Fluency",
  "Decoding Fluency",
  "Reading Understanding Composite",
  "Reading Vocabulary",
  "Oral Language Composite",
  "Associational Fluency",
  "Listening Comprehension",
  "Oral Expression",
  "Oral Fluency Composite",
  "Object Naming Facility",
  "Comprehension Composite",
  "Expression Composite",
  "Orthographic Processing Composite",
  "Letter Naming Facility",
  "Academic Fluency Composite",
  "Writing Fluency",
  "Math Fluency",
  ## WAIS
  # "Arithmetic"
  ## WIAT-4
  "Alphabet Writing Fluency",
  "Basic Reading",
  "Decoding Fluency",
  "Decoding",
  "Dyslexia Index",
  "Essay Composition",
  "Expressive Vocabulary",
  "Listening Comprehension",
  "Math Fluency-Addition",
  "Math Fluency-Multiplication",
  "Math Fluency-Subtraction",
  "Math Fluency",
  "Math Problem Solving",
  "Mathematics",
  "Numerical Operations",
  "Oral Discourse Comprehension",
  "Oral Expression",
  "Oral Reading Fluency",
  "Oral Word Fluency",
  "Orthographic Choice",
  "Orthographic Fluency",
  "Orthographic Processing Extended",
  "Orthographic Processing",
  "Phonemic Proficiency",
  "Phonological Processing",
  "Pseudoword Decoding",
  "Reading Comprehension",
  "Reading Fluency",
  "Reading",
  "Receptive Vocabulary",
  "Sentence Composition",
  "Sentence Repetition",
  "Sentence Writing Fluency",
  "Spelling",
  "Total Achievement",
  "Word Reading",
  "Written Expression"
)

## ---- 02-glue-academics ----
dt <-
  neurocog |>
  tidytable::filter(scale %in% filter_domain) |>
  tidytable::arrange(desc(percentile)) |>
  tidytable::distinct(.keep_all = FALSE)

dt |>
  glue::glue_data() |>
  purrr::modify(purrr::lift(paste0)) |>
  cat(dt$result,
    file = "02.03_academics.md",
    fill = TRUE,
    append = TRUE
  )

## ---- 03-table-academics ----
tb <-
  bwu::make_tibble(
    tibb = academics,
    data = neurocog,
    pheno = "Academic Skills"
  ) |>
  tidytable::filter(Scale %in% filter_domain) |>
  tidytable::arrange(Test) |>
  tidytable::arrange(Subdomain)

## ---- 04-kable-academics ----
kableExtra::kbl(
  tb[, 1:4],
  "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc"),
  caption = "(ref:academics)"
) |>
  kableExtra::kable_paper(lightable_options = "basic") |>
  kableExtra::kable_styling(latex_options = c(
    "scale_down",
    "HOLD_position",
    "striped"
  )) |>
  kableExtra::column_spec(1, width = "8cm") |>
  kableExtra::pack_rows(index = table(tb$Test)) |>
  kableExtra::pack_rows(index = table(tb$Subdomain)) |>
  kableExtra::row_spec(row = 0, bold = TRUE) |>
  kableExtra::add_footnote("(ref:fn-acad)")

## ---- 05-df-academics ----
df <-
  neurocog |>
  tidytable::filter(domain == "Academic Skills") |>
  tidytable::filter(!is.na(percentile)) |>
  tidytable::arrange(test_name) |>
  tidytable::filter(scale %in% filter_domain)

## ---- 06-plot-subdomain-academics ----
bwu::dotplot(
  data = df,
  x = df$z_mean_sub,
  y = df$subdomain,
  domain = "academics"
)

## ---- 07-plot-narrow-academics -----
bwu::dotplot(
  data = df,
  x = df$z_mean_narrow,
  y = df$narrow,
  domain = "academics"
)
