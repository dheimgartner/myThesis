## code to prepare `mpp_coef_labels` dataset goes here

mpp_coef_labels <- readxl::read_xlsx("./data-raw/mpp_coef_labels.xlsx")

usethis::use_data(mpp_coef_labels, overwrite = TRUE)
