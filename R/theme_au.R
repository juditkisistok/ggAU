#' Title
#'
#' @param legend
#'
#' @return
#' @export
#'
#' @examples
theme_au = function(legend = T) {
  theme = ggpubr::theme_pubr()

  if (legend == F) {
    theme = theme +
      ggplot2::theme(legend.position = "none")
  }
}
