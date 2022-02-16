#' Create a function file in the R directory for a specific dataset download
#'
#' @param dataset_id Dataset-ID with the following structure: XXYYY_ZZ
#'     XX=SDMX-Classification
#'     YYY=STATBOT_CODE
#'     ZZZZ=CH FOR OVERALL COUNTRY CODE, OR YOUR 2-LETTER CANTONAL CODE OR FOUR DIGITS BFS-COMMUNAL-CODE
#'
#' @param author Name of the creator
#'
#' @examples
#' \dontrun{
#' download_datast_init(99999_99, "Thomas Knecht")
#' }
#'
#' @export
download_dataset_init <- function(dataset_id, author){
  new_file_name <- paste0(dataset_id, ".R")
  new_file_path <- paste0("R/", new_file_name)

  existing_files <- list.files("R")

  if(new_file_name %in% existing_files){
    stop(glue::glue("There is already a file named: {new_file_name}"))
  }

  template_path <- "scripts/templates/template.R"

  template <- readLines(template_path)

  data <- list(
    dataset_id = dataset_id,
    author = author,
    created = Sys.Date()
  )
  writeLines(whisker::whisker.render(template, data), new_file_path)
  alert_success_grey(glue::glue("The new file: {new_file_name}, is created"))

  devtools::document(".")
  alert_success_grey(glue::glue("Documentation is renewed"))
}

#' Create a function file in the R directory for a specific dimension file
#'
#' @param dataset_id Dataset-ID with the following structure: XXYYY_ZZ
#'     XX=SDMX-Classification
#'     YYY=STATBOT_CODE
#'     ZZZZ=CH FOR OVERALL COUNTRY CODE, OR YOUR 2-LETTER CANTONAL CODE OR FOUR DIGITS BFS-COMMUNAL-CODE
#'
#' @param author Name of the creator
#'
#' @examples
#' \dontrun{
#' download_datast_init(99999_99, "Thomas Knecht")
#' }
#'
#' @export
dimension_file_init <- function(dataset_id, author){
  base_path <- "scripts/dimensions"

  dir.create(base_path, showWarnings = F)

  new_file_name <- paste0(dataset_id, ".R")
  new_file_path <- paste0(base_path,"/dimenstions_", new_file_name)

  existing_files <- list.files(base_path)

  if(new_file_name %in% existing_files){
    stop(glue::glue("There is already a file named: {new_file_name}"))
  }

  template_path <- "scripts/templates/template_dimensions.R"

  template <- readLines(template_path)

  data <- list(
    dataset_id = dataset_id,
    author = author,
    created = Sys.Date()
  )
  writeLines(whisker::whisker.render(template, data), new_file_path)
  alert_success_grey(glue::glue("The new file: {new_file_name}, is created"))

  devtools::document(".")
  alert_success_grey(glue::glue("Documentation is renewed"))
}



