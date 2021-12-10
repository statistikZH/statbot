get_dataset_ids <- function(){
  function_files <- list.files("R/",pattern = "^[0-9][0-9][0-9][0-9].*$")

  dataset_ids <- gsub("\\.R", "", function_files)

  return(dataset_ids)
}
