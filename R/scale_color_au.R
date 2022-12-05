#' Title
#'
#' @return
#' @export
#'
#' @examples
scale_color_au = function(style = "lightblue", discrete = F, reverse = FALSE,
                          colors = NA, ...) {
  if (style == "custom") {
    palette = au_color_palette(style = style, reverse = reverse, colors = colors, ...)
  } else {
    palette = au_color_palette(style = style, reverse = reverse, ...)
  }

  if (discrete) {
    discrete_scale("colour", paste0("au_", style), palette = palette, ...)
  } else {
    scale_color_gradientn(colours = palette(256), ...)
  }
}
