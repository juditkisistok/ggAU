#' Title
#'
#' @return
#' @export
#'
#' @examples
au_color_palette = function(style = "dark", reverse = FALSE, ...) {
  palettes = list(
    dark = au_colors("darkblue", "darkpurple", "darkcyan", "darkturkis",
                     "darkgreen", "darkyellow", "darkorange", "darkred",
                     "darkmagenta", "darkgrey"),
    light = au_colors("blue", "purple", "cyan", "turkis", "green",
                      "yellow", "orange", "red", "magenta", "grey"),
    hotandcold = au_colors("blue", "white", "red"),
    hotandcold_dark = au_colors("darkblue", "darkwhite", "darkred")
    )

  palette = palettes[[style]]

  if (reverse) {
    palette = rev(palette)
  }

  colorRampPalette(palette, ...)
}

