remove_aux <- function() {
  cmd <- "find . -type f -name '*.aux' -delete"
  system(cmd)
}

set_latexpath <- function(path = "~/.local/bin/") {
  if (!is.null(getOption("__latexpath"))) {
    path <- getOption("__latexpath")
  } else {
    options("__latexpath" = path)
  }
  Sys.setenv(PATH = paste(Sys.getenv("PATH"), getOption("__latexpath"), sep = ":"))
}

check_latexmk <- function() {
  tryCatch(
    system("latexmk --version"),
    warning = function(w) stop("Make sure the correct path is set in latexmk()")
  )
}

check_pdflatex <- function() {
  tryCatch(
    system("pdflatex --version"),
    warning = function(w) stop("Make sure the correct path is set in latexmk()")
  )
}
