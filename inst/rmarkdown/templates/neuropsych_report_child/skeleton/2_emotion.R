## ---- 01-filter-emotion ---------
filter_domain <- list(
  # BASC-3
  "Externalizing Problems",
  "Hyperactivity",
  "Aggression",
  "Conduct Problems",
  "Internalizing Problems",
  "Anxiety",
  "Depression",
  "Somatization",
  "Behavioral Symptoms Index",
  "Atypicality",
  "Withdrawal",
  "Attention Problems",
  "Adaptive Skills",
  "Adaptability",
  "Social Skills",
  "Leadership",
  "Activities of Daily Living",
  "Functional Communication",
  "Personal Adjustment",
  "School Problems",
  "Inattention/Hyperactivity",
  "Emotional Symptoms Index",
  "Personal Adjustment",
  "Attitude to School",
  "Attitude to Teachers",
  "Locus of Control",
  "Social Stress",
  "Sense of Inadequacy",
  "Relations with Parents",
  "Interpersonal Relations",
  "Self-Esteem",
  "Self-Reliance",
  "Sensation Seeking",
  "Somatization",
  # BDI-2
  "Total Score",
  # BAI-2
  "Total Score"
)

## ---- 02-glue-emotion ------------
dt <-
  neurobehav %>%
  dplyr::filter(scale %in% filter_domain) %>%
  tidytable::arrange(desc(percentile)) %>%
  dplyr::distinct(.keep_all = FALSE)

dt %>%
  glue::glue_data() %>%
  purrr::modify(lift(paste0)) %>%
  cat(dt$result,
    file = "2_emotion.md",
    fill = TRUE,
    append = TRUE
  )

## ---- 03-table-emotion ------------
tb <-
  bwu::make_tibble(
    tibb = tb,
    data = neurobehav,
    pheno = "Behavioral/Emotional/Social"
  ) %>%
  dplyr::filter(Scale %in% filter_domain) %>%
  tidytable::arrange(Test) %>%
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
  kableExtra::add_footnote("(ref:basc3-prs-srp-fn)")

## ---- 05-df-emotion -----------------------------------
df <-
  neurobehav %>%
  dplyr::filter(!is.na(percentile)) %>%
  dplyr::filter(scale %in% filter_domain)

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
