remove_aux <- function() {
  cmd <- "find . -type f -name '*.aux' -delete"
  system(cmd)
}
