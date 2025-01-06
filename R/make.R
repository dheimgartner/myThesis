make <- function(file = "thesis.Rnw", remove_build = TRUE) {
  if (remove_build) {
    unlink("build")
  }

  Sweave(file)
  system("make")
  file_ <- sub(".Rnw$", ".tex", file)
  file.remove(file_)
}
