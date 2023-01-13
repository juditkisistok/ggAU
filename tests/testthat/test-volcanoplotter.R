test_that("function returns a ggplot object", {
  p = volcanoplotter(data = volcanodata, x_val = "logFC", y_val = "adj.P.Val")

  expect_equal(class(p), c("gg", "ggplot"))
})

test_that("the correct colors are used", {
  p = volcanoplotter(data = volcanodata, x_val = "logFC", y_val = "adj.P.Val",
                     sig_neg_col = au_colors("trxblue"), sig_pos_col = au_colors("trxred"))

  g = ggplot2::ggplot_build(p)

  expect_true(all(
    unique(g[["data"]][[2]][["colour"]] == "#8A3A39"),
    unique(g[["data"]][[3]][["colour"]] ==  "#36648B")))

  expect_equal(class(p), c("gg", "ggplot"))
})

test_that("the correct number of labels is added", {
  p = volcanoplotter(data = volcanodata, x_val = "logFC", y_val = "adj.P.Val",
                     add_labels = T, label_col = "SYMBOL")

  g = ggplot2::ggplot_build(p)

  expect_equal(
    length(unique(g[["data"]][[5]][["label"]])) + length(unique(g[["data"]][[4]][["label"]])),
    20)
})

test_that("title and axis labels are correct", {
  test_labs = c("Test title", "Test X", "Test Y")
  p = volcanoplotter(data = volcanodata, x_val = "logFC", y_val = "adj.P.Val",
                    title = test_labs[1], x_lab = test_labs[2], y_lab = test_labs[3])

  plot_labs = c(p[["labels"]][["title"]],
                p[["labels"]][["x"]],
                p[["labels"]][["y"]])

  expect_equal(test_labs, plot_labs)
})
