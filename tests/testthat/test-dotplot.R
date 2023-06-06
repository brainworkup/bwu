# tests for dotplot()
test_that("dotplot() returns a ggplot object", {
  data <- bwu::neurocog
  domain <- "domain"
  x <- "z_mean_dom"
  y <- "domain"

  expect_true(is(dotplot(data, x, y), "gg"), info = "expected DOTPLOT to return a ggplot object")
})
