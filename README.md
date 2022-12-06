
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

## Example

``` r
library(ggAU)
```

## Available color palettes

``` r
unikn::seecol(au_color_palette(style = "dark"), main = "Dark", 
              grid = F, rgb = F)
```

<img src="man/figures/README-palettes-1.png" width="100%" />

``` r
unikn::seecol(au_color_palette(style = "light"), main = "Light", 
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
