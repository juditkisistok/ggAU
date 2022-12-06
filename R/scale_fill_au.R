#' Title
#'
#' @return
#' @export
#'
#' @examples
scale_fill_au <- function(aesthetics = "fill", style = "light", reverse = FALSE, discrete = F,
                          colors = NA, ..., breaks = waiver(), na.value = au_colors("grey")) {
  if (style == "custom") {
    palette = au_color_palette(style = "custom", reverse = reverse, colors = colors, ...)
  } else {
    palette = au_color_palette(style = style, reverse = reverse, ...)
  }

  if (discrete) {
    scale_fill_manual(aesthetics, values = unname(palette), breaks, na.value = na.value)
  } else {
    scale_fill_gradientn(colours = palette(256), ...)
  }
}

