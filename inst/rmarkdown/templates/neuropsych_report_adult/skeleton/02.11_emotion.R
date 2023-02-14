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
  # BDI-2
  "BID-2 Total Score",
  # BAI-2
  "BAI-2 Total Score"
)

## ---- 02-glue-emotion ------------
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

## ---- 03-table-emotion ------------
tb <-
  bwu::make_tibble(
    tibb = tb,
    data = neurobehav,
    pheno = "Personality"
  ) |>
  tidytable::filter(Scale %in% filter_domain) |>
  tidytable::arrange(Test) |>
  tidytable::arrange(Subdomain)

## ---- 04-kable-emotion ------------------
kableExtra::kbl(
  tb[, 1:4],
  caption = "(ref:emotion)",
  "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc")
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
  kableExtra::add_footnote("(ref:fn-emo)")

## ---- 05-df-emotion -----------------------------------
df <-
  neurobehav |>
  tidytable::filter(!is.na(percentile)) |>
  tidytable::filter(scale %in% filter_domain)

## ---- 06-plot-subdomain-emotion -------------------
bwu::dotplot(
  data = df,
  x = df$z_mean_sub,
  y = df$subdomain,
  domain = "emotion"
)

## ---- 07-plot-narrow-emotion --------------------
bwu::dotplot(
  data = df,
  x = df$z_mean_narrow,
  y = df$narrow,
  domain = "emotion"
)
