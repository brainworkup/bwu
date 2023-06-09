## ---- 01-filter-iq -------------
filter_iq <- c(
  ## ACS TOPF
  "Test of Premorbid Functioning",
  "TOPF Standard Score",
  ## WRAT5 Word Reading
  "Word Reading",
  ## NAB
  "NAB Total Index",
  "NAB Attention Index",
  "NAB Language Index",
  "NAB Memory Index",
  "NAB Spatial Index",
  "NAB Executive Functions Index",
  ## RBANS
  "RBANS Total Index",
  ## WISC/WAIS/WPPSI
  "Full Scale (FSIQ)",
  "General Ability (GAI)",
  "Cognitive Proficiency (CPI)",
  "Verbal Comprehension (VCI)",
  "Perceptual Reasoning (PRI)",
  "Fluid Reasoning (FRI)",
  "Visual Spatial (VSI)",
  "Vocabulary Acquisition (VAI)",
  "Nonverbal (NVI)",
  "Processing Speed (PSI)",
  "Working Memory (WMI)",
  ## composite scores
  "General Ability",
  "General Ability Index",
  "Crystallized Knowledge",
  "Crystallized Knowledge Index",
  "Fluid Reasoning",
  "Fluid Reasoning Index",
  "Cognitive Proficiency",
  "Cognitive Proficiency Index",
  "Working Memory",
  "Working Memory Index",
  "Processing Speed",
  "Processing Speed Index",
  "General Intelligence",
  "Cognitive Efficiency"
)

## ---- 02-glue-iq ------------
xfun::cache_rds({
  dt <-
    neurocog |>
    tidytable::filter(scale %in% filter_iq) |>
    tidytable::arrange(tidytable::desc(percentile)) |>
    tidytable::distinct(.keep_all = FALSE)

  dt |>
    glue::glue_data() |>
    purrr::modify(purrr::lift(paste0)) |>
    cat(dt$result,
      file = "02.02_iq.md",
      fill = TRUE,
      append = TRUE
    )
})

## ---- 03-table-iq ------------
tb <-
  bwu::make_tibble(
    tibb = tb,
    data = neurocog,
    pheno = "Intelligence/General Ability"
  ) |>
  tidytable::filter(Scale %in% filter_iq) |>
  tidytable::arrange(Test)

## ---- 04-kable-iq ------------------
kableExtra::kbl(
  tb[, 1:4],
  "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc"),
  caption = "(ref:iq)"
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
  kableExtra::footnote("(ref:fn-iq)")

## ---- 05-df-iq ------------
iq <-
  neurocog |>
  tidytable::filter(
    domain == "Intelligence/General Ability") |>
  tidytable::filter(
    !is.na(percentile)) |>
  tidytable::arrange(
    test_name) |>
  tidytable::filter(
    scale %in% c(
      "General Ability",
      "Crystallized Knowledge",
      "Fluid Reasoning")
  )

## ---- 06-plot-subdomain-iq --------------------


## ---- 07-plot-narrow-iq -------------------
library(ggplot2)
library(ggthemes)
library(ggpubr)
library(scales)

ggplot2::ggplot(data = iq) +
  geom_segment(
    aes(x = z_mean_narrow,
        y = reorder(narrow, z_mean_narrow),
        xend = 0,
        yend = narrow),
    linewidth = 0.5) +
  geom_point(
    aes(x = z_mean_narrow, y = reorder(narrow, z_mean_narrow)),
    shape = 21,
    linewidth = 0.5,
    color = "black",
    fill =
      c("#190D33", "#27123A", "#351742", "#421E4A", "#502653",
        "#5C2E5A", "#683863", "#73436A", "#7B4E70", "#815875",
        "#866079", "#89697D", "#8B7280", "#8C7A81", "#8E8385",
        "#908A87", "#919289", "#929A8A", "#94A38D", "#96AB8F",
        "#99B392", "#9CBD95", "#A2C79A", "#ACD3A0", "#B9DFA9",
        "#C8EAB3", "#D8F2BD", "#E6F9C7", "#F3FCD0", "#FEFED8"),
    k = length(unique(iq$narrow)),
    size = 6) +
  theme_fivethirtyeight() +
  theme(panel.background = element_rect(fill = "white")) +
  theme(plot.background = element_rect(fill = "white")) +
  theme(panel.border = element_rect(color = "white"))



