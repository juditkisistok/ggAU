#' Title
#'
#' @return
#' @export
#'
#' @examples
scale_color_au = function(style = "light", reverse = FALSE, discrete = FALSE,
                          colors = NA, na.value = au_colors("grey"), ...) {
  if (style == "custom") {
    palette = au_color_palette(style = style, reverse = reverse, colors = colors)
  } else {
    palette = au_color_palette(style = style, reverse = reverse)
  }

  if (discrete) {
    ggplot2::scale_color_manual(values = unname(palette), na.value = unname(na.value), ...)
  } else {
    ggplot2::scale_color_gradientn(colours = palette, ...)
  }
}
