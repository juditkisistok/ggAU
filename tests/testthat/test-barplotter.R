iris = dplyr::mutate(iris, Petal_mean = ifelse(Petal.Length > mean(Petal.Length), "above_mean", "below_mean"))

test_that("function returns a ggplot object", {
  p = barplotter(data = iris, x_val = "Species", y_val = "Petal_mean")

  expect_equal(class(p), c("gg", "ggplot"))
})

test_that("fill aesthetic is correct", {
  p = barplotter(data = iris, x_val =  "Species", y_val = "Petal_mean")

  g = ggplot2::ggplot_build(p)

  expect_true(all(unique(g$data[[1]]["fill"]) == c("#655a9f", "#003d73")))
})

test_that("fill aesthetic is correct for custom palettes", {
  p = barplotter(data = iris, x_val =  "Species", y_val = "Petal_mean",
                 style = "custom", colors = c("red", "blue"))

  g = ggplot2::ggplot_build(p)

  expect_true(all(unique(g$data[[1]]["fill"]) == c("#003d73", "#e2001a")))
})

test_that("title and labels are correct", {
  test_labs = c("Test title", "Test X", "Test Y")
  p = barplotter(data = iris, x_val =  "Species", y_val = "Petal_mean",
                    title = test_labs[1], x_lab = test_labs[2], y_lab = test_labs[3])

  plot_labs = c(p[["labels"]][["title"]],
                p[["labels"]][["x"]],
                p[["labels"]][["y"]])

  expect_equal(test_labs, plot_labs)
})
