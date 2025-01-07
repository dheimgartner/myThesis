make <- function(dir = "thesis", file = "thesis.Rnw", remove_build = TRUE) {
  if (remove_build) {
    unlink("build", recursive = TRUE)
  }

  wd <- getwd()
  o <- options()
  setwd(dir)

  set_latexpath()
  check_latexmk()
  check_pdflatex()

  Sweave(file)
  system("make", ignore.stderr = TRUE)
  remove_aux()

  file.copy("build", "..", recursive = TRUE)
  unlink("build", recursive = TRUE)
  setwd(wd)
  options(o)

  invisible(1)
}
