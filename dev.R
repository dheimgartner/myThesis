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



## manual tex
devtools::load_all()
path <- "~/github/OPSR"
mtex <- manual_tex(path)
mtex
sink("./vignettes/chapters/appendix/opsr-manual.tex")
print(mtex)
sink()



## conceptual figure
## simulate error distribution and show "truncation"
devtools::load_all()
library(OPSR)
library(mvtnorm)

set.seed(0)

## tobit-5 model
vc <- diag(3)
vc[lower.tri(vc)] <- c(0.9, 0.5, 0.1)
vc[upper.tri(vc)] <- vc[lower.tri(vc)]
eps <- rmvnorm(500, c(0, 0, 0), vc)
colnames(eps) <- c("epsilon", "eta1", "eta2")
xs <- runif(500)
ys <- xs + eps[, 1] > 0
xo1 <- runif(500)
yo1 <- xo1 + eps[, 2]
xo2 <- runif(500)
yo2 <- xo2 + eps[, 3]
yo <- ifelse(ys, yo2, yo1)
ys <- as.numeric(ys) + 1
dat <- data.frame(ys, yo, yo1, yo2, xs, xo1, xo2)
head(dat)


library(tidyverse)
plot.errors <- function(dat, eps) {
  z <- dat$ys

  dat. <-
    eps %>%
    cbind(z) %>%
    as.data.frame() %>%
    pivot_longer(-c(epsilon, z))

  m_eta_ntw <-
    dat. %>%
    filter(z == 1) %>%
    pull(epsilon) %>%
    mean()

  m_eta_tw <-
    dat. %>%
    filter(z == 2) %>%
    pull(epsilon) %>%
    mean()

  col_ntw <- "#ff8811"
  col_tw <- "#48a9a6"
  p <-
    dat. %>%
    ggplot(aes(x = value, y = epsilon, col = factor(z, labels = c("NTWers", "TWers")))) +
    geom_point(alpha = 0.4, show.legend = TRUE) +
    geom_vline(xintercept = m_eta_ntw, col = col_ntw, linetype = "dashed") +
    geom_vline(xintercept = m_eta_tw, col = col_tw, linetype = "dashed") +
    scale_color_manual(values = c(col_ntw, col_tw)) +
    labs(x = expression(eta), y = expression(epsilon)) +
    my_theme() +
    xlim(c(-4, 4)) +
    ylim(c(-4, 4)) +
    labs(col = "TW status") +
    guides(color = guide_legend(override.aes = list(alpha = 1)))

  p <- ggExtra::ggMarginal(p, groupColour = TRUE, groupFill = TRUE, margins = "x")
  p
}

plot.errors(dat, eps)

## draw teatment effects and add boxplot with "correction"
tobit5 <- opsr(ys | yo ~ xs | xo1 | xo2, data = dat, printLevel = 0)
c_ntw <- predict(tobit5, group = 1, counterfact = 2, type = "correction")
xb_ntw <- predict(tobit5, group = 1, counterfact = 2, type = "Xb")
c_tw <- predict(tobit5, group = 2, counterfact = 1, type = "correction")
xb_tw <- predict(tobit5, group = 2, counterfact = 1, type = "Xb")
boxplot(xb_ntw, c_ntw, xb_tw, c_tw)

## indicate that Xb might be different!

## base plot
plot.it <- function() {
  col_ntw <- "#ff8811"
  col_tw <- "#48a9a6"

  dat <- data.frame(x = c(0, 0, 1, 1),
                    y = c(1, 2.5, 1, 2))
  plot(dat, ylim = c(0, 4), xlim = c(-0.5, 1.5), axes = FALSE, cex = 2,
       xlab = "TW status", ylab = "Weekly km traveled",
       pch = c(19, 1, 1, 19), col = c(col_ntw, col_tw, col_ntw, col_tw))
  axis(1, at = c(0, 1), labels = c("NTWing", "TWing"))
  axis(2, labels = FALSE)
  legend("topleft", c("NTWers", "TWers", "factual", "counterfactual"), bty = "n",
         pch = c(19, 19, 19, 1), col = c(col_ntw, col_tw, "black", "black"))
  abline(v = 0.5, lty = 2)
  abline(h = 1, col = col_ntw, lty = 3)
  abline(h = 2, col = col_tw, lty = 3)
  abline(h = 2.5, col = col_tw, lty = 3)
  box(bty = "l")
}

png("./vignettes/chapters/introduction/conceptual_figure.png", height = 8, width = 10, units = "in", res = 144)
plot.it()
dev.off()
