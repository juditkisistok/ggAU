test_that("function returns a ggplot object", {
  p = violinplotter(data = iris, x_val =  "Species", y_val = "Petal.Width")

  expect_equal(class(p), c("gg", "ggplot"))
})

test_that("in-function filtering works", {
  p = violinplotter(data = iris, x_val =  "Species", y_val = "Petal.Width",
                    filter = TRUE, filter_col = "Species", filter_val = c("setosa", "virginica"))

  expect_true(all(p[["plot_env"]][["data"]]$Species %in% c("setosa", "virginica")))
})

test_that("color aesthetic is correct", {
  p = violinplotter(data = iris, x_val =  "Species", y_val = "Petal.Width")

  g = ggplot2::ggplot_build(p)

  expect_true(all(unique(g$data[[1]]["colour"]) == c("#003d73", "#655a9f", "#37a0cb")))
})

test_that("color aesthetic is correct for custom palettes", {
  p = violinplotter(data = iris, x_val =  "Species", y_val = "Petal.Width",
                    col_style = "custom", col_vec = c("red", "blue", "yellow"))

  g = ggplot2::ggplot_build(p)

  expect_true(all(unique(g$data[[1]]["colour"]) == c("#e2001a", "#003d73", "#fabb00")))
})

test_that("fill aesthetic is correct", {
  p = violinplotter(data = iris, x_val =  "Species", y_val = "Petal.Width")

  g = ggplot2::ggplot_build(p)

  expect_true(all(unique(g$data[[2]]["fill"]) == c("#003d73", "#655a9f", "#37a0cb")))
})

test_that("fill aesthetic is correct for custom palettes", {
  p = violinplotter(data = iris, x_val =  "Species", y_val = "Petal.Width",
                    fill_style = "custom", fill_vec = c("red", "blue", "yellow"))

  g = ggplot2::ggplot_build(p)

  expect_true(all(unique(g$data[[2]]["fill"]) == c("#e2001a", "#003d73", "#fabb00")))
})

test_that("n is hidden when display_n is FALSE", {
  p = violinplotter(data = iris, x_val =  "Species", y_val = "Petal.Width",
                    display_n = FALSE)

  expect_equal(p[["labels"]][["title"]], "")
})

test_that("title and labels are correct", {
  test_labs = c("Test title", "Test X", "Test Y")
  p = violinplotter(data = iris, x_val =  "Species", y_val = "Petal.Width",
                    title = test_labs[1], x_lab = test_labs[2], y_lab = test_labs[3],
                    display_n = FALSE)

  plot_labs = c(p[["labels"]][["title"]],
                p[["labels"]][["x"]],
                p[["labels"]][["y"]])

  expect_equal(test_labs, plot_labs)
})
