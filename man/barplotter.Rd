% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/barplotter.R
\name{barplotter}
\alias{barplotter}
\title{Create barplots}
\usage{
barplotter(
  data,
  x_val,
  y_val,
  order = NA,
  scale_labs = ggplot2::waiver(),
  pct = T,
  style = "light",
  colors = NA,
  y_lab = ggplot2::waiver(),
  x_lab = ggplot2::waiver(),
  title = "",
  labcol = "black",
  display_n = T,
  legend_lab = NA,
  labels = NA,
  filter_col = NA,
  filter_val = NA
)
}
\arguments{
\item{data}{The \code{data.frame} to be used for the visualization.}

\item{x_val}{string, the name of the column to plot on the x axis.}

\item{y_val}{string, the name of the column to plot on the y axis.}

\item{order}{vector, the order in which the bars should appear. It should include all unique values in \code{x_val} in the desired order.
If unspecified, the bars follow the order of the dataframe.}

\item{scale_labs}{vector, names to display on the x axis ticks. By default, it shows the names as they appear in \code{x_val}.}

\item{pct}{boolean, if \code{TRUE}, percentages are displayed on the bars, if \code{FALSE}, the absolute numbers are shown.}

\item{style}{string, palette style to be used for \code{scale_fill_au}. Default is \code{light}. Style is only applied if \code{colors} remains \code{NA}.}

\item{colors}{vector containing the colors to be used for the \code{fill} aesthetic. Default is \code{NA}. If unspecified, the function uses \code{au_colors()}.}

\item{y_lab}{string, the y axis label. Default is \code{percent}. If \code{pct = FALSE}, the default is \code{number}.}

\item{x_lab}{string, the x axis label. Default is the string passed into \code{x_val}.}

\item{title}{string, the title of the plot to be displayed on top. Deafult is \code{""}.}

\item{labcol}{string, the color of the annotation numbers displayed inside the bars. The default is \code{black}.}

\item{display_n}{boolean, if \code{TRUE}, the plot displays the sample size appended to the title. Default is \code{TRUE}.}

\item{legend_lab}{string, the legend title. Default is the string passed into \code{y_val}.}

\item{labels}{vector, the legend annotations. Default is the unique values in \code{y_val}.}

\item{filter_col}{string, the name of the column to filter \code{data} by. Default is \code{NA}.}

\item{filter_val}{string or list, the entries to keep in \code{filter_col}. Default is \code{NA}.}
}
\value{
A ggplot object.
}
\description{
Enables the creation of barplots in a convenient and customizable manner,
and calculates the associated Fisher's test p-value on the count data.
}
\examples{
iris = dplyr::mutate(iris, Petal_mean = ifelse(Petal.Length > mean(Petal.Length),
"above_mean", "below_mean"))

barplotter(data = iris, x_val = "Species", y_val = "Petal_mean", labcol = "white")
}
