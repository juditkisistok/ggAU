#' Title
#'
#' @return
#' @export
#'
#' @examples
violinplotter = function(data, x_val, y_val, x_lab = "x", y_lab = "y", title = "",
                         filter = F, filter_col = NA, filter_val = NA,
                         comp_vec = NA, col_vec = au_colors()) {
  if (filter == T) {
    data = dplyr::filter(data, get(filter_col) == filter_val)
  }

}

violinplotter(iris, "Species", "Petal.Width")
