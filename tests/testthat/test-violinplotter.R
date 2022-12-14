test_that("function returns a ggplot object", {
  p = violinplotter(data = iris, x_val =  "Species", y_val = "Petal.Width")

  expect_equal(class(p), c("gg", "ggplot"))
})

test_that("in-function filtering works", {

})

test_that("color aesthetic is correct", {

})

test_that("fill aesthetic is correct", {

})

test_that("n is hidden when display_n is FALSE", {

})

test_that("title and labels are correct", {

})
