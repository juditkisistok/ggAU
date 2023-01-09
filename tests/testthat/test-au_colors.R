test_that("function returns a vector", {
  expect_equal(class(au_colors()), "character")
})

test_that("function returns the correct names", {
  expect_equal(names(au_colors("red")), "red")
})

test_that("function returns the correct number of colors", {
  expect_equal(length(au_colors("red", "blue", "green")), 3)
})

test_that("function returns the correct hex codes", {
  expect_equal(unname(au_colors("red", "blue", "green")),
               c("#e2001a", "#003d73", "#8bad3f"))
})

test_that("if no argument is passed in, all colors are returned", {
  expect_equal(length(au_colors()), 27)
})
