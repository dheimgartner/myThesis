switch_theme <- function(default = "Kiss", alternative = "Textmate (default)") {
  current <- rstudioapi::getThemeInfo()$editor
  if (current != default) rstudioapi::applyTheme(default)
  else rstudioapi::applyTheme(alternative)
}
