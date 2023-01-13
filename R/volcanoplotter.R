#' Volcanoplotter
#'
#' @param data
#' @param x_val
#' @param y_val
#' @param nonsig_col
#' @param pointsize
#' @param point_alpha
#' @param y_lab
#' @param x_lab
#' @param title
#' @param sig_neg_col
#' @param sig_pos_col
#' @param pval_cutoff
#' @param add_labels
#' @param num_lab_genes
#' @param label_col
#' @param lab_size
#' @param dirs
#' @param nudge_x1
#' @param nudge_x2
#' @param nudge_y1
#' @param nudge_y2
#' @param labsize
#' @param fillcol
#' @param brk
#' @param lim
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
volcanoplotter = function(data, x_val, y_val, nonsig_col = "grey", pointsize = 1,
                          point_alpha = 1, y_lab = "P-value", x_lab = "logFC", title = "",
                          sig_neg_col = au_colors("blue"), sig_pos_col = au_colors("red"),
                          pval_cutoff = 0.05, add_labels = F, num_lab_genes = 15,
                          label_col = NA, lab_size = 3, dirs = "y", nudge_x1 = 10,
                          nudge_x2 = -10, nudge_y1 = 0, nudge_y2 = 0, labsize = NA,
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
      utils::head(num_lab_genes)

    label_data_all = dplyr::filter(data, get(x_val) < 0 & get(y_val) < pval_cutoff) %>%
      dplyr::arrange(get(y_val), get(x_val)) %>%
      utils::head(num_lab_genes) %>%
      rbind(label_data_pos)

    p = p +
      ggrepel::geom_label_repel(data = dplyr::filter(label_data_all, get(x_val) > 0),
                       ggplot2::aes(x = get(x_val), y = get(y_val), label = get(label_col)),
                       size = lab_size, nudge_x = nudge_x1, nudge_y = nudge_y1,
                       direction = dirs, label.size = labsize, fill = fillcol, ...) +
      ggrepel::geom_label_repel(data = dplyr::filter(label_data_all, get(x_val) < 0),
                       ggplot2::aes(x = get(x_val), y = get(y_val), label = get(label_col)),
                       size = lab_size, nudge_x = nudge_x2, nudge_y = nudge_y2,
                       direction = dirs, label.size = labsize, fill = fillcol, ...)
  }
  return (p)
}
