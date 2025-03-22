## code to prepare `mpp_plot_cn` dataset goes here

devtools::load_all()

library(mpp)
library(mppData)
library(tidyverse)

MAX <- as.Date("2022-12-30")
colvec <- mpp::colors$all[c(4, 7)]

my_theme <-
  ggplot2::theme_light() +
  ggplot2::theme(legend.position = "bottom",
                 panel.border = element_rect(fill = NA, colour = "black",
                                             linewidth = rel(1.2)),
                 axis.ticks = element_line(colour = "black", linewidth = rel(1)),
                 strip.background = element_rect(fill = "white"),
                 strip.text = element_text(colour = "black"),
                 panel.grid.major.x = element_blank(),
                 panel.grid.minor.x = element_blank())

ggplot2::theme_set(my_theme)

df_part <-
  mppData::mobis_analysis$participants_per_day %>%
  pivot_longer(-day) %>%
  mutate(sample = factor(name, labels = c("participants", "tracking"))) %>%
  filter(day <= MAX) %>%
  select(-name, date = day) %>%
  pivot_wider(names_from = sample, values_from = value)

df_cn <-
  mpp::covid_numbers %>%
  filter(georegion == "CH") %>%
  select(date = datum, case_numbers = entries) %>%
  arrange(date) %>%
  mutate(case_numbers_rol = zoo::rollmean(case_numbers, k = 14, fill = NA)) %>%
  drop_na() %>%
  select(date, cn = case_numbers_rol)

df_tog <-
  df_part %>%
  left_join(df_cn, by = "date")

scl <- max(df_tog$participants, na.rm = TRUE) / max(df_tog$cn, na.rm = TRUE)

p <-
  df_tog %>%
  ggplot(aes(x = date)) +
  geom_line(aes(y = tracking, col = "Actively tracking (left scale)"), alpha = 0.7, size = 1.1) +
  geom_line(aes(y = scl * cn, col = "Case numbers (right scale)"), size = 1.1) +
  scale_x_date(date_breaks = "2 months",
               date_labels = "%b-%y",
               expand = expansion(mult = c(0, 0))) +
  scale_y_continuous(sec.axis = sec_axis(~./scl, name = "Average case numbers"),
                     expand = expansion(mult = c(0, .1)),
                     limits = c(0, 1700)) +
  scale_colour_manual(values = colvec[c(2, 1)]) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(x = "", y = "Number of participants", col = NULL) +
  guides(color = guide_legend(override.aes = list(alpha = 1, linewidth = 2)))
p

## add annotations
dates <- c("2020-02-28",
           "2020-04-27",
           "2020-10-19",
           "2021-03-01",
           "2021-09-13",
           "2022-03-01")

y <- c(100,
       100,
       400,
       150,
       200,
       1100)

labels <- c(
  'bold("Feb 28") * " First wave: outbreak of the COVID pandemic"',
  'bold("April 27") * " Calm summer months"',
  'atop(bold("Oct 19") * " Second wave: Home office", "recommendation followed by requirement")',
  'bold("March 1") * " Shallow third wave: Calm summer months"',
  'atop(bold("Sep 13") * " Fourth wave: Omicron variante,", "Home office and certificate requirement")',
  'bold("March 1") * " Normalization"'
)

for (i in seq_along(dates)) {
  p <- marker(p, x = as.Date(dates[i]), width = 0.5, height = y[i], size = 3)
  vjust <- ifelse(i %in% c(3, 5), 0.82, 0.5)
  p <- descr(p, x = as.Date(dates[i]), y = y[i] + 50, text = labels[i], size = 3, hjust = 0, vjust = vjust, parse = TRUE)
}

p

mpp_plot_cn <- list()
mpp_plot_cn$scl <- scl
mpp_plot_cn$p <- p

usethis::use_data(mpp_plot_cn, overwrite = TRUE)
