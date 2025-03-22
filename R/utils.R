marker <- function(p, x, width, height, col = "grey70", size = 2) {
  p +
    annotate("segment", x = x, xend = x, y = height, yend = 0,
             linewidth = width, lineend = "butt", color = col) +
    annotate("point", x = x, y = height, color = col, size = size)
}

descr <- function(p, x, y, text, col = "black", size, ...) {
  p +
    annotate("text", x = x, y = y,
             label = text, angle = 90, size = size, ...)
}
