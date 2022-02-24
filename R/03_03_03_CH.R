#' Function do download the dataset with the id: 03_03_03_CH
#'
#' Created by: Matthias Widmer
#' Created at: 2022-02-22
#'
#' @param flag_force_update To force an update of the Dataset. Default: FALSE
#'
#' @export
statbot_src_03_03_03_CH <- function(flag_force_update=FALSE){
  destfile<-"temp/03_03_03_CH.csv"
  #download.file("https://www.file-address.com",destfile=destfile)

   if(check_changes_in_input_file(destfile)|flag_force_update){
     if(flag_force_update) print("flag_force_update") else print("Changes found")
    return("UPDATE OK")
   }else{
       return("UP-TO-DATE")
   }
}
