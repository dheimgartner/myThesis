## code to prepare `OPSRtools_manual` dataset goes here

# path <- "~/github/OPSRtools/man/"
# rd_files <- list.files(path)
# rd_files <- rd_files[grepl("Rd$", rd_files)]
# sink("./data-raw/OPSRtools_manual.tex")
# for (i in rd_files) {
#   cat("%%%%%\n\n")
#   tex <- tools::Rd2latex(paste(path, i, sep = "/"))
#   cat(tex, "\n")
# }
# sink()

OPSRtools_manual <- paste(readLines("./data-raw/OPSRtools_manual.tex"), collapse = "\n")
class(OPSRtools_manual) <- c("Rmanual.tex", class(OPSRtools_manual))
OPSRtools_manual

usethis::use_data(OPSRtools_manual, overwrite = TRUE)
