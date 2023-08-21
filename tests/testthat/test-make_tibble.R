library(bwu)

test_that("make_tibble() tests that a tibble can be created", {
  tbl <-
    make_tibble(
      data = bwu::neurocog,
      pheno = "Attention/Executive"
    )
})
