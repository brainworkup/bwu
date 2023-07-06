## ---- 01-filter-academics ----
filter_academics <- c(
  ## WRAT5
  "Word Reading",
  "Math Computation",
  "Spelling",
  "Sentence Comprehension",
  "Reading Composite",
  ## CELF-3 Preschool
  "Academic Language Readiness Index",
  ## KTEA-3
  "Academic Skills Battery (ASB) Composite",
  "Math Concepts & Applications",
  "Letter & Word Recognition",
  "Written Expression",
  "Math Computation",
  "Spelling",
  "Reading Comprehension",
  "Reading Composite",
  "Math Composite",
  "Written Language Composite",
  "Sound-Symbol Composite",
  "Phonological Processing",
  "Nonsense Word Decoding",
  "Decoding Composite",
  "Reading Fluency Composite",
  "Silent Reading Fluency",
  "Word Recognition Fluency",
  "Decoding Fluency",
  "Reading Understanding Composite",
  "Reading Vocabulary",
  "Oral Language Composite",
  "Associational Fluency",
  "Listening Comprehension",
  "Oral Expression",
  "Oral Fluency Composite",
  "Object Naming Facility",
  "Comprehension Composite",
  "Expression Composite",
  "Orthographic Processing Composite",
  "Letter Naming Facility",
  "Academic Fluency Composite",
  "Writing Fluency",
  "Math Fluency",
  ## WAIS
  # "Arithmetic"
  ## WIAT-4
  "Alphabet Writing Fluency",
  "Basic Reading",
  "Decoding Fluency",
  "Decoding",
  "Dyslexia Index",
  "Essay Composition",
  "Expressive Vocabulary",
  "Listening Comprehension",
  "Math Fluency-Addition",
  "Math Fluency-Multiplication",
  "Math Fluency-Subtraction",
  "Math Fluency",
  "Math Problem Solving",
  "Mathematics",
  "Numerical Operations",
  "Oral Discourse Comprehension",
  "Oral Expression",
  "Oral Reading Fluency",
  "Oral Word Fluency",
  "Orthographic Choice",
  "Orthographic Fluency",
  "Orthographic Processing Extended",
  "Orthographic Processing",
  "Phonemic Proficiency",
  "Phonological Processing",
  "Pseudoword Decoding",
  "Reading Comprehension",
  "Reading Fluency",
  "Reading",
  "Receptive Vocabulary",
  "Sentence Composition",
  "Sentence Repetition",
  "Sentence Writing Fluency",
  "Spelling",
  "Total Achievement",
  "Word Reading",
  "Written Expression"
)

## ---- 02-glue-academics ----
xfun::cache_rds({
  # write your time-consuming code in this expression
  dt <-
    neurocog |>
    tidytable::filter(scale %in% filter_academics) |>
    tidytable::arrange(desc(percentile)) |>
    tidytable::distinct(.keep_all = FALSE)

  dt |>
    glue::glue_data() |>
    purrr::modify(purrr::lift(paste0)) |>
    cat(dt$result,
      file = "02.03_academics.md",
      fill = TRUE,
      append = TRUE
    )
})

## ---- 03-table-academics ----
tb <-
  bwu::make_tibble(
    tibb = academics,
    data = neurocog,
    pheno = "Academic Skills"
  ) |>
  tidytable::filter(Scale %in% filter_academics) |>
  tidytable::arrange(Test) |>
  tidytable::arrange(Subdomain)

## ---- 04-kable-academics ----
kableExtra::kbl(
  tb[, 1:4],
  "latex",
  longtable = FALSE,
  booktabs = TRUE,
  linesep = "",
  align = c("lccc"),
  caption = "(ref:academics)"
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
  kableExtra::footnote("(ref:fn-acad)")

## ---- 05-df-academics ----
school <-
  neurocog |>
  tidytable::filter(domain == "Academic Skills") |>
  tidytable::filter(!is.na(percentile)) |>
  tidytable::arrange(test_name) |>
  tidytable::filter(scale %in% filter_academics)

## ---- 06-plot-subdomain-academics ----
bwu::dotplot(
  data = school,
  x = df$z_mean_sub,
  y = df$subdomain,
  domain = "academics"
)

## ---- 07-plot-narrow-academics -----
library(ggplot2)
library(ggthemes)
library(ggpubr)
library(scales)

ggplot2::ggplot(data = school) +
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
    k = length(unique(school$narrow)),
    size = 6) +
  theme_fivethirtyeight() +
  theme(panel.background = element_rect(fill = "white")) +
  theme(plot.background = element_rect(fill = "white")) +
  theme(panel.border = element_rect(color = "white"))

# library(ggpubr)
# ggdotchart(
#   df,
#   x = "narrow",
#   y = "z_mean_narrow",
#   # Color by groups
#   color = "narrow",
#   # Custom color palette
#   palette = get_palette(
#     c("#190D33", "#2A133C", "#3A1A46", "#4A224F", "#5A2D59", "#693964",
#       "#75456B", "#7E5273", "#855E78", "#89687C", "#8C737F", "#8E7C83",
#       "#8F8686", "#919088", "#92998B", "#95A48E", "#97AD91", "#9AB893",
#       "#A1C599", "#ABD29F", "#BAE1AA", "#CEEEB7", "#E0F6C3", "#F0FCCE",
#       "#FEFED8"),
#     10),
#   # Sort value in descending order
#   sorting = "descending",
#   # Add segments from y = 0 to dots
#   add = "segments",
#   add.params = list(color = "black", size = 0.5),
#   rotate = TRUE,
#   dot.size = 6,
#   ggtheme = theme_pubr() +
#     theme(legend.position = "none", axis.title.x = element_blank())
#   )

# bwu::dotplot(
#   data = df,
#   x = df$z_mean_narrow,
#   y = df$narrow,
#   domain = "academics"
# )
