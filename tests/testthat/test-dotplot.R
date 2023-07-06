# # tests for dotplot()
# test_that("dotplot() returns a ggplot object", {
#   data <- bwu::neurocog
#   x <- "z_mean_dom"
#   y <- "domain"
#
#   expect_true(is(dotplot(data, x, y), "gg"), info = "expected DOTPLOT to return a ggplot object")
# })
#
# # Test 1 - data argument
# dotplot(data = NULL) # Should return an error, since data cannot be null
#
# # Test 2 - x argument
# dotplot(data = mtcars, x = "mpg") # Should return a dot plot with mpg on the x-axis
#
# # Test 3 - linewidth argument
# dotplot(data = mtcars, x = "mpg", linewidth = 0.8) # Should return a dot plot with line width of 0.8
#
# # Test 4 - fill argument
# dotplot(data = mtcars, x = "mpg", linewidth = 0.5, fill = "hp") # Should return a dot plot with hp as the fill variable
#
# # Test 5 - colors argument
# dotplot(data = mtcars, x = "mpg", linewidth = 0.5, fill = "hp", colors = c("#000000", "#FFFFFF")) # Should return a dotplot with the given color palette
