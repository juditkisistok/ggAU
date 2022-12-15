#' Title
#'
#' @return
#' @export
#'
#' @examples
barplotter = function(data, x_val, y_val, order = NA, scale_labs = NA,
                      pct = T, style = "light", colors = NA, y_lab = "y",
                      x_lab = "x", title = "", labcol = "black") {
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

  stat_title = paste0("Fisher's exact test p = ", signif(fisher.test(fishers_df)$p, digits = 3))

  if (pct) {
    p = ggpubr::ggbarplot(data, "x", "percent", lab.pos = "in", fill = "y",
                          label = TRUE, order = order, lab.col = labcol)
  } else {
    p = ggpubr::ggbarplot(data, "x", "number", lab.pos = "in", fill = "y",
                          label = TRUE, order = order, lab.col = labcol)
  }

  p = p +
    scale_fill_au(discrete = T, style = style, colors = colors) +
    ggplot2::ylab(y_lab) +
    ggplot2::xlab(x_lab) +
    ggplot2::ggtitle(label = title, subtitle = stat_title) +
    ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5),
          plot.subtitle = ggplot2::element_text(hjust = 0.5)) +
    ggplot2::scale_x_discrete(labels = scale_labs)

  return (p)
}
