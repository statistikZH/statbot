get_dataset_ids <- function(){
  # 20.12.2021: Change of ID-logic according to V3 of DB-schema
  #function_files <- list.files("R/",pattern = "^[0-9][0-9][0-9][0-9].*$")
  function_files <- list.files("R/",pattern = "^[0-9]_[0-9][0-9]_[0-9][0-9][0-9].*$")

  dataset_ids <- gsub("\\.R", "", function_files)

  return(dataset_ids)
}
