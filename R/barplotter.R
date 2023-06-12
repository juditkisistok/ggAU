#' Create barplots
#'
#' Enables the creation of barplots in a convenient and customizable manner,
#' and calculates the associated Fisher's test p-value on the count data.
#'
#' @param data The `data.frame` to be used for the visualization.
#' @param x_val string, the name of the column to plot on the x axis.
#' @param y_val string, the name of the column to plot on the y axis.
#' @param order vector, the order in which the bars should appear. It should include all unique values in `x_val` in the desired order.
#' If unspecified, the bars follow the order of the dataframe.
#' @param scale_labs vector, names to display on the x axis ticks. By default, it shows the names as they appear in `x_val`.
#' @param pct boolean, if `TRUE`, percentages are displayed on the bars, if `FALSE`, the absolute numbers are shown.
#' @param style string, palette style to be used for `scale_fill_au`. Default is `light`. Style is only applied if `colors` remains `NA`.
#' @param colors vector containing the colors to be used for the `fill` aesthetic. Default is `NA`. If unspecified, the function uses `au_colors()`.
#' @param y_lab string, the y axis label. Default is `percent`. If `pct = FALSE`, the default is `number`.
#' @param x_lab string, the x axis label. Default is the string passed into `x_val`.
#' @param title string, the title of the plot to be displayed on top. Deafult is `""`.
#' @param labcol string, the color of the annotation numbers displayed inside the bars. The default is `black`.
#' @param display_n boolean, if `TRUE`, the plot displays the sample size appended to the title. Default is `TRUE`.
#' @param legend_lab string, the legend title. Default is the string passed into `y_val`.
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

barplotter = function(data, x_val, y_val, order = NA, scale_labs = ggplot2::waiver(),
                      pct = T, style = "light", colors = NA, y_lab = ggplot2::waiver(),
                      x_lab = ggplot2::waiver(), title = "", labcol = "black", display_n = T,
                      legend_lab = NA, labels = NA) {
  data = data %>%
    dplyr::select(dplyr::all_of(!!x_val), dplyr::all_of(!!y_val)) %>%
    dplyr::group_by(get(x_val), get(y_val)) %>%
    dplyr::count() %>%
    dplyr::group_by(`get(x_val)`) %>%
    dplyr::mutate(x = signif(n / sum(n) * 100, digits = 3)) %>%
    purrr::set_names(c(x_val, y_val, 'number', 'percent'))

  fishers_df = data %>%
    tidyr::pivot_wider(values_from = number, names_from = y_val,
                       id_cols = x_val, values_fill = 0) %>%
    tibble::column_to_rownames(x_val)

  # Default to au_colors if the user doesn't specify a color vector
  # Otherwise, use the custom colors
  if (is.na(colors[1])) {
    colors = au_colors()
  } else {
    style = "custom"
  }

  if (is.na(order[1])) {
    order = c(unique(dplyr::pull(data, get(x_val))))
  }

  stat_title = paste0("Fisher's exact test p = ", signif(stats::fisher.test(fishers_df)$p, digits = 3))

  if (display_n) {
    title = paste0(title, ", n = ", sum(data$number))
  }

  if (pct) {
    p = ggpubr::ggbarplot(data, x_val, "percent", lab.pos = "in", fill = y_val,
                          label = TRUE, order = order, lab.col = labcol)
  } else {
    p = ggpubr::ggbarplot(data, x_val, "number", lab.pos = "in", fill = y_val,
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
