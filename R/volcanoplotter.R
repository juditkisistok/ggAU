#' Volcanoplotter
#'
#' Enables convenient visualization of differential expression data.
#'
#' @param data The `data.frame` to be used for the visualization.
#' @param x_val string, the name of the column to plot on the x axis.
#' @param y_val string, the name of the column to plot on the y axis.
#' @param nonsig_col string, the color to use for the nonsignificant points. Default is `"grey"`.
#' @param pointsize num, point size passed into `geom_point()`. Default is `1`.
#' @param point_alpha num, point opacity passed into `geom_point()`. Default is `1`.
#' @param y_lab string, the y axis label. Default is `"P-value"`.
#' @param x_lab string, the x axis label. Default is `"logFC"`.
#' @param title string, the title of the plot to be displayed on top. Default is `""`.
#' @param sig_neg_col string, color to use for the significant negative points. Default is `au_colors("blue")`.
#' @param sig_pos_col string, color to use for the significant positive points. Default is `au_colors("red")`.
#' @param pval_cutoff num, significance cutoff. Default is `0.05`.
#' @param add_labels boolean, if `TRUE`, the number of points determined by `num_lab` are labelled.
#' Default is `FALSE`.
#' @param num_lab num, the number of points to label on the plot. Default is `10`.
#' @param label_col string, name of the column to use for labelling. Default is `NA`.
#' @param lab_size num, size of the labels. Default is `3`.
#' @param dirs string, direction of position adjustment passed into `geom_label_repel()`.
#' Possible values are `x`, `y` and `both`. Default is `x`.
#' @param nudge_x1 num, horizontal adjustment of the positive significant labels. Default is `10`.
#' @param nudge_x2 num, horizontal adjustment of the negative significant labels. Default is `-10`.
#' @param nudge_y1 num, vertical adjustment of the positive significant labels. Default is `0`.
#' @param nudge_y2 num, vertical adjustment of the negative significant labels. Default is `0`.
#' @param lab_bordersize num, width of the label border. Default is `NA`.
#' @param fillcol string, background color for the labels. Default is transparent.
#' @param brk vector, list of y-axis breaks.
#' @param lim vector, y-axis limits.
#' @param ... other parameters passed into `geom_label_repel()`.
#'
#' @return A ggplot object.
#' @export
#'
#' @examples
#'
#' volcanoplotter(volcanodata, x_val = "logFC", y_val = "adj.P.Val", add_labels = T,
#' label_col = "SYMBOL", num_lab = 5)
#'
volcanoplotter = function(data, x_val, y_val, nonsig_col = "grey", pointsize = 1,
                          point_alpha = 1, y_lab = "P-value", x_lab = "logFC", title = "",
                          sig_neg_col = au_colors("blue"), sig_pos_col = au_colors("red"),
                          pval_cutoff = 0.05, add_labels = F, num_lab = 10,
                          label_col = NA, lab_size = 3, dirs = "y", nudge_x1 = 10,
                          nudge_x2 = -10, nudge_y1 = 0, nudge_y2 = 0, lab_bordersize = NA,
                          fillcol =  scales::alpha(c("white"), 0), brk = ggplot2::waiver(),
                          lim = NULL, ...) {

  p = ggplot2::ggplot(data) +
      # draw the base including all points
      ggplot2::geom_point(ggplot2::aes(x = get(x_val), y = get(y_val)), color = nonsig_col,
                        size = pointsize, alpha = point_alpha) +
      ggplot2::xlab(x_lab) +
      ggplot2::ylab(y_lab) +
      ggplot2::ggtitle(title) +
      ggpubr::theme_pubr() +
      # overlay overexpressed genes / pathways
      ggplot2::geom_point(data = dplyr::filter(data, get(x_val) > 0 & get(y_val) < pval_cutoff),
               ggplot2::aes(x = get(x_val), y = get(y_val)), color = sig_pos_col,
               size = pointsize, alpha = point_alpha) +
      # overlay underexpressed genes / pathways
      ggplot2::geom_point(data = dplyr::filter(data, get(x_val) < 0 & get(y_val) < pval_cutoff),
                        ggplot2::aes(x = get(x_val), y = get(y_val)), color = sig_neg_col,
                        size = pointsize, alpha = point_alpha) +
      ggplot2::scale_y_continuous(trans = ggforce::trans_reverser('log10'),
                                  breaks = brk, limits = lim) +
      ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))

  if (add_labels) {
    label_data_pos = dplyr::filter(data, get(x_val) > 0 & get(y_val) < pval_cutoff) %>%
      dplyr::arrange(get(y_val), get(x_val)) %>%
      utils::head(num_lab)

    label_data_all = dplyr::filter(data, get(x_val) < 0 & get(y_val) < pval_cutoff) %>%
      dplyr::arrange(get(y_val), get(x_val)) %>%
      utils::head(num_lab) %>%
      rbind(label_data_pos)

    p = p +
      ggrepel::geom_label_repel(data = dplyr::filter(label_data_all, get(x_val) > 0),
                       ggplot2::aes(x = get(x_val), y = get(y_val), label = get(label_col)),
                       size = lab_size, nudge_x = nudge_x1, nudge_y = nudge_y1,
                       direction = dirs, label.size = lab_bordersize, fill = fillcol, ...) +
      ggrepel::geom_label_repel(data = dplyr::filter(label_data_all, get(x_val) < 0),
                       ggplot2::aes(x = get(x_val), y = get(y_val), label = get(label_col)),
                       size = lab_size, nudge_x = nudge_x2, nudge_y = nudge_y2,
                       direction = dirs, label.size = lab_bordersize, fill = fillcol, ...)
  }
  return (p)
}
