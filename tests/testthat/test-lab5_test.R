context("Main Inputs")

test_that("Error messages are returned for erronous input in the get_municipality_code function", {
  municipality1 <- "Nowhere"
  expect_error(get_municipality_code(municipality1))
})
test_that("Error messages are returned when the two inputs are the same", {
  municipality1 <- "Linköping"
  expect_error(compare_inhabitants(municipality1, municipality1))
})