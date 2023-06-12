#' Create violin-boxplots
#'
#' Enables the creation of violin-boxplots in a convenient and customizable manner.
#'
#' @param data The `data.frame` to be used for the visualization.
#' @param x_val string, the name of the column to plot on the x axis.
#' @param y_val string, the name of the column to plot on the y axis.
#' @param x_lab string, the x axis label. Default is the string passed into `x_val`.
#' @param y_lab string, the y axis label. Default is the string passed into `y_val`.
#' @param scale_labs vector, names to display on the x axis ticks. By default, it shows the names as they appear in `x_val`.
#' @param title string, the title of the plot to be displayed on top. Default is `""`.
#' @param filter boolean, if `TRUE`, it allows filtering of `data`. Default is `FALSE`.
#' @param filter_col string, the name of the column to filter if `filter = TRUE`. Default is `NA`.
#' @param filter_val vector, the values to keep if `filter = TRUE`.
#' @param comp_vec list of vectors containing the comparisons to be passed into `stat_compare_means`.
#' Default is `NA`, and in this case, no comparisons are made.
#' @param col_vec vector containing the colors to be used for the `color` aesthetic. Default is `NA`. If unspecified, the function uses `au_colors()`.
#' @param fill_vec vector containing the colors to be used for the `fill` aesthetic. Default is `NA`. If unspecified, the function uses `au_colors()`.
#' @param col_style string, palette style to be used for `scale_color_au`. Default is `light`. Style is only applied if `col_vec` remains `NA`.
#' @param fill_style string, palette style to be used for `scale_fill_au`. Default is `light`. Style is only applied if `fill_vec` remains `NA`.
#' @param violin_alpha num, opacity of the violin plot. Default is `0.5`.
#' @param display_n boolean, if `TRUE`, the plot displays the sample size appended to the title. Default is `TRUE`.
#' @param facet_val string, the name of the column to facet by. Default is `NA`.
#' @param ... other parameters passed into `stat_cor()` or `facet_wrap()`.
#' @return A ggplot object.
#' @export
#'
#' @examples
#' violinplotter(data = iris, x_val =  "Species", y_val = "Petal.Width",
#' display_n = FALSE)
#'
#' violinplotter(data = iris, x_val = "Species", y_val = "Petal.Width",
#' filter = TRUE, filter_col = "Species", filter_val = c("setosa", "virginica"),
#' comp_vec = list(c("setosa", "virginica")), title = "Comparing Setosa and Virginica")
violinplotter = function(data, x_val, y_val, x_lab = x_val, y_lab = y_val, title = "",
                         filter = F, filter_col = NA, filter_val = NA,
                         comp_vec = NA, col_vec = NA, scale_labs = ggplot2::waiver(),
                         fill_vec = NA, col_style = "light", fill_style = "light",
                         display_n = T, violin_alpha = 0.5, facet_val = NA, ...) {

  # Default to au_colors if the user doesn't specify a fill vector
  # Otherwise, use the custom colors
  if (is.na(fill_vec[1])) {
    fill_vec = au_colors()
  } else {
    fill_style = "custom"
  }

  if (is.na(col_vec[1])) {
    col_vec = au_colors()
  } else {
    col_style = "custom"
  }

  if (filter == T) {
    data = dplyr::filter(data, get(filter_col) %in% filter_val)
  }

  p = ggplot2::ggplot(data, ggplot2::aes(x = get(x_val), y = get(y_val))) +
    ggforce::geom_sina(ggplot2::aes(color = get(x_val)))+
    ggplot2::geom_violin(ggplot2::aes(fill = get(x_val)), alpha = violin_alpha) +
    ggplot2::geom_boxplot(width = 0.1, outlier.shape = NA) +
    ggpubr::theme_pubr() +
    ggplot2::xlab(x_lab) +
    ggplot2::ylab(y_lab) +
    ggplot2::theme(legend.position = 'none',
          plot.title = ggplot2::element_text(hjust = 0.5)) +
    scale_color_au(colors = col_vec, style = col_style, discrete = TRUE) +
    scale_fill_au(colors = fill_vec, style = fill_style, discrete = TRUE) +
    ggplot2::scale_x_discrete(labels = scale_labs)

  if (display_n) {
    # counts the number of data points for annotation purposes
    stat = data %>%
      dplyr::select(dplyr::all_of(x_val), dplyr::all_of(y_val)) %>%
      stats::na.omit() %>%
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

  if (!is.na(facet_val)) {
    p = p +
      ggplot2::facet_wrap(facet_val, ...)
  }

  return (p)
}
