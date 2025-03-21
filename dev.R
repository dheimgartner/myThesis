## understand format
x <- c(1.00, 1.001, -1.1)
x_ <- format(x, justify = "left")  # left is default
stars <- c("", "*", "***")
paste0(x_, stars)
