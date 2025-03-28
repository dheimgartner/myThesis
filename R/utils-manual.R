#' Defaults
#'
#' Default options for `R CMD Rd2pdf`.
#'
#' @seealso [`Rd2pdf`]
#' @export
defaults <- c("--no-preview", "--no-clean", "--quiet", "--output=manual.pdf", "--force", "--build-dir=.manual")

#' Create R Manual
#'
#' Calls `R CMD Rd2pdf` with reasonable defaults.
#'
#' @param path a list of file names specifying the R documentation sources
#'   to use, by either giving the paths to the files, or the path to a
#'   directory with the sources of a package.
#' @param options further options (as vector) to be passed to `R CMD Rd2pdf`
#'   (defaults to `defaults`).
#' @param ... additional arguments passed to `system`.
#'
#' @returns return value of `system`.
#' @seealso [`Rd2pdf`]
#' @export
manual <- function(path = ".", options = defaults, ...) {
  opts <- paste(options, path, collapse = " ")
  cmd <- "R CMD Rd2pdf"
  system(paste(cmd, opts), ...)
}

manual_tex <- function(path = ".", ...) {
  tmp <- tempdir()
  bd_idx <- grep("--build-dir", defaults)
  opts <- defaults
  opts[bd_idx] <- paste0("--build-dir=", tmp)
  manual(path = path, options = opts, ...)
  files <- list.files(tmp)
  tex_idx <- grep(".tex$", files)
  tex <- readLines(paste(tmp, files[tex_idx], sep = "/"))
  unlink(tmp)
  unlink("manual.pdf")
  tex <- paste(tex, collapse = "\n")
  class(tex) <- c("Rmanual.tex", class(tex))
  tex
}

#' @export
print.Rmanual.tex <- function(x, ...) {
  cat(x)
}
