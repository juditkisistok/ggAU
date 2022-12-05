#' Title
#'
#' @return
#' @export
#'
#' @examples
au_color_palette = function(style = "darkblue", reverse = FALSE, colors = NA, ...) {
  palettes = list(
    # dark palettes
    darkblue = au_colors("darkblue", "darkturkis", "darkgreen", "darkorange",
                         "darkred", "darkmagenta"),
    darkpurple = au_colors("darkpurple", "darkturkis", "darkgreen", "darkorange",
                           "darkred", "darkmagenta"),
    darkcyan = au_colors("darkcyan", "darkturkis", "darkgreen", "darkorange",
                         "darkred", "darkmagenta"),

    # light palettes
    #lightblue = au_colors("blue", "turkis", "green", "yellow", "red", "magenta"),
    lightblue = au_colors("blue", "yellow", "magenta"),
    lightpurple = au_colors("purple", "turkis", "green", "yellow", "red", "magenta"),
    lightcyan = au_colors("cyan", "turkis", "green", "yellow", "red", "magenta"),

    # continuous heatmap palettes
    hotandcold = au_colors("blue", "white", "red"),
    hotandcold_dark = au_colors("darkblue", "darkwhite", "darkred")
    )

  palette = palettes[[style]]

  # reverse colors
  if (reverse) {
    palette = rev(palette)
  }
  # custom color palette
  if (style == "custom") {
    colorRampPalette(au_colors(colors))
  } else {
    colorRampPalette(palette)
  }
}
