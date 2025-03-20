### R code from vignette source 'thesis.Rnw'

###################################################
### code chunk number 1: preliminaries
###################################################
## mpp
library("mpp")
library("mppData")
library("tidyverse")
library("lubridate")
library("data.table")
library("patchwork")
library("apollo")
library("kableExtra")

## maybe adjust width here...
options(prompt = "R> ", continue = "+  ", width = 70, useFancyQuotes = FALSE,
        digits = 3)


###################################################
### code chunk number 2: preliminaries
###################################################
MAX <- as.Date("2022-12-30")

my_theme <-
  ggplot2::theme_light() +
  ggplot2::theme(legend.position = "bottom",
                 strip.background = element_rect(fill = "white"),
                 strip.text = element_text(colour = "black"))

ggplot2::theme_set(my_theme)


###################################################
### code chunk number 3: main.Rnw:8-9
###################################################
head(iris)


