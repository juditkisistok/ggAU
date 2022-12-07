#' Aarhus University brand colors
#'
#' Helper function to retrieve an arbitrary number of AU brand colors by name.
#' Returns a named vector containing the color name(s) as passed into the function,
#' and the corresponding AU hex code(s).
#'
#' Implementation is based on the [official brand guidelines](https://medarbejdere.au.dk/en/administration/communication/guidelines/guidelinesforcolours).
#'
#' @param ... Name(s) of color(s) to be used. Valid color names: `blue`, `darkblue`,
#' `purple`, `darkpurple`, `cyan`, `darkcyan`, `turkis`, `darkturkis`, `green`,
#' `darkgreen`, `yellow`, `darkyellow`, `orange`, `darkorange`, `red`, `darkred`,
#' `magenta`, `darkmagenta`, `grey`, `darkgrey`, `white`.
#'
#' @return A named vector with the chosen colors and their corresponding hex codes.
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
    "darkgrey" = "#4b4b4a",
    "white" = "#ffffff"
  )

  colors = c(...)

  if(is.null(colors)) {
    return (au_colors)
  }

  return (au_colors[colors])
}
