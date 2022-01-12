## ---- 01-filter-memory -------------
filter_domain <- c(
  # RCFT
  "ROCF Delayed Recall",
  "ROCF Memory",
  "RCFT Memory",
  # NAB-S
  "Memory Domain",
  "Shape Learning Immediate Recognition",
  "Shape Learning Delayed Recognition",
  "Story Learning Immediate Recall",
  "Story Learning Delayed Recall",
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
  "Memory for Designs",
  "Memory for Designs Content",
  "Memory for Designs Spatial",
  "Memory for Designs Delayed",
  "Memory for Designs Delayed Content",
  "Memory for Designs Delayed Spatial",
  "Narrative Memory Free Recall",
  "Narrative Memory Recall",
  "Narrative Memory Free and Cued Recall",
  # "Narrative Memory Recognition",
  "Sentence Repetition",
  # CVLT-C
  "Trials 1-5 Free Recall Total Correct",
  # "Trial 1 Free Recall Total Correct",
  # "Trial 5 Free Recall Total Correct",
  # "List B Free Recall Total Correct",
  "Short-Delay Free Recall Total Correct",
  "Short-Delay Cued Recall Total Correct",
  "Long-Delay Free Recall Total Correct",
  "Long-Delay Cued Recall Total Correct",
  "Total Intrusions",
  "Total Repetitions",
  "Long-Delay Recognition Discriminability",
  "Long-Delay Recognition Response Bias",
  # CVLT-3
  "Trial 1 Correct",
  "Trial 2 Correct",
  "Trial 3 Correct",
  "Trial 4 Correct",
  "Trial 5 Correct",
  "List B Correct",
  "Trials 1-5 Correct",
  "Short Delay Free Recall Correct",
  # "Short Delay Cued Recall Correct",
  "Long Delay Free Recall Correct",
  # "Long Delay Cued Recall Correct",
  # "Total Hits",
  # "Total False Positives",
  "Recognition Discriminability (d')",
  # EF or here
  "Total Intrusions",
  "Total Repetitions",
  # WMS-IV
  "Logical Memory I",
  "Logical Memory II",
  "Visual Reproduction I",
  "Visual Reproduction II"
)

## ---- 02-glue-memory ------------
dt <-
  neurocog %>%
  dplyr::filter(scale %in% filter_domain) %>%
  dplyr::arrange(desc(percentile)) %>%
  dplyr::distinct(.keep_all = FALSE)

dt %>%
  glue::glue_data() %>%
  purrr::modify(lift(paste0)) %>%
  cat(dt$result,
    file = "2_memory.md",
    fill = TRUE,
    append = TRUE
  )

## ---- 03-table-memory ------------
tb <-
  make_tibble(
    tibb = tb,
    data = neurocog,
    pheno = "Memory"
  ) %>%
  filter(Scale %in% filter_domain) %>%
  arrange(Test)
tb$Score <- round(tb$Score, 0L)

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
  kableExtra::kable_paper(., lightable_options = "basic") %>%
  kableExtra::kable_styling(., latex_options = c(
    "scale_down",
    "HOLD_position",
    "striped"
  )) %>%
  kableExtra::column_spec(., 1, width = "8cm") %>%
  kableExtra::pack_rows(., index = table(tb$Test)) %>%
  kableExtra::row_spec(., row = 0, bold = TRUE) %>%
  kableExtra::add_footnote("(ref:fn-memory)")

## ---- 05-df-memory ------------
df <-
  neurocog %>%
  filter(domain == "Memory") %>%
  filter(!is.na(percentile)) %>%
  arrange(test_name) %>%
  filter(scale %in% filter_domain) %>%
  filter(scale != "Total Intrusions") %>%
  filter(scale != "Total Repetitions")

## ---- 06-plot-subdomain-memory -----------------
dotplot(
  data = df,
  x = df$z_mean_sub,
  y = df$subdomain,
  domain = "memory"
)

## ---- 07-plot-narrow-memory -------------------
dotplot(
  data = df,
  x = df$z_mean_narrow,
  y = df$narrow,
  domain = "memory"
)
