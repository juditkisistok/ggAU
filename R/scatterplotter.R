#' Create scatterplots
#'
#' @param data
#' @param x_val
#' @param y_val
#' @param col_val
#' @param style
#' @param colors
#' @param y_lab
#' @param x_lab
#' @param title
#' @param fit
#' @param discrete
#' @param linecolor
#' @param pointcolor
#' @param corr_method
#' @param alternative
#' @param fit_method
#' @param se
#' @param labels
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
scatterplotter = function(data, x_val, y_val, col_val = NA, style = "light",
                          colors = au_colors(), y_lab = "y",
                          x_lab = "x", title = "", fit = "none",
                          discrete = TRUE, linecolor = "black", pointcolor = "black",
                          corr_method = "pearson", alternative = "two.sided",
                          fit_method = "glm", se = FALSE, labels = NA, ...) {

  if (fit == "single") {

    if (is.na(col_val)) {
      p = ggplot2::ggplot(data, ggplot2::aes(x = get(x_val), y = get(y_val))) +
        ggplot2::geom_point(color = pointcolor)

    } else {
      p = ggplot2::ggplot(data, ggplot2::aes(x = get(x_val), y = get(y_val))) +
        ggplot2::geom_point(ggplot2::aes(color = get(col_val)), ...)
    }

    p = p +
      ggplot2::geom_smooth(method = fit_method, color = linecolor, se = se)

  } else if (fit == "grouped") {
    p = ggplot2::ggplot(data, ggplot2::aes(x = get(x_val), y = get(y_val),
                                           color = get(col_val))) +
      ggplot2::geom_point(...) +
      ggplot2::geom_smooth(method = fit_method, se = se)

  } else {

    if (is.na(col_val)) {

      p = ggplot2::ggplot(data, ggplot2::aes(x = get(x_val), y = get(y_val))) +
        ggplot2::geom_point(color = pointcolor, ...)

      } else {
        p = ggplot2::ggplot(data, ggplot2::aes(x = get(x_val), y = get(y_val),
                                               color = get(col_val))) +
          ggplot2::geom_point(...)
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
                   plot.subtitle = ggplot2::element_text(hjust = 0.5))

  return (p)
}

