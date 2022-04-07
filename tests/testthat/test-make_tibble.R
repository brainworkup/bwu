library(magrittr)
library(bwu)

test_that("make_tibble() tests that a tibble can be created", {
  tb <-
    make_tibble(
      tibb = executive,
      data = neurocog,
      pheno = "Attention/Executive")
})
