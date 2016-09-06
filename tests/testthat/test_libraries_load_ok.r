
context("Can we load non-base libraries?")

test_that("We can load non-base libraries", {
  expect_true("Hmisc" %in% rownames(installed.packages()))
  expect_true("dplyr" %in% rownames(installed.packages()))
  expect_true("ggplot2" %in% rownames(installed.packages()))
  expect_true("gridExtra" %in% rownames(installed.packages()))
  expect_true("readxl" %in% rownames(installed.packages()))
})



