# dummy test
test_that("Deck has 52 cards", {
  expect_equal(nrow(deck), 52L)
})
