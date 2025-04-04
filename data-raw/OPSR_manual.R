## code to prepare `OPSR_manual` dataset goes here

## sink to file and adjust there marginally (e.g., put proper citations, remove some
## links to functions outside of package, etc.)

# path <- "~/github/OPSR/man/"
# rd_files <- list.files(path)
# rd_files <- rd_files[grepl("Rd$", rd_files)]
# sink("./data-raw/OPSR_manual.tex")
# for (i in rd_files) {
#   cat("%%%%%\n\n")
#   tex <- tools::Rd2latex(paste(path, i, sep = "/"))
#   cat(tex, "\n")
# }
# sink()

OPSR_manual <- paste(readLines("./data-raw/OPSR_manual.tex"), collapse = "\n")
class(OPSR_manual) <- c("Rmanual.tex", class(OPSR_manual))
OPSR_manual

usethis::use_data(OPSR_manual, overwrite = TRUE)
