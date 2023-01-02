#' Create barplots
#'
#' Enables the creation of barplots in a convenient and customizable manner,
#' and calculates the associated Fisher's test p-value on the count data.
#'
#' @param data The `data.frame` to be used for the visualization.
#' @param x_val string, the name of the column to plot on the x axis.
#' @param y_val string, the name of the column to plot on the y axis.
#' @param order vector, the order in which the bars should appear. It should include all unique values in `x_val` in the desired order.
#' @param scale_labs vector, names to display on the x axis ticks. By default, it shows the names as they appear in `x_val`.
#' @param pct boolean, if `TRUE`, percentages are displayed on the bars, if `FALSE`, the absolute numbers are shown.
#' @param style string, palette style to be used for `scale_fill_au`. Default is `light`.
#' @param colors vector containing the colors to be used for the `fill` aesthetic. Default is `au_colors()`.
#' Custom colors are only applied when `fill_style = "custom"`.
#' @param y_lab string, the y axis label.
#' @param x_lab string, the x axis label.
#' @param title string, the title of the plot to be displayed on top.
#' @param labcol string, the color of the annotation numbers displayed inside the bars. The default is black.
#' @param legend_lab string, the legend title. Default is `y`.
#' @param labels vector, the legend annotations. Default is the unique values in `y_val`.
#'
#' @return A ggplot object.
#' @export
#'
#' @examples
#' iris = dplyr::mutate(iris, Petal_mean = ifelse(Petal.Length > mean(Petal.Length),
#'"above_mean", "below_mean"))
#'
#' barplotter(data = iris, x_val = "Species", y_val = "Petal_mean", labcol = "white")
#'
barplotter = function(data, x_val, y_val, order = NA, scale_labs = NA,
                      pct = T, style = "light", colors = au_colors(), y_lab = "y",
                      x_lab = "x", title = "", labcol = "black",
                      legend_lab = NA, labels = NA) {
  data = data %>%
    dplyr::select(!!x_val, !!y_val) %>%
    dplyr::group_by(get(x_val), get(y_val)) %>%
    dplyr::count() %>%
    dplyr::group_by(`get(x_val)`) %>%
    dplyr::mutate(x = signif(n / sum(n) * 100, digits = 3)) %>%
    purrr::set_names(c('x', 'y', 'number', 'percent'))

  fishers_df = data %>%
    tidyr::pivot_wider(values_from = number, names_from = y, id_cols = x, values_fill = 0) %>%
    tibble::column_to_rownames('x')

  if (is.na(order[1])) {
    order = c(unique(data$x))
  }

  if (is.na(scale_labs[1])) {
    scale_labs = c(unique(data$x))
  }

  stat_title = paste0("Fisher's exact test p = ", signif(stats::fisher.test(fishers_df)$p, digits = 3))

  if (pct) {
    p = ggpubr::ggbarplot(data, "x", "percent", lab.pos = "in", fill = "y",
                          label = TRUE, order = order, lab.col = labcol)
  } else {
    p = ggpubr::ggbarplot(data, "x", "number", lab.pos = "in", fill = "y",
                          label = TRUE, order = order, lab.col = labcol)
  }

  p = p +
    ggplot2::ylab(y_lab) +
    ggplot2::xlab(x_lab) +
    ggplot2::ggtitle(label = title, subtitle = stat_title) +
    ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5),
          plot.subtitle = ggplot2::element_text(hjust = 0.5)) +
    ggplot2::scale_x_discrete(labels = scale_labs)

  if (!is.na(legend_lab)) {
    p = p +
      ggplot2::labs(fill = legend_lab)
  }

  if (!is.na(labels[1])) {
    p = p +
      scale_fill_au(discrete = TRUE, style = style, colors = colors, labels = labels)
  } else {
    p = p +
      scale_fill_au(discrete = TRUE, style = style, colors = colors)
  }

  return (p)
}
