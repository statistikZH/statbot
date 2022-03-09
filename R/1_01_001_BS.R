#' Function do download the dataset with the id: 1_01_001_BS
#'
#' Created by: Hester Pieters
#' Created at: 2022-02-25
#'
#' @param flag_force_update To force an update of the Dataset. Default: FALSE
#'
#' @export
statbot_src_1_01_001_BS <- function(flag_force_update=FALSE){
  destfile<-"temp/1_01_001_BS.csv"
  #download.file("https://www.file-address.com",destfile=destfile)

   if(check_changes_in_input_file(destfile)|flag_force_update){
     if(flag_force_update) print("flag_force_update") else print("Changes found")
    return("UPDATE OK")
   }else{
       return("UP-TO-DATE")
   }
}
