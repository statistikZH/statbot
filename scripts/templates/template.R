#' Function do download the dataset with the id: {{dataset_id}}
#'
#' Created by: {{author}}
#' Created at: {{created}}
#'
#' @param flag_force_update To force an update of the Dataset. Default: FALSE
#'
#' @export
statbot_src_{{dataset_id}} <- function(flag_force_update=FALSE){
  destfile<-"temp/{{dataset_id}}.csv"
  #download.file("https://www.file-address.com",destfile=destfile)

   if(check_changes_in_input_file(destfile)|flag_force_update){
     if(flag_force_update) print("flag_force_update") else print("Changes found")
    return("UPDATE OK")
   }else{
       return("UP-TO-DATE")
   }
}
