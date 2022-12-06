#' Title
#'
#' @return
#' @export
#'
#' @examples
au_color_palette = function(style = "light", reverse = FALSE, colors = NA, ...) {
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
