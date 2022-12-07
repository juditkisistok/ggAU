#' Title
#'
#' @return
#' @export
#'
#' @examples
scale_fill_au <- function(aesthetics = "fill", style = "light", reverse = FALSE, discrete = F,
                          colors = NA, ..., breaks = ggplot2::waiver(), na.value = au_colors("grey")) {
  if (style == "custom") {
    palette = au_color_palette(style = "custom", reverse = reverse, colors = colors, ...)
  } else {
    palette = au_color_palette(style = style, reverse = reverse, ...)
  }

  if (discrete) {
    ggplot2::scale_fill_manual(aesthetics, values = unname(palette),
                               breaks, na.value = na.value)
  } else {
    ggplot2::scale_fill_gradientn(colours = palette, ...)
  }
}

# Dummy data
dummy_data <- expand.grid(x = paste0("var_", seq(1, 10)),
                          y = paste0("var_", seq(11, 20)))
dummy_data$z <- runif(100, -1, 1)

# Heatmap
ggplot(dummy_data, aes(x, y, fill = z)) +
  geom_tile() +
  scale_fill_au(style = "hotandcold")

ggplot(dummy_data, aes(x, y, fill= z)) +
  geom_tile() +
  scale_fill_au(style = "custom", colors = c("yellow", "white", "darkblue"))

ggplot(iris, aes(x = Species, y = Species, fill = Sepal.Length)) +
  geom_tile()  +
  scale_fill_au(style = "hotandcold")


