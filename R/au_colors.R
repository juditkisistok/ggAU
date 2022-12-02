#' Aarhus University brand colors
#'
#' @param ... Name(s) of color(s) to be used.
#'
#' @return A named vector with the chosen colors.
#' @export
#'
#' @examples
#' au_colors("red", "blue")
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
