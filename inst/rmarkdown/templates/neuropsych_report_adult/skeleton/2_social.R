## ---- 01-filter-social -------------
filter_domain <- c(
  ### Social Cognition
  ## NEPSY2
  "Affect Recognition",
  "Theory of Mind",
  "Theory of Mind Verbal",
  "Affect Recognition Happy Errors",
  "Affect Recognition Sad Errors",
  "Affect Recognition Neutral Errors",
  "Affect Recognition Fear Errors",
  "Affect Recognition Angry Errors",
  "Affect Recognition Disgust Errors",
  ## ACS Social Cognition
  "Social Perception",
  "Affect Naming",
  "Prosody-Face Matching",
  "Prosody-Pair Matching",
  "Faces I",
  "Faces II",
  "Names I",
  "Names II",
  ## CARS-2
  "CARS-2 HF Total Score"
)

## ---- 02-glue-social ------------
dt <-
  neurocog %>%
  dplyr::filter(scale %in% filter_domain) %>%
  dplyr::arrange(desc(percentile)) %>%
  dplyr::distinct(.keep_all = FALSE)

dt %>%
  glue::glue_data() %>%
  purrr::modify(lift(paste0)) %>%
  cat(dt$result,
    file = "2_social.md",
    fill = TRUE,
    append = TRUE
  )

## ---- 03-table-social ------------
tb <-
  bwu::make_tibble(
    tibb = social,
    data = neurocog,
    pheno = "Social Cognition"
  ) %>%
  dplyr::filter(Scale %in% filter_domain) %>%
  dplyr::arrange(Test)

## ---- 04-kable-social ------------------
kableExtra::kbl(
  tb[, 1:4],
  "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc"),
  caption = "(ref:social)"
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
  kableExtra::add_footnote("(ref:fn-soc)")

## ---- 05-df-social ------------
df <-
  neurocog %>%
  dplyr::filter(domain == "Social Cognition") %>%
  dplyr::filter(!is.na(percentile)) %>%
  dplyr::arrange(test_name) %>%
  dplyr::filter(scale %in% filter_domain)

## ---- 06-plot-subdomain-social -----------------
bwu::dotplot(
  data = df,
  x = df$z_mean_sub,
  y = df$subdomain,
  domain = "social"
)

## ---- 07-plot-narrow-social -------------------
bwu::dotplot(
  data = df,
  x = df$z_mean_narrow,
  y = df$narrow,
  domain = "social"
)
