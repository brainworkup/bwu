## ---- 01-filter-iq -------------
data <- bwu::read_data(pheno = "iq")

domains <- c("Intelligence/General Ability")

scales <- c(
  "Cognitive Efficiency",
  "Cognitive Proficiency (CPI)",
  "Cognitive Proficiency Index",
  "Cognitive Proficiency",
  "Crystallized Knowledge Index",
  "Crystallized Knowledge",
  "Fluid Reasoning (FRI)",
  "Fluid Reasoning Index",
  "Fluid Reasoning",
  "Full Scale (FSIQ)",
  "General Ability (GAI)",
  "General Ability Index",
  "General Ability",
  "General Intelligence",
  "NAB Attention Index",
  "NAB Executive Functions Index",
  "NAB Language Index",
  "NAB Memory Index",
  "NAB Spatial Index",
  "NAB Total Index",
  "Nonverbal (NVI)",
  "Perceptual Reasoning (PRI)",
  "Processing Speed (PSI)",
  "Processing Speed Index",
  "Processing Speed",
  "RBANS Total Index",
  "Test of Premorbid Functioning",
  "TOPF Standard Score",
  "Verbal Comprehension (VCI)",
  "Visual Spatial (VSI)",
  "Vocabulary Acquisition (VAI)",
  "Word Reading",
  "Working Memory (WMI)",
  "Working Memory Index",
  "Working Memory"
)

data <- bwu::filter_domain_scale(data, domain = domains, scale = scales)

## ---- 02-glue-iq ------------
bwu::flatten_scale_text(data, file = "02.02_iq.md")

## ---- 03-table-iq ------------
iq <-
  bwu::make_tibble(data,
                   pheno = domains) |>
  dplyr::filter(Scale %in% scales) |>
  dplyr::arrange(Test)

## ---- 04-kable-iq ------------------
tbl_kbl_iq <- bwu::tbl_kbl(data = iq)
tbl_kbl_iq

# Try qtbl too
options(tikzDefaultEngine = "xetex")

source_note <- gt::md("*Note:* Index scores have a mean of 100 and a standard deviation of 15.")

table_name <- "table_iq"
pheno <- "iq"

bwu::make_tbl_gt(data,
                 pheno = pheno,
                 source_note = source_note,
                 table_name = table_name
                 )

## ---- 05-df-iq ------------
pheno <- "iq"

iq <- dplyr::filter(
  data,
  scale %in% c("General Ability", "Crystallized Knowledge", "Fluid Reasoning",
               "Premorbid Ability", "TOPF Standard Score", "Word Reading")
)

## ---- 06-plot-subdomain-iq --------------------
bwu::make_fig(
  data = iq,
  pheno = pheno,
  x = iq$z_mean_subdomain,
  y = iq$subdomain,
  colors = NULL
)

## ---- 07-plot-narrow-iq -------------------
bwu::make_fig(
  data = iq,
  pheno = pheno,
  x = iq$z_mean_narrow,
  y = iq$narrow,
  colors = tokyo
)
