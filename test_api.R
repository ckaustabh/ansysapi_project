library(testthat)
library(httr)

base_url <- "http://localhost:8000"

test_that("POST /data works", {
  res <- POST(paste0(base_url, "/data"), body = '{"key": "value"}', encode = "json")
  expect_equal(res$status_code, 200)
  expect_true("id" %in% names(content(res)))
})

test_that("GET /data/{id} works", {
  id <- "some_valid_id" # Replace with an actual valid ID
  res <- GET(paste0(base_url, "/data/", id))
  expect_equal(res$status_code, 200)
  expect_true("data" %in% names(content(res)))
})

test_that("PUT /data/{id} works", {
  id <- "some_valid_id" # Replace with an actual valid ID
  res <- PUT(paste0(base_url, "/data/", id), body = '{"key": "new_value"}', encode = "json")
  expect_equal(res$status_code, 200)
  expect_equal(content(res)$success, TRUE)
})

test_that("DELETE /data/{id} works", {
  id <- "some_valid_id" # Replace with an actual valid ID
  res <- DELETE(paste0(base_url, "/data/", id))
  expect_equal(res$status_code, 200)
  expect_equal(content(res)$success, TRUE)
})
