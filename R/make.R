make <- function(dir = "thesis", file = "thesis.Rnw", remove_build = TRUE) {
  wd <- getwd()
  o <- options()
  setwd(dir)

  if (remove_build) {
    unlink("build")
  }

  Sweave(file)
  system("make")
  remove_aux()

  setwd(wd)
  options(o)
  invisible(1)
}
