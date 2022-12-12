test_that("discrete built-in scale works", {
  p = ggplot2::ggplot(iris, ggplot2::aes(x = Species, y = Petal.Width, fill = Species)) +
      ggplot2::geom_bar(stat = "identity") +
      scale_fill_au(discrete = T)

  g = ggplot2::ggplot_build(p)

  expect_true(all(unique(g$data[[1]]["fill"]) == c("#003d73", "#655a9f", "#37a0cb")))
})

test_that("custom discrete scale works", {
  p = ggplot2::ggplot(iris, ggplot2::aes(x = Species, y = Petal.Width, fill = Species)) +
      ggplot2::geom_bar(stat = "identity") +
      scale_fill_au(style = "custom", discrete = T, colors = c("blue", "red", "yellow"))

  g = ggplot2::ggplot_build(p)

  expect_true(all(unique(g$data[[1]]["fill"]) == c("#003d73", "#e2001a", "#fabb00")))
})

test_that("continuous built-in scale works", {
  dummy_data <- expand.grid(x = paste0("var_", seq(1, 10)),
                            y = paste0("var_", seq(11, 20)))
  dummy_data$z <- runif(100, -1, 1)

  p = ggplot2::ggplot(dummy_data, ggplot2::aes(x, y, fill = z)) +
      ggplot2::geom_tile() +
      scale_fill_au(style = "hotandcold")

  g = ggplot2::ggplot_build(p)

  expect_equal(nrow(g$data[[1]]["fill"]), 100)
})

test_that("continuous custom scale works", {
  dummy_data <- expand.grid(x = paste0("var_", seq(1, 10)),
                            y = paste0("var_", seq(11, 20)))
  dummy_data$z <- runif(100, -1, 1)

  p = ggplot2::ggplot(dummy_data, ggplot2::aes(x, y, fill = z)) +
      ggplot2::geom_tile() +
      scale_fill_au(style = "custom", colors = c("yellow", "white", "red"))

  g = ggplot2::ggplot_build(p)

  expect_equal(nrow(g$data[[1]]["fill"]), 100)
})

test_that("continuous built-in scale applies correct colors", {
  dummy_data <- expand.grid(x = paste0("var_", seq(1, 10)),
                            y = paste0("var_", seq(11, 20)))
  dummy_data$z <- rep_len(c(-1, 0, 1), 100)

  p = ggplot2::ggplot(dummy_data, ggplot2::aes(x, y, fill = z)) +
      ggplot2::geom_tile() +
      scale_fill_au(style = "hotandcold")

  g = ggplot2::ggplot_build(p)

  expect_true(all(unique(g$data[[1]]["fill"]) == c("#003D73", "#FFFFFF", "#E2001A")))
})

test_that("continuous custom scale applies correct colors", {
  dummy_data <- expand.grid(x = paste0("var_", seq(1, 10)),
                            y = paste0("var_", seq(11, 20)))
  dummy_data$z <- rep_len(c(-1, 0, 1), 100)

  p = ggplot2::ggplot(dummy_data, ggplot2::aes(x, y, fill = z)) +
      ggplot2::geom_tile() +
      scale_fill_au(style = "custom", colors = c("yellow", "white", "green"))

  g = ggplot2::ggplot_build(p)

  expect_true(all(unique(g$data[[1]]["fill"]) == c("#FABB00", "#FFFFFF", "#8BAD3F")))
})
