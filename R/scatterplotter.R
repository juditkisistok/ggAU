scatterplotter = function(data, x_val, y_val, col_val, style = "light",
                          colors = au_colors(), y_lab = "y",
                          x_lab = "x", title = "", fit = "none",
                          discrete = TRUE, linecolor = "black",
                          corr_method = "pearson", alternative = "two.sided",
                          fit_method = "glm", se = FALSE, ...) {

  if (fit == "single") {
    p = ggplot2::ggplot(data, ggplot2::aes(x = get(x_val), y = get(y_val))) +
      ggplot2::geom_point(ggplot2::aes(color = get(col_val))) +
      ggplot2::geom_smooth(method = fit_method, color = linecolor, se = se)
  } else if (fit == "grouped") {
    p = ggplot2::ggplot(data, ggplot2::aes(x = get(x_val), y = get(y_val),
                                           color = get(col_val))) +
      ggplot2::geom_point() +
      ggplot2::geom_smooth(method = fit_method, se = se)
  } else {
    p = ggplot2::ggplot(data, ggplot2::aes(x = get(x_val), y = get(y_val),
                                           color = get(col_val))) +
      ggplot2::geom_point()
  }

  p = p +
    ggpubr::theme_pubr() +
    scale_color_au(discrete = discrete, style = style)

  if (corr_method != "none")  {
    p = p +
      ggpubr::stat_cor(method = corr_method, alternative = alternative, ...)
  }

  return (p)
}

