## ---- 01-filter-memory -------------
filter_domain <- c(
  # ROCFT
  "ROCFT Delayed Recall",
  "ROCF Memory",
  "RCFT Memory",
  ## NAB/NABS
  "Memory Domain",
  "NAB Memory Index",
  "List Learning Immediate Recall",
  "List Learning Short Delayed Recall",
  "List Learning Long Delayed Recall",
  "Shape Learning Immediate Recognition",
  "Shape Learning Delayed Recognition",
  "Story Learning Immediate Recall",
  "Story Learning Delayed Recall",
  "Daily Living Memory Immediate Recall",
  "Daily Living Memory Delayed Recall",
  # RBANS
  "Immediate Memory Index",
  "List Learning",
  "Story Memory",
  "Delayed Memory Index",
  "List Recall",
  "List Recognition",
  "Story Recall",
  "Figure Recall",
  # NEPSY-2
  "Memory for Faces",
  "Memory for Faces Delayed",
  "Memory for Designs",
  "Memory for Designs Content",
  "Memory for Designs Spatial",
  "Memory for Designs Delayed",
  "Memory for Designs Delayed Content",
  "Memory for Designs Delayed Spatial",
  "Narrative Memory Free Recall",
  "Narrative Memory Recall",
  "Narrative Memory Free and Cued Recall",
  "Narrative Memory Recognition",
  "Word List Interference-Repetition",
  "Word List Interference-Recall",
  "Sentence Repetition",
  # CVLT-C
  "Trials 1-5 Free Recall Correct",
  # "Trial 1 Free Recall Correct",
  # "Trial 5 Free Recall Correct",
  # "List B Free Recall Correct",
  "Short-Delay Free Recall",
  "Short-Delay Cued Recall",
  "Long-Delay Free Recall",
  "Long-Delay Cued Recall",
  # "Total Intrusions",
  # "Total Repetitions",
  "Long-Delay Recognition Discriminability",
  "Long-Delay Recognition Response Bias",
  ## CVLT-3/CVLT-3 Brief
  "Trial 1 Correct",
  "Trial 2 Correct",
  "Trial 3 Correct",
  "Trial 4 Correct",
  "Trial 5 Correct",
  "List B Correct",
  "Trials 1-4 Correct",
  "Trials 1-5 Correct",
  "Short Delay Free Recall",
  "Short Delay Cued Recall",
  "Long Delay Free Recall",
  "Long Delay Cued Recall",
  "Total Hits",
  "Total False Positives",
  "Recognition Discriminability (d')",
  "Recognition Discriminability Nonparametric",
  "Forced-Choice Recognition Hits",
  # EF or here
  "CVLT-3 Total Intrusions",
  "CVLT-3 Total Repetitions",
  # WMS-IV
  "Logical Memory I",
  "Logical Memory II",
  "Visual Reproduction I",
  "Visual Reproduction II",
  "Designs II",
  "Designs II"
)

## ---- 02-glue-memory ------------
dt <-
  neurocog %>%
  tidytable::filter(scale %in% filter_domain) %>%
  tidytable::arrange(desc(percentile)) %>%
  tidytable::distinct(.keep_all = FALSE)

dt %>%
  glue::glue_data() %>%
  purrr::modify(lift(paste0)) %>%
  cat(dt$result,
    file = "02.07_memory.md",
    fill = TRUE,
    append = TRUE
  )

## ---- 03-table-memory ------------
tb <-
  bwu::make_tibble(
    tibb = tb,
    data = neurocog,
    pheno = "Memory"
  ) %>%
  tidytable::filter(Scale %in% filter_domain) %>%
  tidytable::arrange(Test)
# tb$Score <- round(tb$Score, 0L)

## ---- 04-kable-memory ------------------
kableExtra::kbl(
  tb[, 1:4],
  "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc"),
  caption = "(ref:memory)"
) %>%
  kableExtra::kable_paper(lightable_options = "basic") %>%
  kableExtra::kable_styling(latex_options = c(
    "scale_down",
    "HOLD_position",
    "striped"
  )) %>%
  kableExtra::column_spec(1, width = "8cm") %>%
  kableExtra::pack_rows(index = table(tb$Test)) %>%
  kableExtra::row_spec(row = 0, bold = TRUE) %>%
  kableExtra::add_footnote("(ref:fn-memory)")

## ---- 05-df-memory ------------
df <-
  neurocog %>%
  tidytable::filter(domain == "Memory") %>%
  tidytable::filter(!is.na(percentile)) %>%
  tidytable::arrange(test_name) %>%
  tidytable::filter(scale %in% filter_domain) %>%
  tidytable::filter(scale != "Total Intrusions") %>%
  tidytable::filter(scale != "Total Repetitions") %>%
  tidytable::filter(scale != "Forced-Choice Recognition Hits")

## ---- 06-plot-subdomain-memory -----------------
bwu::dotplot(
  data = df,
  x = df$z_mean_sub,
  y = df$subdomain,
  domain = "memory"
)

## ---- 07-plot-narrow-memory -------------------
bwu::dotplot(
  data = df,
  x = df$z_mean_narrow,
  y = df$narrow,
  domain = "memory"
)
