#' AU color scale
#'
#' Enables the customization of the color aesthetic using pre-defined or custom
#' AU color palettes.
#'
#' @param style String, color palette style. Could be `light`, `dark`,
#' `hotandcold`, `hotandcold_dark`, or `custom`. Default palette is `light`.
#' @param reverse Boolean, `TRUE` reverses the color order.
#' @param discrete Boolean, `TRUE` applies a discrete color scale, `FALSE` applies a
#' continuous color scale. Default is `FALSE`.
#' @param colors Vector of AU color names. Only used when `style = "custom"` is passed in.
#' @param na.value String or named vector, the color to use for NA values.
#' Default is `au_colors("grey")`, corresponding to `#878787`.
#' @param ... Arguments passed on to `scale_color_manual` or `scale_color_gradientn`.
#'
#' @return A ggproto ScaleContinuous or ScaleDiscrete object.
#' @export
#'
#' @examples
#' ggplot2::ggplot(iris, ggplot2::aes(x = Petal.Width, y = Petal.Length, color = Species)) +
#' ggplot2::geom_point(size = 5, alpha = 0.3) +
#' ggpubr::theme_pubr() +
#' scale_color_au(discrete = T)
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
