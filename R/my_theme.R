my_theme <- function (...) {
  my_theme <- theme(
    plot.title = element_text(face = "bold",
                              hjust = 0,
                              size = rel(1.5),
                              margin = margin(0, 0, 4, 0)),
    panel.background = element_rect(fill = "white", color = "black", linewidth = 0.9),
    legend.position = "bottom",
    legend.key = element_blank(),
    panel.grid = element_blank(),
    strip.background = element_blank(),
    axis.ticks.length = unit(0.15, "cm"),
    axis.text.x = element_text(color = "black", margin = margin(4, 0, 0, 0)),
    axis.text.y = element_text(color = "black", margin = margin(0, 4, 0, 0)),
    axis.title.x = element_text(margin = margin(8, 0, 0, 0)),
    axis.title.y = element_text(margin = margin(0, 8, 0, 0), angle = 90),
    ..., complete = TRUE)
  my_theme
}

expander <- function(ex = c(0, 0), ey = c(0, 1)) {
  list(
    scale_x_continuous(expand = ex),
    scale_y_continuous(expand = ey)
  )
}


add_grid <- function (color = "grey", linetype = "dotted", linewidth = 0.2,
                      ...) {
  grid <- theme(panel.grid.major = element_line(color = color,
                                                linewidth = linewidth, linetype = linetype, ...), )
  grid
}
