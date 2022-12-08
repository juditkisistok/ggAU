#' Color palette generator
#'
#' @param style String, name of a pre-defined color palette (`light`, `dark`,
#' `hotandcold`, `hotandcold_dark`), or `custom`. The default palette is `light`.
#' @param reverse Boolean, TRUE will reverse the color order.
#' @param colors Vector of AU color names. Only used when `style = "custom"` is passed in.
#'
#' @return A named vector with a pre-defined or custom color palette.
#' @export
#'
#' @examples
#' au_color_palette("hotandcold")
#'
#' au_color_palette("custom", colors = c("yellow", "magenta", "white"))
au_color_palette = function(style = "light", reverse = FALSE, colors = NA) {
  palettes = list(
    dark = au_colors("darkblue", "darkpurple", "darkcyan",
                     "darkturkis", "darkgreen", "darkorange",
                     "darkred", "darkmagenta"),

    light = au_colors("blue", "purple", "cyan", "turkis", "green",
                      "yellow", "red", "magenta"),

    # continuous heatmap palettes
    hotandcold = au_colors("blue", "white", "red"),
    hotandcold_dark = au_colors("darkblue", "white", "darkred"),

    # palette for testing
    test = au_colors("blue", "yellow", "red")
    )

  palette = palettes[[style]]

  # reverse colors
  if (reverse) {
    palette = rev(palette)
  }
  # custom color palette
  if (style == "custom") {
    au_colors(colors)
  } else {
    palette
  }
}
