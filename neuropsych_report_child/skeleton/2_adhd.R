## ---- 01-filter-adhd ---------
filter_domain <- c(
  # Brown
  "Activation",
  "Focus",
  "Effort",
  "Emotion",
  "Memory",
  "Action",
  "Total Composite",
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
  neurobehav %>%
  dplyr::filter(scale %in% filter_domain) %>%
  tidytable::arrange(desc(percentile)) %>%
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
  bwu::make_tibble(
    tibb = adhd,
    data = neurobehav,
    pheno = "Behavioral/Emotional/Social"
  ) %>%
  dplyr::filter(Scale %in% filter_domain) %>%
  tidytable::arrange(Test)

## ---- 04-kable-adhd ------------------
kableExtra::kbl(
  tb[, 1:4], "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc"),
  caption = "(ref:brown)"
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
  dplyr::filter(domain == "Behavioral/Emotional/Social") %>%
  dplyr::filter(scale %in% filter_domain) %>%
  dplyr::filter(!is.na(percentile)) %>%
  dplyr::filter(filename %in% c("brown_sr.csv", "brown_or.csv"))

## ---- 06-plot-narrow-adhd --------------------
bwu::dotplot(
  data = df,
  x = df$z_mean_narrow,
  y = df$narrow,
  domain = "attention/executive"
)
