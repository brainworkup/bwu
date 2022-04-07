library(lubridate)

test_that("age() calculates age in years given dob and doe", {
  dob <- as.POSIXct("1977-07-13")
  doe <- as.POSIXct("2021-04-04")


  expect_visible(age(dob, doe))

  expect_snapshot(age(dob, doe))

})
