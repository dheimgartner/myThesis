## understand format
x <- c(1.00, 1.001, -1.1)
x_ <- format(x, justify = "left")  # left is default
stars <- c("", "*", "***")
paste0(x_, stars)


## kableExtra footnotes
library(kableExtra)
kbl(head(iris), format = "latex") %>%
  kableExtra::footnote("foo")



## kableExtra linespace
library(kableExtra)
kbl(head(iris), format = "latex", booktabs = TRUE)



## datapap ordered probit table
library(datapap)
library(tidyverse)
bootstrap$texreg
bootstrap$input


## nice colors
colvec <- c(1, 2, 3)

x <- seq(1, 100, by = 0.1)
n <- length(x)
y1 <- log(x) + 0.3 * rnorm(n)
y2 <- log(x) + 0.3 * rnorm(n)
y3 <- log(x) + 0.3 * rnorm(n)

plot(NULL, xlim = c(0, 100), ylim = c(0, max(y1, y2, y3)), type = "n",
     xlab = "x", ylab = "y")
points(x, y1, col = colvec[1], lwd = 2)
points(x, y2, col = colvec[2], lwd = 2)
points(x, y3, col = colvec[3], lwd = 2)
