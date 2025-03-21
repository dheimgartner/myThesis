### R code from vignette source 'thesis.Rnw'

###################################################
### code chunk number 1: preliminaries
###################################################
## mpp
library("myThesis")
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
### code chunk number 2: mpp-preliminaries
###################################################
MAX <- as.Date("2022-12-30")

colvec <- c("#46337EFF", "#277F8EFF", "#4AC16DFF")
col_annot <- "grey40"

add_annotations <- mpp:::add_annotations
add_zero_line <- mpp:::add_zero_line
add_end_markers <- mpp:::add_end_markers
add_baseline_comparison <- mpp:::add_baseline_comparison

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

rn_work_outside_home <- function(df) {
  df %>%
    mutate(working_arrangement = factor(
      if_else(working_arrangement == "Work outside home",
              "Office", working_arrangement)
    ))
}


###################################################
### code chunk number 3: mpp-participation-and-casenumbers
###################################################
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
  geom_line(aes(y = participants, col = "Total"), alpha = 0.7) +
  geom_line(aes(y = tracking, col = "Tracking"), alpha = 0.7) +
  geom_line(aes(y = scl * cn), col = colvec[1], size = 1.1) +
  scale_x_date(date_breaks = "2 months",
               date_labels = "%b-%y") +
  scale_y_continuous(sec.axis = sec_axis(~./scl, name = "Average case numbers")) +
  scale_colour_manual(values = colvec[c(2, 3)]) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(x = "", y = "Number of participants", col = "Sample") +
  guides(color = guide_legend(override.aes = list(alpha = 1, linewidth = 2)))

df_ph <-
  mpp::covid_phases %>%
  left_join(df_cn, by = c("lower" = "date")) %>%
  mutate(cn = ifelse(is.na(cn), 0, scl * cn))

label_pos <- function(df) {
  x <- df$label
  y <- df$cn
  pos <- sapply(seq_along(x), function(i) {
    xi <- x[i]
    yi <- y[i]
    if (xi == "Phase 2") {
      return(yi + scl * 12e3)
    } else if (xi == "Phase 6") {
      return(yi + scl * 7e3)
    } else {
      return(yi + scl * 3.5e3)
    }
  })
  pos
}

p_ <- add_annotations(p, y = label_pos(df_ph),
                      text = TRUE, text_size = 2, col = col_annot)
p_ + theme(panel.grid = element_blank(), panel.grid.minor = element_blank())


###################################################
### code chunk number 4: mpp-activity-spaces
###################################################
limits <- c(-1, 1.1)

p1_bar <-
  mpp::activity_spaces$weekday_abs %>%
  mpp::phase_comparison_chart(gv = weekday, tv = ellipse_area, colors = colors$all,
                              x = "", y = "Activity space\n95% ellipse area (km2)", fill = "", x = "")

p1 <-
  mpp::base_plot(data = mpp::activity_spaces$weekday, MAX = MAX, .col = weekday, colors = mpp::colors$binary,
                 x = "Week", y = "Activity space change (%)", color = "") +
  scale_y_continuous(limits = limits, labels = scales::percent) +
  add_zero_line()

p1 <-
  add_annotations(p1, y = 0.4, col = col_annot) %>%
  add_baseline_comparison(gv = weekday) %>%
  add_end_markers(gv = weekday)

p2 <-
  mpp::activity_spaces$working_arrangement %>%
  rn_work_outside_home() %>%
  drop_na(working_arrangement) %>%
  mpp::base_plot(MAX, working_arrangement, colors = mpp::colors$working_arrangement,
                 x = "Week", y = "Activity space change (%)", color = "") +
  scale_y_continuous(limits = limits, labels = scales::percent) +
  add_zero_line()

p2_bar <-
  mpp::activity_spaces$working_arrangement_abs %>%
  drop_na() %>%
  mpp::phase_comparison_chart(gv = working_arrangement, tv = ellipse_area, colors = colors$all,
                              order = c("Home office", "Mixture", "Work outside home"),
                              x = "", y = "Activity space\n95% ellipse area (km2)", fill = "", x = "")

p2 <-
  add_annotations(p2, y = 0.4, col = col_annot) %>%
  add_baseline_comparison(gv = working_arrangement) %>%
  add_end_markers(gv = working_arrangement)

p1_bar + p2_bar + p1 + p2 + plot_layout(heights = c(2, 3))


###################################################
### code chunk number 5: mpp-overview
###################################################
limits <- c(-1, 1.1)

p1 <-
  mpp::average_daily_distance$total %>%
  mpp::base_plot(MAX, mode, colors = mpp::colors$modes,
                 x = "Week", y = "Change in average daily distance (%)", color = "") +
  scale_y_continuous(limits = limits, labels = scales::percent) +
  add_zero_line()

p1 <-
  p1 %>%
  add_annotations(y = 0.25, col = col_annot) %>%
  add_baseline_comparison(gv = mode) %>%
  add_end_markers(gv = mode)

p1_bar <-
  mpp::average_daily_distance$total_abs %>%
  mutate(dist = dist / 1e3) %>%
  mpp::phase_comparison_chart(mode, dist, colors = colors$all, y = "Average daily distance (km)", fill = "", x = "")

p2 <-
  mpp::number_of_stages$total %>%
  mpp::base_plot(MAX, mode, colors = mpp::colors$modes,
                 x = "Week", y = "Change in number of stages (%)", color = "") +
  scale_y_continuous(limits = limits, labels = scales::percent) +
  add_zero_line()

p2 <-
  p2 %>%
  add_annotations(y = 0.25, col = col_annot) %>%
  add_baseline_comparison(gv = mode) %>%
  add_end_markers(gv = mode)

p2_bar <-
  mpp::number_of_stages$total_abs %>%
  mpp::phase_comparison_chart(mode, n_stages, colors = colors$all, y = "Average number of stages", fill = "", x = "")

p1_bar + p2_bar + p1 + p2 + plot_layout(heights = c(2.5, 3))


###################################################
### code chunk number 6: mpp-day-on-day
###################################################
p1 <-
  mpp::axa_data$stage_length %>%
  filter(week_start <= MAX) %>%
  mutate(mode = factor(str_to_title(mode)),
         rol = rol / 1e3) %>%
  ggplot(aes(x = as.numeric(as.character(day)), y = rol, col = year, shape = year)) +
  geom_point(size = 6, alpha = 0.8) +
  facet_wrap(vars(mode), scales = "free_y", ncol = 1) +
  scale_color_manual(values = mpp::colors$all[c(4, 2, 6, 7)]) +
  scale_shape_manual(values = c(15, 16, 17, 18)) +
  labs(x = "Day of year", y = "Trip leg length [km/leg]", col = "Year", shape = "Year")


p2 <-
  mpp::axa_data$stages_per_day %>%
  filter(week_start <= MAX) %>%
  mutate(mode = factor(str_to_title(mode))) %>%
  ggplot(aes(x = as.numeric(as.character(day)), y = rol, col = year, shape = year)) +
  geom_point(size = 6, alpha = 0.8) +
  facet_wrap(vars(mode), scales = "free_y", ncol = 1) +
  scale_color_manual(values = mpp::colors$all[c(4, 2, 6, 7)]) +
  scale_shape_manual(values = c(15, 16, 17, 18)) +
  labs(x = "Day of year", y = "Number of stages per day", col = "Year", shape = "Year")


p1 + p2 + plot_layout(guides = "collect")


###################################################
### code chunk number 7: mpp-overview-by-wa
###################################################
limits <- c(-0.75, 0.1)

p1 <-
  mpp::average_daily_distance$working_arrangement %>%
  rn_work_outside_home() %>%
  mpp::base_plot(MAX, working_arrangement, colors = mpp::colors$working_arrangement,
                 x = "Week", y = "Change in average daily distance (%)", color = "") +
  scale_y_continuous(limits = limits, labels = scales::percent) +
  add_zero_line()

p1_bar <-
  mpp::average_daily_distance$working_arrangement_abs %>%
  drop_na(working_arrangement) %>%
  mutate(dist = dist / 1e3) %>%
  mpp::phase_comparison_chart(working_arrangement, tv = dist, colors = mpp::colors$all,
                              order = c("Home office", "Mixture", "Work outside home"),
                              x = "", y = "Average daily distance (km)", fill = "")

p1 <-
  p1 %>%
  add_annotations(y = -0.7, col = col_annot) %>%
  add_baseline_comparison(gv = working_arrangement) %>%
  add_end_markers(gv = working_arrangement)

p2 <-
  mpp::number_of_stages$working_arrangement %>%
  rn_work_outside_home() %>%
  mpp::base_plot(MAX, working_arrangement, colors = mpp::colors$working_arrangement,
                 x = "Week", y = "Change in number of stages (%)", color = "") +
  scale_y_continuous(limits = limits, labels = scales::percent) +
  add_zero_line()

p2 <-
  p2 %>%
  add_annotations(y = -0.7, col = col_annot) %>%
  add_baseline_comparison(gv = working_arrangement) %>%
  add_end_markers(gv = working_arrangement)

p2_bar <-
  mpp::number_of_stages$working_arrangement_abs %>%
  drop_na(working_arrangement) %>%
  mpp::phase_comparison_chart(working_arrangement, n_stages, colors = colors$all,
                              order = c("Home office", "Mixture", "Work outside home"),
                              y = "Average number of stages", fill = "", x = "")

p1_bar + p2_bar + p1 + p2 + plot_layout(heights = c(2, 3))


###################################################
### code chunk number 8: mpp-mode-shares
###################################################
limits <- c(-1, 2.5)

p1 <-
  mpp::mode_frequency_shares$rel %>%
  mpp::base_plot(MAX, mode, colors = mpp::colors$modes,
                 x = "Week", y = "Mode shares\n(based on mode frequency)", color = "") +
  scale_y_continuous(limits = limits, labels = scales::percent) +
  add_zero_line()

p1 <-
  p1 %>%
  add_annotations(y = 0.6, col = col_annot) %>%
  add_baseline_comparison(gv = mode) %>%
  add_end_markers(gv = mode)

p1_bar <-
  mpp::mode_frequency_shares$abs %>%
  mpp::phase_comparison_chart(mode, mode_share_pc, colors = colors$all, y = "Mode shares\n(based on mode frequency)", fill = "", x = "") +
  scale_y_continuous(labels = scales::percent)

p2 <-
  mpp::mode_distance_shares$all %>%
  mpp::base_plot(MAX, mode, colors = mpp::colors$modes,
                 x = "Week", y = "Mode shares\n(based on distance)", color = "") +
  scale_y_continuous(limits = limits, labels = scales::percent) +
  add_zero_line()

p2 <-
  p2 %>%
  add_annotations(y = 1, col = col_annot) %>%
  add_baseline_comparison(gv = mode) %>%
  add_end_markers(gv = mode)

p2_bar <-
  mpp::mode_distance_shares$all_abs %>%
  mpp::phase_comparison_chart(mode, mode_share, colors = colors$all, y = "Mode shares\n(based on distance)", fill = "", x = "") +
  scale_y_continuous(labels = scales::percent)

p1_bar + p2_bar + p1 + p2 + plot_layout(heights = c(2.5, 3))


###################################################
### code chunk number 9: mpp-mode-share-indicators
###################################################
p2 <-
  mpp::mode_distance_shares$working_arrangement_abs %>%
  rn_work_outside_home() %>%
  drop_na() %>%
  facet_bar_chart(working_arrangement)

p2


###################################################
### code chunk number 10: mpp-hourly-counts
###################################################
## only baseline vs. phase_6
p1 <-
  mpp::number_of_started_trips$phase_comparison %>%
  ggplot(aes(x = hour1, y = n_rel, group = interaction(weekday, mode, label), col = label)) +
  geom_line(alpha = 0.7, size = 1.1) +
  scale_color_manual(values = mpp::colors$binary) +
  scale_y_continuous(labels = scales::percent) +
  # theme_minimal() +
  labs(x = "Hour", y = "Number of started trips\n(relative to max value)", color = "") +
  facet_grid(rows = vars(mode), cols = vars(weekday))

p2 <-
  mpp::number_of_started_trips$working_arrangement %>%
  rn_work_outside_home() %>%
  filter(working_arrangement != "Mixture") %>%
  ggplot(aes(x = hour1, y = n_rel, group = interaction(mode, working_arrangement), col = working_arrangement)) +
  geom_line(alpha = 0.7, size = 1.1) +
  scale_color_manual(values = mpp::colors$working_arrangement) +
  scale_y_continuous(labels = scales::percent) +
  # theme_minimal() +
  labs(x = "Hour", y = "Number of started trips\n(relative to max value)", color = "") +
  facet_grid(rows = vars(mode))

p1 + p2 + plot_layout(guides = "collect", design = "AAB")


###################################################
### code chunk number 11: mpp-results
###################################################
modes <- c("ca", "cy", "bu", "tn", "tm", "wa")

base <-
  mpp::results$base %>%
  dplyr::filter(coef != "sigma")

dt <- mpp::results$difftest

df <-
  base %>%
  mutate(phase = stringr::str_extract(coef, "[0-9]$"),
         coef = stringr::str_remove(coef, "_[0-9]$"),
         phase = ifelse(stringr::str_starts(coef, "sig"), "1", phase)) %>%
  left_join(dt, by = "coef") %>%
  mutate(across(where(is.numeric), ~ round(.x, digits = 3)),
         difftest = ifelse(stringr::str_starts(coef, "sig"), 100, difftest),
         sig_diff = difftest < 0.05) %>%
  select(-difftest) %>%
  as.data.frame()

## split coef into mode and coef
df <-
  df %>%
  mutate(mode = Reduce(c, stringr::str_extract_all(coef, paste(modes, collapse = "|"))),
         coef = stringr::str_remove_all(coef, paste("_", modes, sep = "", collapse = "|")))

## robse in brackets
## add stars
## estimate bold if sig_diff
## want left aligned -(3.3)
dff <-
  df %>%
  mutate(robse = paste0("(", format(robse), ")"),
         estimate = format(estimate),
         estimate = ifelse(stars == "",
                           estimate,
                           paste0(estimate, "^{", stars, "}")),
         estimate = ifelse(str_starts(estimate, "-"),
                                      estimate,
                                      paste0("\\phantom{-}", estimate)),
         estimate = ifelse(sig_diff,
                           paste0(estimate, "\\dagger"),
                           estimate),
         estimate = paste0("$", estimate, "$")) %>%
  select(-stars, -sig_diff)

## wide
dfw <-
  dff %>%
  pivot_wider(names_from = mode, values_from = c(estimate, robse),
              names_glue = "{mode}_{.value}")

dfw <-
  dfw %>%
  select(phase, coef, matches("^ca"), all_of(sort(names(dfw))))

## translate coefs
dfw <-
  dfw %>%
  left_join(mpp_coef_labels, by = c("coef" = "from")) %>%
  arrange(phase, order) %>%
  select(-coef, -order, -phase) %>%
  rename(coef = to) %>%
  select(coef, everything())

mat <- as.matrix(dfw)
mat[is.na(mat)] <- ""

## grouped rows
mat[, "coef"] <- paste0("\\quad ", mat[, "coef"])

mat_tex <- paste0(apply(mat, 1, paste, collapse = " & "), "\\\\")

## add baseline and normalization
mat_tex <- c("BASELINE\\\\", mat_tex)
mat_tex <- c(mat_tex[1:19], "NORMALIZATION\\\\", mat_tex[20:length(mat_tex)])

## midrule between phase 1 and 2
mat_tex[19] <- paste(mat_tex[19], "\\midrule")

## TODO
## longtable in landscape mode
## add signif footnotes from TWTE

writeLines(mat_tex)


