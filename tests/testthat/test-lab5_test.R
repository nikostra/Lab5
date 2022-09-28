

df_LN <-data.frame("year" = 1970:2021, "municipality_code.1" = "0580", 
                   "Inhabitants.Linköping" = c(104646, 105807, 106643, 107033, 108034,
                                               109236, 110053, 110779, 111424, 111866,
                                               112600, 113330, 113993, 114681, 115600,
                                               116838, 117835, 118602, 119167, 120562,
                                               122268, 124352, 126377, 128610, 130489,
                                               131370, 131898, 132089, 131948, 132500,
                                               133168, 134039, 135066, 136231, 136912,
                                               137636, 138580, 140367, 141863, 144690,
                                               146416, 147334, 148521, 150202, 151881,
                                               152966, 155817, 158520, 161034, 163051,
                                               164616, 165527),
                   "municipality_code.2" = "0581", 
                   "Inhabitants.Norrköping" = c(120959, 121262, 120778, 120341, 119470,
                                                119169, 119967, 120647, 120251, 119993,
                                                119238, 118626, 118236, 118064, 118451,
                                                118567, 118801, 119001, 119370, 119921,
                                                120522, 120756, 120798, 121028, 123240,
                                                123795, 123531, 123049, 122415, 122212,
                                                122199, 122896, 123303, 123971, 124410,
                                                124642, 125463, 126680, 128060, 129254,
                                                130050, 130623, 132124, 133749, 135283,
                                                137035, 139363, 140927, 141676, 143171,
                                                143478, 144458))

test_that("Error is returned for erronous input in the get_municipality_code function", {
  municipality1 <- "Nowhere"
  expect_error(get_municipality_code(municipality1))
})
test_that("Error message returned for erronous input clarifies the cause of error", {
expect_that(compare_inhabitants("Nowhere", "Linköping"),
            throws_error("municipality is not in the database."))
})
test_that("Error is returned when the two inputs are identical", {
  municipality1 <- "Linköping"
  expect_error(compare_inhabitants(municipality1, municipality1))
})

test_that("Error message returned for identical inputs suggests a solution", {
  expect_that(compare_inhabitants("Linköping", "Linköping"),
              throws_error("Please select two different municipalities."))
})
test_that("Non character inputs return an error", {
  municipality1 <- 1
  municipality2 <- "Linköping"
  expect_error(get_municipality_code(municipality1,municipality2))
})
test_that("Error message returned for non character inputs clarify the error cause", {
  expect_that(compare_inhabitants("Linköping", 1),
              throws_error("The inputs should be strings."))
})

test_that("Function gives the correct outputs", {
  expect_equal(compare_inhabitants("Linköping", "Norrköping", return_data = TRUE), df_LN)
})

test_that("The function fails when arguments are missing", {
  expect_error(compare_inhabitants(municipality2))
})

# test_that("The function gathers the correct municipality codes", {
#   municipality <- "Linköping"
#   expect_equal(get_municipality_code(municipality), "0580")
# })
