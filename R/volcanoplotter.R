volcanoplotter = function(data, x_val, y_val, nonsig_col = "grey", pointsize = 1,
                          point_alpha = 1, y_lab = "P-value", x_lab = "logFC", title = "",
                          sig_neg_col = au_colors("blue"), sig_pos_col = au_colors("red"),
                          pval_cutoff = 0.05) {
  volcano_plot = ggplot2::ggplot(data) +
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
    ggplot2::scale_y_continuous(trans = ggforce::trans_reverser('log10'))

  return(volcano_plot)
}
