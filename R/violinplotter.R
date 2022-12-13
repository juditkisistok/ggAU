#' Title
#'
#' @return
#' @export
#'
#' @examples
violinplotter = function(data, x_val, y_val, x_lab = "x", y_lab = "y", title = "",
                         filter = F, filter_col = NA, filter_val = NA,
                         comp_vec = NA, col_vec = au_colors(),
                         fill_vec = au_colors(), col_style = "light",
                         fill_style = "light") {
  if (filter == T) {
    data = dplyr::filter(data, get(filter_col) == filter_val)
  }

  # counts the number of data points for annotation purposes
  stat = data %>%
    dplyr::select(x_val, y_val) %>%
    na.omit() %>%
    dplyr::count() %>%
    dplyr::mutate(lab = paste0('n = ', n))

  p = ggplot2::ggplot(data, ggplot2::aes_string(x = x_val, y = y_val)) +
    ggforce::geom_sina(ggplot2::aes_string(color = x_val))+
    ggplot2::geom_violin(ggplot2::aes_string(fill = x_val), alpha = 0.5) +
    ggplot2::geom_boxplot(width = 0.1, outlier.shape = NA) +
    ggpubr::theme_pubr() +
    ggplot2::xlab(x_lab) +
    ggplot2::ylab(y_lab) +
    ggplot2::theme(legend.position = 'none',
          plot.title = ggplot2::element_text(hjust = 0.5)) +
    ggpubr::stat_compare_means(comparisons = comp_vec) +
    scale_color_au(colors = col_vec, style = col_style, discrete = T) +
    scale_fill_au(colors = fill_vec, style = fill_style, discrete = T) +
    ggplot2::ggtitle(paste0(title, ', ', stat$lab))

  return (p)

}

