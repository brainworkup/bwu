## ---- 01-filter-memory -------------
filter_memory <- c(
  # ROCFT
  "ROCFT Delayed Recall",
  ## NAB/NABS
  "Memory Domain",
  "NAB Memory Index",
  "List Learning Immediate Recall",
  "List Learning Short Delayed Recall",
  "List Learning Long Delayed Recall",
  "Shape Learning Immediate Recognition",
  "Shape Learning Delayed Recognition",
  "Shape Learning Percent Retention",
  "Story Learning Immediate Recall",
  "Story Learning Delayed Recall",
  "Story Learning Percent Retention",
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
  "Trial 1 Free Recall Correct",
  "Trial 5 Free Recall Correct",
  "List B Free Recall Correct",
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
  # "Total Hits",
  # "Total False Positives",
  "Recognition Discriminability (d')",
  # "Recognition Discriminability Nonparametric",
  "CVLT-3 Forced-Choice Recognition Hits",
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
xfun::cache_rds({
  dt <-
    neurocog |>
    tidytable::filter(scale %in% filter_domain) |>
    tidytable::arrange(desc(percentile)) |>
    tidytable::distinct(.keep_all = FALSE)

  dt |>
    glue::glue_data() |>
    purrr::modify(lift(paste0)) |>
    cat(dt$result,
      file = "02.07_memory.md",
      fill = TRUE,
      append = TRUE
    )
})

## ---- 03-table-memory ------------
exclude <- c(
  "Trial 1 Correct",
  "Trial 2 Correct",
  "Trial 3 Correct",
  "Trial 4 Correct",
  "Trial 5 Correct",
  "List B Correct",
  "Total Hits",
  "Total False Positives",
  "Recognition Discriminability Nonparametric"
)
tb <-
  bwu::make_tibble(
    tibb = tb,
    data = neurocog,
    pheno = "Memory"
  ) |>
  tidytable::filter(Scale %in% filter_domain) |>
  tidytable::arrange(Test) |>
  tidytable::filter(Scale != exclude)

## ---- 04-kable-memory ------------------
kableExtra::kbl(
  tb[, 1:4],
  "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc"),
  caption = "(ref:memory)"
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
  kableExtra::add_footnote("(ref:fn-memory)")

## ---- 05-df-memory ------------
df <-
  neurocog |>
  tidytable::filter(domain == "Memory") |>
  tidytable::filter(!is.na(percentile)) |>
  tidytable::arrange(test_name) |>
  tidytable::filter(scale %in% filter_domain) |>
  tidytable::filter(scale != "CVLT-3 Total Intrusions") |>
  tidytable::filter(scale != "CVLT-3 Total Repetitions") |>
  tidytable::filter(scale != "CVLT-3 Forced-Choice Recognition Hits")

## ---- 06-plot-subdomain-memory -----------------
bwu::dotplot(
  data = df,
  x = df$z_mean_sub,
  y = df$subdomain,
  domain = "memory"
)

## ---- 07-plot-narrow-memory -------------------
library(ggplot2)
library(ggthemes)
library(ggpubr)
library(scales)

ggplot2::ggplot(data = memory) +
  ggplot2::geom_segment(
    ggplot2::aes(
      x = z_mean_sub,
      y = reorder(subdomain, z_mean_sub),
      xend = 0,
      yend = subdomain
    ),
    linewidth = 0.5
  ) +
  ggplot2::geom_point(
    ggplot2::aes(x = z_mean_sub, y = reorder(subdomain, z_mean_sub)),
    shape = 21,
    linewidth = 0.5,
    color = "black",
    fill =
      c(
        "#190D33", "#27123A", "#351742", "#421E4A", "#502653",
        "#5C2E5A", "#683863", "#73436A", "#7B4E70", "#815875",
        "#866079", "#89697D", "#8B7280", "#8C7A81", "#8E8385",
        "#908A87", "#919289", "#929A8A", "#94A38D", "#96AB8F",
        "#99B392", "#9CBD95", "#A2C79A", "#ACD3A0", "#B9DFA9",
        "#C8EAB3", "#D8F2BD", "#E6F9C7", "#F3FCD0", "#FEFED8"
      ),
    k = length(unique(memory$subdomain)),
    size = 6
  ) +
  theme_fivethirtyeight() +
  ggplot2::theme(panel.background = ggplot2::element_rect(fill = "white")) +
  ggplot2::theme(plot.background = ggplot2::element_rect(fill = "white")) +
  ggplot2::theme(panel.border = ggplot2::element_rect(color = "white"))
