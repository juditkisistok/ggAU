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
                    title = test_labs[1], x_lab = test_labs[2], y_lab = test_labs[3],
                    display_n = F)

  plot_labs = c(p[["labels"]][["title"]],
                p[["labels"]][["x"]],
                p[["labels"]][["y"]])

  expect_equal(test_labs, plot_labs)
})

test_that("plots showing absolute numbers work", {
  p  = barplotter(data = iris, x_val =  "Species", y_val = "Petal_mean",
                  pct = FALSE)

  g = ggplot2::ggplot_build(p)

  expect_equal(g[["plot"]][["labels"]][["label"]], "number")
})

test_that("plots showing percentages work", {
  p  = barplotter(data = iris, x_val =  "Species", y_val = "Petal_mean",
                  pct = TRUE)

  g = ggplot2::ggplot_build(p)

  expect_equal(g[["plot"]][["labels"]][["label"]], "percent")
})

test_that("legend title labeling works", {
  p  = barplotter(data = iris, x_val =  "Species", y_val = "Petal_mean",
                  legend_lab = "test")

  g = ggplot2::ggplot_build(p)

  expect_equal(g[["plot"]][["labels"]][["fill"]], "test")
})

test_that("legend key labeling works", {
  p  = barplotter(data = iris, x_val =  "Species", y_val = "Petal_mean",
                  labels = c("one", "two"))

  g = ggplot2::ggplot_build(p)

  expect_equal(g$plot$scales$scales[[2]]$labels, c("one", "two"))
})

test_that("filtering works", {
  iris_filtered = iris %>%
    dplyr::filter(Species %in% c("setosa", "virginica"))

  p  = barplotter(data = iris, x_val =  "Species", y_val = "Petal_mean",
                  filter_col = "Species", filter_val = c("setosa", "virginica"))

  q  = barplotter(data = iris_filtered, x_val =  "Species", y_val = "Petal_mean")

  expect_equal(p, q)
})
