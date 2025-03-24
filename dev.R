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



## colors
demo("colors")



## choice variation plot
library(datapap)
p1 <- function(offset = 100) {
  dat <- wfh_choice_variation$input1
  ml <- weighted.mean(dat$f, dat$n)
  x. <- barplot(share ~ f, data = dat, ylim = c(0, 40), space = 0.1,
                border = "white",
                main = "Choice variation",
                xlab = "Teleworking days", ylab = "Share (%)")
  grid()
  # box()
  ## 0.7 == 0
  offset <- diff(range(x.)) / offset
  top <- 5
  col <- datapap::my_colors$colvec[1]
  x <- ml + x.[1]
  rect(xleft = x - offset, ybottom = 0.1, xright = x + offset, ytop = top,
       col = col, border = col)
  text(x, y = top, labels = round(ml, 2), adj = c(0.5, -0.5), font = 2)
  ## N
  labels <- trimws(format(dat$n, big.mark = "'"))
  text(x., y = dat$share, labels = labels, adj = c(0.5, -0.5))
}
p1()

p2 <- function(offset = 100) {
  dat <- wfh_choice_variation$input2
  ml <- weighted.mean(dat$diff, dat$n)
  x. <- barplot(share ~ diff, data = dat, ylim = c(0, 50), space = 0.1,
                border = "white",
                main = "Choice variation",
                xlab = "Chosen minus free-choice frequency (d/week)", ylab = "Share (%)")
  grid()
  # box()
  ## 5.5 == 0
  offset <- diff(range(x.)) / offset
  top <- 6.25
  col <- datapap::my_colors$colvec[1]
  x <- ml + x.[6]
  rect(xleft = x - offset, ybottom = 0.1, xright = x + offset, ytop = top,
       col = col, border = col)
  text(x, y = top, labels = round(ml, 2), adj = c(0.5, -0.5), font = 2)
  ## N
  labels <- trimws(format(dat$n, big.mark = "'"))
  text(x., y = dat$share, labels = labels, adj = c(0.5, -0.5))
}
p2()

plot.it <- function(...) {
  op <- par(no.readonly = TRUE)
  on.exit(par(op))
  par(mfrow = c(1, 2), ...)
  p1(); p2()
}
plot.it()
