#' Create violin-boxplots
#'
#' Enables the creation of violin-boxplots in a convenient and customizable manner.
#'
#' @param data The `data.frame` to be used for the visualization.
#' @param x_val string, the name of the column to plot on the x axis.
#' @param y_val string, the name of the column to plot on the y axis.
#' @param x_lab string, the title of the x axis.
#' @param y_lab string, the title of the y axis.
#' @param title string, the title of the plot to be displayed on top.
#' @param filter boolean, if `TRUE`, it allows filtering of `data`. Default is `FALSE`.
#' @param filter_col string, the name of the column to filter if `filter = TRUE`.
#' @param filter_val vector, the values to keep if `filter = TRUE`.
#' @param comp_vec list of vectors containing the comparisons to be passed into `stat_compare_means`.
#' Default is `NA`, and in this case, no comparisons are made.
#' @param col_vec vector containing the colors to be used for the `color` aesthetic. Default is `au_colors()`.
#' @param fill_vec vector containing the colors to be used for the `fill` aesthetic. Default is `au_colors()`.
#' @param col_style string, palette style to be used for `scale_color_au`. Default is `light`.
#' @param fill_style string, palette style to be used for `scale_fill_au`. Default is `light`.
#' @param display_n boolean, if `TRUE`, the plot displays the sample size appended to the title. Default is `TRUE`.
#'
#' @return A ggplot object.
#' @export
#'
#' @examples
#' violinplotter(data = iris, x_val =  "Species", y_val = "Petal.Width",
#' display_n = F)
#'
#' violinplotter(data = iris, x_val =  "Species", y_val = "Petal.Width",
#' filter = T, filter_col = "Species", filter_val = c("setosa", "virginica"),
#' comp_vec = list(c("setosa", "virginica")), title = "Comparing Setosa and Virginica")
violinplotter = function(data, x_val, y_val, x_lab = "x", y_lab = "y", title = "",
                         filter = F, filter_col = NA, filter_val = NA,
                         comp_vec = NA, col_vec = au_colors(),
                         fill_vec = au_colors(), col_style = "light",
                         fill_style = "light", display_n = T) {
  if (filter == T) {
    data = dplyr::filter(data, get(filter_col) %in% filter_val)
  }

  p = ggplot2::ggplot(data, ggplot2::aes_string(x = x_val, y = y_val)) +
    ggforce::geom_sina(ggplot2::aes_string(color = x_val))+
    ggplot2::geom_violin(ggplot2::aes_string(fill = x_val), alpha = 0.5) +
    ggplot2::geom_boxplot(width = 0.1, outlier.shape = NA) +
    ggpubr::theme_pubr() +
    ggplot2::xlab(x_lab) +
    ggplot2::ylab(y_lab) +
    ggplot2::theme(legend.position = 'none',
          plot.title = ggplot2::element_text(hjust = 0.5)) +
    scale_color_au(colors = col_vec, style = col_style, discrete = T) +
    scale_fill_au(colors = fill_vec, style = fill_style, discrete = T)

  if (display_n) {
    # counts the number of data points for annotation purposes
    stat = data %>%
      dplyr::select(x_val, y_val) %>%
      na.omit() %>%
      dplyr::count() %>%
      dplyr::mutate(lab = paste0('n = ', n))

    p = p +
      ggplot2::ggtitle(paste0(title, ', ', stat$lab))
  } else {
    p = p +
      ggplot2::ggtitle(title)
  }

  if (!is.na(comp_vec[1])) {
    p = p + ggpubr::stat_compare_means(comparisons = comp_vec)
  }

  return (p)
}

