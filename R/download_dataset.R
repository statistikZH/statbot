#' Function to download a dataset with a certain dataset_id
#'
#' @param dataset_id Id of the dataset to be downloaded
#'
#' @param flag_force_update Whether to force the download or not
#'
#' @export
download_dataset <- function(dataset_id, flag_force_update){
  start_time<-Sys.time()

  function_name <- paste0("statbot_src_", dataset_id)

  download_function <- get(function_name)

  return_value<-tryCatch(download_function(flag_force_update=flag_force_update),
                         error=function(c) paste0("error running: ", function_name, "()"))
                         #warning=function(c) paste0("warning running: ", function_name, "()"),
                         #message=function(c) paste0("message running: ", function_name, "()"))


  end_time<-Sys.time()

  logger(paste0(
    dataset_id,
    ": ",
    return_value,
    paste0(" FINISHED IN: ",round(as.numeric (end_time - start_time, units = "secs"),1), " SECONDS")
  ))

  alert_info_grey(glue::glue("{dataset_id}: {return_value}"))

}
