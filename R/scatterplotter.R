#' Create scatterplots
#'
#' Enables the creation of scatterplots in a convenient and customizable manner.
#' Additionally, it allows the user to calculate a correlation metric of interest,
#' and fit a linear or loess line to the data.
#'
#' @param data The `data.frame` to be used for the visualization.
#' @param x_val string, the name of the column to plot on the x axis.
#' @param y_val string, the name of the column to plot on the y axis.
#' @param col_val string, name of the column to use for coloring points. Default is `NA`.
#' @param style string, palette style to be used for `scale_color_au`. Default is `"light"`.
#' @param colors vector containing the colors to be used for the `fill` aesthetic. Default is `au_colors()`.
#' Custom colors are only applied when `style = "custom"`.
#' @param y_lab string, the y axis label. Default is `"y"`.
#' @param x_lab string, the x axis label. Default is `"x"`.
#' @param title string, the title of the plot to be displayed on top. Default is `""`.
#' @param discrete boolean, `TRUE` applies a discrete color scale, `FALSE` applies a
#' continuous color scale. Default is `TRUE`.
#' @param pointcolor sting, the color to use for points when `col_val = NA`.Default is `"black"`.
#' @param pointsize num, point size passed into `geom_point()`. Default is `1`.
#' @param point_alpha num, point opacity passed into `geom_point()`. Default is `1`.
#' @param corr_method string, the correlation method to pass into `stat_cor()`. Default is `"pearson"`.
#' @param alternative string, the alternative to pass into `stat_cor()`. Default is `"two.sided"`.
#' @param fit string, `"single"`, `"grouped"`, or `"none"`. When using `"single"`, the model is fit to the entire dataset
#' displayed on the plot. When `"grouped"` is used, a separate line is fit to the groups defined by `col_val`.
#' When `none` is selected, no line is being fit. Default is `"none"`.
#' @param fit_method string, the fitting method passed into `geom_smooth()`. Default is `"glm"`.
#' @param se boolean, when `TRUE`, the confidence interval around the fitted line is displayed. Default is `FALSE`.
#' @param linecolor string, the color of the fitted line in `single` mode. Default is `"black"`.
#' @param formula string, the formula to use for fitting the line with `geom_smooth()`. Default is `"y ~ x"`.
#' @param labels vector, the legend annotations. Default is the unique values in `y_val`.
#' @param legend_lab string, the legend title. Default is `"color"`.
#' @param ... other parameters passed into `stat_cor()`.
#'
#' @return A ggplot object.
#' @export
#'
#' @examples
#' scatterplotter(iris, "Sepal.Width", "Sepal.Length",col_val = "Species", style = "tracerx",
#' y_lab = "Sepal Length", x_lab = "Sepal Width",  title = "Comparing sepal widths and lengths per species",
#' fit = "single", corr_method = "pearson", legend_lab = "Species", se = FALSE,
#' labels = c("Species 1", "Species 2", "Species 3"))
#'
scatterplotter = function(data, x_val, y_val, col_val = NA, style = "light",
                          colors = au_colors(), y_lab = "y",
                          x_lab = "x", title = "", legend_lab = "", fit = "none",
                          discrete = TRUE, linecolor = "black", pointcolor = "black",
                          corr_method = "pearson", alternative = "two.sided",
                          fit_method = "glm", se = FALSE, labels = NA,
                          formula = "y ~ x", pointsize = 1, point_alpha = 1, ...) {

  if (fit == "single") {

    if (is.na(col_val)) {
      p = ggplot2::ggplot(data, ggplot2::aes(x = get(x_val), y = get(y_val))) +
        ggplot2::geom_point(color = au_colors(pointcolor),
                            size = pointsize, alpha = point_alpha)

    } else {
      p = ggplot2::ggplot(data, ggplot2::aes(x = get(x_val), y = get(y_val))) +
        ggplot2::geom_point(ggplot2::aes(color = get(col_val)),
                            size = pointsize, alpha = point_alpha)
    }

    p = p +
      ggplot2::geom_smooth(method = fit_method, color = au_colors(linecolor),
                           se = se, formula = formula(formula))

  } else if (fit == "grouped") {
    p = ggplot2::ggplot(data, ggplot2::aes(x = get(x_val), y = get(y_val),
                                           color = get(col_val))) +
      ggplot2::geom_point(size = pointsize, alpha = point_alpha) +
      ggplot2::geom_smooth(method = fit_method, se = se, formula = formula(formula))

  } else {

    if (is.na(col_val)) {

      p = ggplot2::ggplot(data, ggplot2::aes(x = get(x_val), y = get(y_val))) +
        ggplot2::geom_point(color = au_colors(pointcolor),
                            size = pointsize, alpha = point_alpha)

      } else {
        p = ggplot2::ggplot(data, ggplot2::aes(x = get(x_val), y = get(y_val),
                                               color = get(col_val))) +
          ggplot2::geom_point(size = pointsize, alpha = point_alpha)
      }

  }

  if (!is.na(labels[1])) {
    p = p +
      scale_color_au(discrete = TRUE, style = style, colors = colors, labels = labels)
  } else {
    p = p +
      scale_color_au(discrete = TRUE, style = style, colors = colors)
  }

  if (corr_method != "none")  {
    p = p +
      ggpubr::stat_cor(method = corr_method, alternative = alternative, ...)
  }

  p = p +
    ggpubr::theme_pubr() +
    ggplot2::ylab(y_lab) +
    ggplot2::xlab(x_lab) +
    ggplot2::ggtitle(label = title) +
    ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5),
                   plot.subtitle = ggplot2::element_text(hjust = 0.5)) +
    ggplot2::labs(colour = legend_lab)

  return (p)
}

