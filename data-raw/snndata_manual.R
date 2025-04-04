## code to prepare `snndata_manual` dataset goes here

# path <- "~/github/SNN/snndata/man/"
# rd_files <- list.files(path)
# rd_files <- rd_files[grepl("Rd$", rd_files)]
# sink("./data-raw/snndata_manual.tex")
# for (i in rd_files) {
#   cat("%%%%%\n\n")
#   tex <- tools::Rd2latex(paste(path, i, sep = "/"))
#   cat(tex, "\n")
# }
# sink()

snndata_manual <- paste(readLines("./data-raw/snndata_manual.tex"), collapse = "\n")
class(snndata_manual) <- c("Rmanual.tex", class(snndata_manual))
snndata_manual

usethis::use_data(snndata_manual, overwrite = TRUE)
