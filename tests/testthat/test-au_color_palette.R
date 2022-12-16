test_that("function returns a vector", {
  expect_equal(class(au_color_palette()), "character")
})

test_that("function returns a named vector", {
  expect_equal(names(au_color_palette()),
               c("blue", "purple", "cyan", "turkis", "green",
                 "yellow", "red", "magenta"))
})

test_that("function returns the correct colors", {
  expect_equal(unname(au_color_palette(style = "test")),
               c("#003d73", "#fabb00", "#e2001a"))
})

test_that("reversing the palette works", {
  expect_equal(unname(au_color_palette(style = "test", reverse = TRUE)),
               c("#e2001a", "#fabb00", "#003d73"))
})
