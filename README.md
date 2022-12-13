
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ggAU - ggplot2 themes for Aarhus University

<!-- badges: start -->
<!-- badges: end -->

The goal of ggAU is to simplify the process of creating
publication-ready visualizations that follow the [Aarhus University
color
scheme](https://medarbejdere.au.dk/en/administration/communication/guidelines/guidelinesforcolours).

## Installation

You can install the development version of ggAU from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("juditkisistok/ggAU")
```

## Available color palettes

``` r
library(ggAU)
unikn::seecol(au_color_palette(style = "light"), main = "Light", 
              grid = F, rgb = F)
```

<img src="man/figures/README-palettes-1.png" width="100%" />

``` r
unikn::seecol(au_color_palette(style = "dark"), main = "Dark", 
              grid = F, rgb = F)
```

<img src="man/figures/README-palettes-2.png" width="100%" />

``` r
unikn::seecol(au_color_palette(style = "hotandcold"), main = "Hot and cold", 
              grid = F, rgb = F)
```

<img src="man/figures/README-palettes-3.png" width="100%" />

``` r
unikn::seecol(au_color_palette(style = "hotandcold_dark"), main = "Hot and cold (dark)", 
              grid = F, rgb = F)
```

<img src="man/figures/README-palettes-4.png" width="100%" />

# Examples

The `scale_fill_au` and `scale_color_au` functions allow you to apply
the pre-defined color palettes.

The default color scheme is `light` and the default variable type is
continuous. You can add `discrete = T` for categorical variable color
schemes.

``` r
iris_df = dplyr::summarize(dplyr::group_by(iris, Species), 
                           `Mean petal width` = mean(Petal.Width))

light_plot_fill = ggplot2::ggplot(iris_df, ggplot2::aes(x = Species, 
                                      y = `Mean petal width`, fill = Species)) +
  ggplot2::geom_bar(stat = "identity") +
  ggpubr::theme_pubr() +
  scale_fill_au(discrete = T)

dark_plot_fill = ggplot2::ggplot(iris_df, ggplot2::aes(x = Species, 
                                     y = `Mean petal width`, fill = Species)) +
  ggplot2::geom_bar(stat = "identity") +
  ggpubr::theme_pubr() +
  scale_fill_au(discrete = T, style = "dark")

cowplot::plot_grid(light_plot_fill, dark_plot_fill)
```

<img src="man/figures/README-scale_fill_au-examples-1.png" width="100%" />

It is also possible to define your own mix of colors - you can retrieve
a vector of AU hex codes by color name.

``` r
my_custom_style = c("blue", "yellow", "red")

ggplot2::ggplot(iris_df, ggplot2::aes(x = Species, 
                                      y = `Mean petal width`, fill = Species)) +
  ggplot2::geom_bar(stat = "identity") +
  ggpubr::theme_pubr() +
  scale_fill_au(discrete = T, style = "custom", colors = my_custom_style)
```

<img src="man/figures/README-scale_fill_au-custom-1.png" width="100%" />

The continuous fill scale works in a similar way, both with the built-in
and custom color schemes.

``` r
dummy_data = expand.grid(x = paste0("var_", seq(1, 10)),
                          y = paste0("var_", seq(11, 20)))
dummy_data$z = runif(100, -1, 1)

cont_fill_1 = ggplot2::ggplot(dummy_data, ggplot2::aes(x, y, fill = z)) +
  ggplot2::geom_tile() +
  ggpubr::theme_pubr() +
  scale_fill_au(style = "hotandcold")

cont_fill_2 = ggplot2::ggplot(dummy_data, ggplot2::aes(x, y, fill= z)) +
  ggplot2::geom_tile() +
  ggpubr::theme_pubr() +
  scale_fill_au(style = "custom", colors = c("yellow", "white", "darkblue"))

cowplot::plot_grid(cont_fill_1, cont_fill_2)
```

<img src="man/figures/README-scale_fill_au-continuous-1.png" width="100%" />

The color aesthetic can be changed in a similar way, using
`scale_color_au`.

``` r
discrete_cols = ggplot2::ggplot(iris, ggplot2::aes(x = Petal.Width, y = Petal.Length, color = Species)) +
  ggplot2::geom_point(size = 5, alpha = 0.3) +
  ggpubr::theme_pubr() +
  scale_color_au(discrete = T) +
  ggplot2::ggtitle("Built-in discrete color scale") +
  ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))

discrete_custom = ggplot2::ggplot(iris, ggplot2::aes(x = Petal.Width, y = Petal.Length, color = Species)) +
  ggplot2::geom_point(size = 5, alpha = 0.3) +
  ggpubr::theme_pubr() +
  scale_color_au(discrete = T, style = "custom", colors = c("yellow", "magenta", "darkblue")) +
  ggplot2::ggtitle("Custom discrete color scale") +
  ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))

cont_cols = ggplot2::ggplot(iris, ggplot2::aes(x = Petal.Width, y = Petal.Length, color = Petal.Length)) +
  ggplot2::geom_point(size = 5, alpha = 0.3) +
  ggpubr::theme_pubr() +
  scale_color_au(discrete = F, style = "hotandcold") +
  ggplot2::ggtitle("Built-in continuous color scale") +
  ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))

cont_custom = ggplot2::ggplot(iris, ggplot2::aes(x = Petal.Width, y = Petal.Length, color = Petal.Length)) +
  ggplot2::geom_point(size = 5, alpha = 0.3) +
  ggpubr::theme_pubr() +
  scale_color_au(discrete = F, style = "custom", colors = c("darkblue", "yellow", "magenta")) +
  ggplot2::ggtitle("Custom continuous color scale") +
  ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))

cowplot::plot_grid(discrete_cols, discrete_custom, cont_cols, cont_custom)
```

<img src="man/figures/README-scale_color_au-examples-1.png" width="100%" />

# Built-in plots

Additionally to the color schemes, ggAU also includes commonly used
visualization types with pre-applied AU styles.

## Violinplotter

The function has many customization options, however, specifying `data`,
`x_val` and `y_val` is enough for getting a basic plot up and running.

``` r
minimal = violinplotter(data = iris, x_val =  "Species", y_val = "Petal.Width",
                        title = "Minimal example")

full_custom = violinplotter(data = iris, x_val =  "Species", y_val = "Petal.Width", 
                            x_lab = "Species", y_lab = "Petal width", 
                            title = "Petal width comparison across species",
                            filter = F, filter_col = NA, filter_val = NA,
                            comp_vec = list(c("setosa", "virginica"), c("setosa", "versicolor"), 
                                            c("virginica", "versicolor")),
                            col_style = "custom",  fill_style = "custom", 
                            col_vec = c("red", "blue", "green"), 
                            fill_vec = c("red", "blue", "green"))

cowplot::plot_grid(minimal, full_custom)
```

<img src="man/figures/README-violinplotter-example-1.png" width="100%" />
