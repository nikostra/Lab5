context("compare_inhabitants")

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

test_that("Error messages are returned for erronous input in the get_municipality_code function", {
  municipality1 <- "Nowhere"
  expect_error(get_municipality_code(municipality1))
})
test_that("Error messages are returned when the two inputs are the same", {
  municipality1 <- "Linköping"
  expect_error(compare_inhabitants(municipality1, municipality1))
})

test_that("Function gives the correct outputs", {
expect_equal(compare_inhabitants("Linköping", "Norrköping", return_data = TRUE), df_LN)})
