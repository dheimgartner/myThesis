remove_aux <- function() {
  cmd <- "find . -type f -name '*.aux' -delete"
  system(cmd)
}

set_latexpath <- function(path = "/home/daniehei/.local/bin") {
  if (!is.null(getOption("__latexpath"))) {
    path <- getOption("__latexpath")
  } else {
    options("__latexpath" = path)
  }
  Sys.setenv(PATH = paste(Sys.getenv("PATH"), getOption("__latexpath"), sep = ":"))
}

check_latexmk <- function() {
  tryCatch(
    {
      cat("--------------------------------------------\n")
      system("latexmk --version")
      cat("--------------------------------------------\n")
    },
    warning = function(w) stop("Make sure the correct path is set in set_latexpath()")
  )
}

check_pdflatex <- function() {
  tryCatch(
    {
      cat("--------------------------------------------\n")
      system("pdflatex --version")
      cat("--------------------------------------------\n")
    },
    warning = function(w) stop("Make sure the correct path is set in set_latexpath()")
  )
}
