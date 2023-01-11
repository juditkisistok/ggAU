test_that("function returns a ggplot object", {
  p = scatterplotter(data = iris, x_val = "Petal.Width", y_val = "Petal.Length")

  expect_equal(class(p), c("gg", "ggplot"))
})

test_that("color aesthetic is correct when using a column for coloring", {
  p = scatterplotter(data = iris, x_val = "Petal.Width", y_val = "Petal.Length",
                     col_val = "Species")

  g = ggplot2::ggplot_build(p)

  expect_true(all(unique(g$data[[1]]["colour"]) == c("#003d73", "#655a9f", "#37a0cb")))
})

test_that("color aesthetic is correct for custom palettes when using a column for coloring", {
  p = scatterplotter(data = iris, x_val = "Petal.Width", y_val = "Petal.Length",
                     col_val = "Species", style = "custom", colors = c("red", "blue", "trxyellow"))

  g = ggplot2::ggplot_build(p)

  expect_true(all(unique(g$data[[1]]["colour"]) == c("#e2001a", "#003d73", "#CFAD6A")))
})

test_that("if no color column is selected, then the user-defined point color is used in single mode", {
  p = scatterplotter(data = iris, x_val = "Petal.Width", y_val = "Petal.Length",
                     fit = "single", pointcolor = au_colors("trxred"))

  g = ggplot2::ggplot_build(p)

  expect_true(all(unique(g$data[[1]]["colour"]) == "#8A3A39"))
})

test_that("if color column is selected in single mode, then colors, point size and opacity work", {
  p = scatterplotter(data = iris, x_val = "Petal.Width", y_val = "Petal.Length",
                     col_val = "Species", pointsize = 3, point_alpha = 0.5,
                     fit = "single")

  g = ggplot2::ggplot_build(p)

  expect_true(all(
    g$data[[1]]["alpha"] == 0.5,
    g$data[[1]]["size"] == 3,
    unique(g$data[[1]]["colour"]) == c("#003d73", "#655a9f", "#37a0cb")))

})

test_that("if grouped mode is selected, three lines are fit", {
  p = scatterplotter(data = iris, x_val = "Petal.Width", y_val = "Petal.Length",
                     col_val = "Species", fit = "grouped")

  g = ggplot2::ggplot_build(p)

  expect_true(all(unique(g$data[[2]]["colour"]) == c("#003d73", "#655a9f", "#37a0cb")))

})

test_that("legend key labeling works", {
  p  = scatterplotter(data = iris, x_val = "Petal.Width", y_val = "Petal.Length",
                      labels = c("one", "two", "three"), col_val = "Species")

  g = ggplot2::ggplot_build(p)

  expect_equal(g$plot$scales$scales[[1]]$labels, c("one", "two", "three"))
})
