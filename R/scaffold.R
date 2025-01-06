scaffold <- function(dir = "thesis") {
  if (dir.exists(dir)) {
    stop(dir, " directory already exists.")
  }
  dir.create(dir)
  src <- system.file("template", package = "myThesis")
  file.copy(src, ".", recursive = TRUE)
  file.rename("template", dir)
  invisible(1)
}
