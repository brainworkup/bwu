## ---- 01-filter-verbal ---------
filter_domain <- c(
  ## NAB/NABS
  "Language Domain",
  "NAB Language Index",
  "Auditory Comprehension",
  "Auditory Comprehension Colors",
  "Auditory Comprehension Shapes",
  "Auditory Comprehension Colors/Shapes/Numbers",
  "Naming",
  "Naming Semantic Cuing",
  "Naming Phonemic Cuing",
  "Reading Comprehension",
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
  "Language Index",
  "Semantic Fluency",
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
xfun::cache_rds({
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
})

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
verbal <-
  neurocog |>
  tidytable::filter(domain == "Verbal/Language") |>
  tidytable::filter(!is.na(percentile)) |>
  tidytable::arrange(test_name) |>
  tidytable::filter(scale %in% filter_domain)

## ---- 06-plot-subdomain-verbal ------------------
library(ggplot2)
library(ggthemes)
library(ggpubr)
library(scales)

ggplot2::ggplot(data = verbal) +
  geom_segment(
    aes(x = z_mean_sub,
      y = reorder(subdomain, z_mean_sub),
      xend = 0,
      yend = subdomain),
    linewidth = 0.5) +
  geom_point(
    aes(x = z_mean_sub, y = reorder(subdomain, z_mean_sub)),
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
    k = length(unique(verbal$subdomain)),
    size = 6
  ) +
  theme_fivethirtyeight() +
  theme(panel.background = element_rect(fill = "white")) +
  theme(plot.background = element_rect(fill = "white")) +
  theme(panel.border = element_rect(color = "white"))


## ---- 07-plot-narrow-verbal --------------------
ggplot2::ggplot(data = verbal) +
  geom_segment(
    aes(x = z_mean_sub,
      y = reorder(subdomain, z_mean_sub),
      xend = 0,
      yend = subdomain),
    linewidth = 0.5) +
  geom_point(
    aes(x = z_mean_sub, y = reorder(subdomain, z_mean_sub)),
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
    k = length(unique(verbal$subdomain)),
    size = 6
  ) +
  theme_fivethirtyeight() +
  theme(panel.background = element_rect(fill = "white")) +
  theme(plot.background = element_rect(fill = "white")) +
  theme(panel.border = element_rect(color = "white"))
