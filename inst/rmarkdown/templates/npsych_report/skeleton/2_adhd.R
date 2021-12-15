## ---- 01-filter-adhd ---------
filter_domain <- list(
  # Brown
  "Activation",
  "Focus",
  "Effort",
  "Emotion",
  "Memory",
  "Action",
  "Total Composite",
  # CAARS
  "Inattention/Memory Problems",
  "Hyperactivity/Restlessness",
  "Impulsivity/Emotional Lability",
  "Problems with Self-Concept",
  "DSM-IV Inattentive Symptoms",
  "DSM-IV Hyperactive-Impulsive Symptoms",
  "DSM-IV ADHD Symptoms Total",
  "ADHD Index",
  # CEFI
  "Full Scale",
  "Attention",
  "Emotion Regulation",
  "Flexibility",
  "Inhibitory Control",
  "Initiation",
  "Organization",
  "Planning",
  "Self-Monitoring",
  "Working Memory"
)

## ---- 02-glue-adhd ------------
dt <-
  neurocog %>%
  dplyr::filter(scale %in% filter_domain) %>%
  dplyr::arrange(desc(percentile)) %>%
  dplyr::distinct(.keep_all = FALSE)

dt %>%
  glue::glue_data() %>%
  purrr::modify(lift(paste0)) %>%
  cat(dt$result,
      file = "2_adhd.md",
      fill = TRUE,
      append = TRUE
  )

## ---- 03-table-adhd ------------
tb <-
  make_tibble(
    tibb = tb,
    data = neurobehav,
    pheno = "Behavioral/Emotional/Social"
  ) %>%
  filter(Scale %in% filter_domain) %>%
  arrange(Test)

## ---- 04-kable-adhd ------------------
kableExtra::kbl(
  tb[, 2:5],
  caption = "(ref:adhd)",
  "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc")
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
  kableExtra::add_footnote("(ref:fn-adhd)")

## ---- 05-df-adhd -----------------------------------
df <-
  neurobehav %>%
  filter(test_name == "Brown EF/A Self-Report") %>%
  filter(test_name == "Brown EF/A Observer-Report") %>%
  filter(test_name == "CAARS Self-Report") %>%
  filter(test_name == "CAARS Observer-Report") %>%
  filter(test_name == "CEFI Self-Report") %>%
  filter(test_name == "CEFI Observer-Report") %>%
  filter(!is.na(percentile)) %>%
  filter(scale %in% filter_domain)

## ---- 06-plot-subdomain-adhd -------------------
dotplot(
  data = df,
  x = df$z_mean_sub,
  y = df$subdomain,
  domain = "attention/executive"
)

## ---- 07-plot-narrow-adhd --------------------
dotplot(
  data = df,
  x = df$z_mean_narrow,
  y = df$narrow,
  domain = "attention/executive"
)
