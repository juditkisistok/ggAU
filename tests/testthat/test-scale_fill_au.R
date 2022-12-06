test_that("discrete built-in scale works", {
  p = ggplot(iris, aes(x = Species, y = Petal.Width, fill = Species)) +
      geom_bar(stat = "identity") +
      scale_fill_au(discrete = T)

  g = ggplot_build(p)

  expect_true(all(unique(g$data[[1]]["fill"]) == c("#003d73", "#00aba4", "#8bad3f")))
})

test_that("custom discrete scale works", {
  p = ggplot(iris, aes(x = Species, y = Petal.Width, fill = Species)) +
      geom_bar(stat = "identity") +
      scale_fill_au(style = "custom", discrete = T, colors = c("blue", "red", "yellow"))

  g = ggplot_build(p)

  expect_true(all(unique(g$data[[1]]["fill"]) == c("#003d73", "#e2001a", "#fabb00")))
})
