make <- function(dir = "thesis", file = "thesis.Rnw", remove_build = TRUE) {
  BUILD_DIR <- "_build"
  if (remove_build) {
    unlink("build", recursive = TRUE)
  }

  tmp_build_dir <- function(src = dir, build_dir = BUILD_DIR) {
    dir.create(build_dir)
    file.copy(src, build_dir, recursive = TRUE)
    paste(build_dir, src, sep = "/")
  }

  tmp_dir <- tmp_build_dir()
  wd <- getwd()
  o <- options()
  setwd(tmp_dir)

  set_latexpath()
  check_latexmk()
  check_pdflatex()

  Sweave(file)
  system("make", ignore.stderr = TRUE)
  remove_aux()

  file.copy("build", "../..", recursive = TRUE)
  setwd(wd)
  unlink(BUILD_DIR, recursive = TRUE)
  options(o)

  invisible(1)
}
