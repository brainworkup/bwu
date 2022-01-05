## ---- 01-filter-academics -------------
filter_domain <- c(
  # WRAT5
  "Word Reading",
  "Math Calculation",
  "Writing",
  # CELF3 Preschool
  "Academic Language Readiness Index",
  # KTEA3
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
  # WAIS
  "Arithmetic"
  # WIAT4
)

## ---- 02-glue-academics ------------
dt <-
  neurocog %>%
  dplyr::filter(scale %in% filter_domain) %>%
  dplyr::arrange(desc(percentile)) %>%
  dplyr::distinct(.keep_all = FALSE)

dt %>%
  glue::glue_data() %>%
  purrr::modify(lift(paste0)) %>%
  cat(dt$result,
    file = "2_academics.md",
    fill = TRUE,
    append = TRUE
  )

## ---- 03-table-academics ------------
tb <-
  npsych.data::make_tibble(
    tibb = academics,
    data = neurocog,
    pheno = "Academic Skills"
  ) %>%
  filter(Scale %in% filter_domain) %>%
  arrange(Test)

## ---- 04-kable-academics ------------------
kableExtra::kbl(
  tb[, 1:4],
  "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc"),
  caption = "(ref:academics)"
) %>%
  kableExtra::kable_paper(., lightable_options = "basic") %>%
  kableExtra::kable_styling(., latex_options = c(
    "scale_down",
    "HOLD_position",
    "striped"
  )) %>%
  kableExtra::column_spec(., 1, width = "8cm") %>%
  kableExtra::pack_rows(., index = table(tb$Test)) %>%
  kableExtra::pack_rows(., index = table(tb$Subdomain)) %>%
  kableExtra::row_spec(., row = 0, bold = TRUE) %>%
  kableExtra::add_footnote("(ref:fn-acad)")

## ---- 05-df-academics ------------
df <-
  neurocog %>%
  filter(domain == "Academic Skills") %>%
  filter(!is.na(percentile)) %>%
  arrange(test_name) %>%
  filter(scale %in% filter_domain)

## ---- 06-plot-subdomain-academics -----------------
dotplot(
  data = df,
  x = df$z_mean_sub,
  y = df$subdomain,
  domain = "academics"
)

## ---- 07-plot-narrow-academics -------------------
dotplot(
  data = df,
  x = df$z_mean_narrow,
  y = df$narrow,
  domain = "academics"
)
