## ---- 01-filter-emotion ---------
filter_domain <- c(
  # PAI
  "Somatic Complaints",
  "Conversion",
  "Somatization",
  "Health Concerns",
  "Anxiety",
  "Cognitive (A)",
  "Affective (A)",
  "Physiological (A)",
  "Anxiety-Related Disorders",
  "Obsessive-Compulsive",
  "Phobias",
  "Traumatic Stress",
  "Depression",
  "Cognitive (D)",
  "Affective (D)",
  "Physiological (D)",
  "Mania",
  "Activity Level",
  "Grandiosity",
  "Irritability",
  "Paranoia",
  "Hypervigilance",
  "Persecution",
  "Resentment",
  "Schizophrenia",
  "Psychotic Experiences",
  "Social Detachment",
  "Thought Disorder",
  "Borderline Features",
  "Affective Instability",
  "Identity Problems",
  "Negative Relationships",
  "Self-Harm",
  "Antisocial Features",
  "Antisocial Behaviors",
  "Egocentricity",
  "Stimulus-Seeking",
  "Aggression",
  "Aggressive Attitude",
  "Verbal Aggression",
  "Physical Aggression",
  "Alcohol Problems",
  "Drug Problems",
  "Suicidal Ideation",
  "Stress",
  "Nonsupport",
  "Treatment Rejection",
  "Dominance",
  "Warmth",
  "ALC Estimated Score",
  "DRG Estimated Score",
  # BDI-2
  "BID-2 Total Score",
  # BAI-2
  "BAI-2 Total Score"
)

## ---- 02-glue-emotion ------------
xfun::cache_rds({
  dt <-
    neurobehav |>
    tidytable::filter(scale %in% filter_domain) |>
    tidytable::arrange(desc(percentile)) |>
    tidytable::distinct(.keep_all = FALSE)

  dt |>
    glue::glue_data() |>
    purrr::modify(purrr::lift(paste0)) |>
    cat(dt$result,
      file = "02.11_emotion.md",
      fill = TRUE,
      append = TRUE
    )
})

## ---- 03-table-axis1 ------------
tb1 <-
  bwu::make_tibble(
    tibb = tb1,
    data = neurobehav,
    pheno = "Psychiatric Disorders"
  ) |>
  tidytable::filter(Scale %in% filter_domain) |>
  tidytable::arrange(Test) |>
  tidytable::arrange(Subdomain)

## ---- 03-table-axis2 ------------
tb2 <-
  bwu::make_tibble(
    tibb = tb2,
    data = neurobehav,
    pheno = "Personality Disorders"
  ) |>
  tidytable::filter(Scale %in% filter_domain) |>
  tidytable::arrange(Test) |>
  tidytable::arrange(Subdomain)

## ---- 03-table-sud ------------
tb3 <-
  bwu::make_tibble(
    tibb = tb3,
    data = neurobehav,
    pheno = "Substance Use"
  ) |>
  tidytable::filter(Scale %in% filter_domain) |>
  tidytable::arrange(Test) |>
  tidytable::arrange(Subdomain)

## ---- 03-table-social ------------
tb4 <-
  bwu::make_tibble(
    tibb = tb4,
    data = neurobehav,
    pheno = "Psychosocial Problems"
  ) |>
  tidytable::filter(Scale %in% filter_domain) |>
  tidytable::arrange(Test) |>
  tidytable::arrange(Subdomain)

## ---- 03-table-emotion ------------
tb <-
  tidytable::bind_rows(tb1, tb2, tb3) |>
  tidytable::filter(Scale %in% filter_domain) |>
  tidytable::arrange(Test) |>
  tidytable::arrange(Subdomain)

## ---- 04-kable-emotion ------------------
kableExtra::kbl(
  tb[, 1:4], "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc"),
  caption = "(ref:emotion)"
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
  kableExtra::footnote("(ref:fn-emo)")

## ---- 05-df-emotion -----------------------------------
df <-
  neurobehav |>
  tidytable::filter(!is.na(percentile)) |>
  tidytable::filter(scale %in% filter_domain)

## ---- 06-plot-subdomain-emotion -------------------
library(ggplot2)
library(ggthemes)
library(ggpubr)
library(scales)

ggplot2::ggplot(data = emotion) +
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
    k = length(unique(emotion$subdomain)),
    size = 6
  ) +
  theme_fivethirtyeight() +
  theme(panel.background = element_rect(fill = "white")) +
  theme(plot.background = element_rect(fill = "white")) +
  theme(panel.border = element_rect(color = "white"))

## ---- 07-plot-narrow-emotion --------------------
bwu::dotplot(
  data = df,
  x = df$z_mean_narrow,
  y = df$narrow,
  domain = "emotion"
)
