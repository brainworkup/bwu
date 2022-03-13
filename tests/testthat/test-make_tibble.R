library(magrittr)
library(bwu)

test_that("tibble can be created", {
  make_tibble(tibb = iq,
              data = neurocog,
              pheno = "Intelligence/General Ability")
})
