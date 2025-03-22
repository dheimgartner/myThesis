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
