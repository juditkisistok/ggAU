#' Title
#'
#' @return
#' @export
#'
#' @examples
scale_fill_au <- function(style = "lightblue", reverse = FALSE, discrete = F,
                          colors = NA, ...) {
  if (style == "custom") {
    palette = au_color_palette(style = style, reverse = reverse, colors = colors, ...)
  } else {
    palette = au_color_palette(style = style, reverse = reverse, ...)
  }

  if (discrete) {
    discrete_scale("fill", paste0("au_", style), palette = palette, ...)
  } else {
    scale_fill_gradientn(colours = palette(256), ...)
  }
}
