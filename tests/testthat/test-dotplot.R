# # tests for dotplot()
# library(bwu)
# library(testthat)

# # Test 1 - data argument
# data <- neurocog

# # Set x and y variables
# x <- data$z_mean_narrow
# y <- data$narrow

# # Run dotplot function
# fig <- dotplot(
#   data = data,
#   x = x,
#   y = y,
#   colors = NULL
# )


# # Test 2 - x argument
# data <- neurocog
# fig <- dotplot(
#   data = data,
#   x = NULL,
#   y = data$narrow,
#   colors = NULL
# ) # Should return an error, since x cannot be null

# # Test 3 - y argument
# data <- neurocog
# fig <- dotplot(
#   data = data,
#   x = data$z_mean_narrow,
#   y = NULL,
#   colors = NULL
# ) # Should return an error, since y cannot be null

# # Test 4 - colors argument
# data <- neurocog
# fig <- dotplot(
#   data = data,
#   x = data$z_mean_narrow,
#   y = data$narrow,
#   colors = NULL
# ) # Should return an error, since colors cannot be null
