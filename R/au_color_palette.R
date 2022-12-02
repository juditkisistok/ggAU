#' Title
#'
#' @return
#' @export
#'
#' @examples
au_colors = function(...) {
  au_colors = c(
    "blue" = "#003d73",
    "darkblue" = "#002546",
    "purple" = "#655a9f",
    "darkpurple" = "#281c41",
    "cyan" = "#37a0cb",
    "darkcyan" = "#003e5c",
    "turkis" = "#00aba4",
    "darkturkis" = "#004543",
    "green" = "#8bad3f",
    "darkgreen" = "#425821",
    "yellow" = "#fabb00",
    "darkyellow" = "#634b03",
    "orange" = "#ee7f00",
    "darkorange" = "#5f3408",
    "red" = "#e2001a",
    "darkred" = "#5b0c0c",
    "magenta" = "#e2007a",
    "darkmagenta" = "#5f0030",
    "grey" = "#878787",
    "darkgrey" = "#4b4b4a"
  )

  colors = c(...)

  if(is.null(colors)) {
    return (au_colors)
  }

  return (au_colors[colors])

}

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

scale_color_au = function(style = "dark", discrete = TRUE, reverse = FALSE, ...) {
  palette = au_color_palette(style = style, reverse = reverse)

  if (discrete) {
    discrete_scale("colour", paste0("au_", style), palette = palette, ...)
  } else {
    scale_color_gradientn(colours = palette(256), ...)
  }
}
