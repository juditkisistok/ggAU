test_that("discrete built-in scale works", {
  p = ggplot2::ggplot(iris, ggplot2::aes(x = Petal.Length, y = Petal.Width, color = Species)) +
    ggplot2::geom_point() +
    scale_color_au(discrete = T)

  g = ggplot2::ggplot_build(p)

  expect_true(all(unique(g$data[[1]]["colour"]) == c("#003d73", "#655a9f", "#37a0cb")))
})

test_that("custom discrete scale works", {
  p = ggplot2::ggplot(iris, ggplot2::aes(x = Petal.Length, y = Petal.Width, color = Species)) +
    ggplot2::geom_point() +
    scale_color_au(discrete = T, style = "custom", colors = c("blue", "red", "yellow"))

  g = ggplot2::ggplot_build(p)

  expect_true(all(unique(g$data[[1]]["colour"]) == c("#003d73", "#e2001a", "#fabb00")))
})

test_that("built-in continuous scale works", {
  p = ggplot2::ggplot(iris, ggplot2::aes(x = Petal.Length, y = Petal.Width, color = Petal.Width)) +
    ggplot2::geom_point() +
    scale_color_au()

  g = ggplot2::ggplot_build(p)

  expect_equal(nrow(unique(g$data[[1]]["colour"])), length(unique(iris$Petal.Width)))
})

test_that("custom continuous scale works", {
  p = ggplot2::ggplot(iris, ggplot2::aes(x = Petal.Length, y = Petal.Width, color = Petal.Width)) +
    ggplot2::geom_point() +
    scale_color_au(style = "custom", colors = c("yellow", "red"))

  g = ggplot2::ggplot_build(p)

  expect_equal(nrow(unique(g$data[[1]]["colour"])), length(unique(iris$Petal.Width)))
})

test_that("continuous built-in scale applies correct colors", {
  iris$binary <- rep_len(c(-1, 0, 1), 150)

  p = ggplot2::ggplot(iris, ggplot2::aes(x = Petal.Width, y = Petal.Length, color = binary)) +
    ggplot2::geom_point() +
    scale_color_au(style = "hotandcold")

  g = ggplot2::ggplot_build(p)

  expect_true(all(unique(g$data[[1]]["colour"]) == c("#003D73", "#FFFFFF", "#E2001A")))
})

test_that("continuous custom scale applies correct colors", {
  iris$binary <- rep_len(c(-1, 0, 1), 150)

  p = ggplot2::ggplot(iris, ggplot2::aes(x = Petal.Width, y = Petal.Length, color = binary)) +
    ggplot2::geom_point() +
    scale_color_au(style = "custom", colors = c("yellow", "white", "green"))

  g = ggplot2::ggplot_build(p)

  expect_true(all(unique(g$data[[1]]["colour"]) == c("#FABB00", "#FFFFFF", "#8BAD3F")))
})
