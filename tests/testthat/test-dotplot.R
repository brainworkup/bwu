# tests for dotplot()
test_that("dotplot() returns a ggplot object", {
  data <- bwu::neurocog
  x <- data$z_mean_subdomain
  y <- data$subdomain

  expect_true(is(dotplot(data, x, y), "gg"), info = "expected DOTPLOT to return a ggplot object")
})

# Test 1 - data argument
data <- neurocog
fig <- dotplot(
  data = data,
  x = data$z_mean_subdomain,
  y = data$subdomain,
  colors = tokyo
) # Should return an error, since data cannot be null
