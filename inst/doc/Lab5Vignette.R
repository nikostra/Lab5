## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(Lab5)

## -----------------------------------------------------------------------------
compare_inhabitants("Linköping","Norrköping")

## -----------------------------------------------------------------------------
compare_inhabitants("Linköping","Norrköping", return_data = TRUE)

