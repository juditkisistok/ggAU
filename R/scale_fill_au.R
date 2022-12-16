#' AU fill scale
#'
#' Enables the customization of the fill aesthetic using pre-defined or custom
#' AU color palettes.
#'
#' @param style String, color palette style. Could be `light`, `dark`,
#' `hotandcold`, `hotandcold_dark`, or `custom`. Default palette is `light`.
#' @param reverse Boolean, `TRUE` reverses the color order.
#' @param discrete Boolean, `TRUE` applies a discrete color scale, `FALSE` applies a
#' continuous color scale. Default is `FALSE`.
#' @param colors Vector of AU color names. Only used when `style = "custom"` is passed in.
#' @param ... Arguments passed on to `scale_fill_manual` or `scale_fill_gradientn`.
#' @param na.value String or named vector, the color to use for NA values.
#' Default is `au_colors("grey")`, corresponding to `#878787`.
#'
#' @return A ggproto ScaleContinuous or ScaleDiscrete object.
#' @export
#'
#' @examples
#' iris_df = dplyr::summarize(dplyr::group_by(iris, Species),
#' `Mean petal width` = mean(Petal.Width))
#'
#' ggplot2::ggplot(iris_df, ggplot2::aes(x = Species,
#' y = `Mean petal width`, fill = Species)) +
#' ggplot2::geom_bar(stat = "identity") +
#' ggpubr::theme_pubr() +
#' scale_fill_au(discrete = TRUE, style = "light")
#'
scale_fill_au <- function(style = "light", reverse = FALSE, discrete = FALSE,
                          colors = NA, na.value = au_colors("grey"), ...) {
  if (style == "custom") {
    palette = au_color_palette(style = "custom", reverse = reverse, colors = colors)
  } else {
    palette = au_color_palette(style = style, reverse = reverse)
  }

  if (discrete) {
    ggplot2::scale_fill_manual(values = unname(palette), na.value = unname(na.value), ...)
  } else {
    ggplot2::scale_fill_gradientn(colours = palette, ...)
  }
}

