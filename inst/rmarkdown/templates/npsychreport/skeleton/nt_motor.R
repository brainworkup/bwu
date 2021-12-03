## ---- 01-glue-motor ---------
dom <- "Motor"
mtr <- neurocog %>%
  dplyr::filter(domain == dom) %>%
  dplyr::arrange(desc(percentile)) %>%
  dplyr::distinct(.keep_all = FALSE)
trait <- mtr
lst(person, range, scale) %>%
  glue::glue_data(
    "(ref:first-name)'s score on {scale}, a measure of {description}, fell in the *{range}* range.",
    range = trait$range,
    scale = trait$scale,
    score = trait$score,
    percentile = trait$percentile,
    description = trait$description
  ) %>%
  purrr::modify(lift(paste0)) %>%
  cat(sep = "\n")

## ---- 02-make-df-motor -------------------------------
filter_motor <- c(
  # Grooved Pegboard
  "Right-Hand Time",
  "Left-Hand Time",
  # NEPSY-2
  "Fingertip Tapping-Dominant Hand",
  "Fingertip Tapping-Nondominant Hand",
  "Fingertip Tapping-Repetitions",
  "Fingertip Tapping-Sequences",
  "FT Dominant Hand vs. Nondominant Hand",
  "Imitating Hand Positions",
  "Imitating Hand Positions-Dominant",
  "Imitating Hand Positions-Nondominant",
  "Visuomotor Precision"
  # "Visuomotor Precision Time",
  # "Visuomotor Precision Errors",
  # "Visuomotor Precision Pencil Lifts"
)
motor <-
  make_tibble(
    tibb = motor,
    data = neurocog,
    pheno = "Motor"
  ) %>%
  filter(Scale %in% filter_motor) %>%
  arrange(Test)

## ---- 03-make-kable-motor ----------------
kableExtra::kbl(
  motor[, 2:5],
  "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc"),
  caption = "(ref:motor)"
) %>%
  kableExtra::kable_paper(., lightable_options = "basic") %>%
  kableExtra::kable_styling(., latex_options = c(
    "scale_down",
    "HOLD_position",
    "striped"
  )) %>%
  kableExtra::column_spec(., 1, width = "8cm") %>%
  kableExtra::row_spec(., row = 0, bold = TRUE) %>%
  kableExtra::pack_rows(., index = table(motor$Test)) %>%
  # kableExtra::row_spec(., row = c(4, 13), bold = TRUE) %>%
  # kableExtra::add_indent(., c(5:12, 14:15)) %>%
  kableExtra::add_footnote("(ref:fn-motor)")

## ---- 04-make-df-motor -------------------------------
mtr <-
  neurocog %>%
  filter(domain == "Motor") %>%
  filter(!is.na(percentile)) %>%
  filter(scale %in% filter_motor)

## ----05-plot-motor-subdomain -------------------
dotplot(
  data = mtr,
  x = mtr$z_mean_sub,
  y = mtr$subdomain,
  domain = "motor"
)

## ---- 06-plot-motor-narrow --------------------
dotplot(
  data = mtr,
  x = mtr$z_mean_narrow,
  y = mtr$narrow,
  domain = "motor"
)
