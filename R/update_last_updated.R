#' Function to update the time-stamp in classes function
#'
#' This function updates the time-stamp in the classes function
#'
#' @param id to be updated
#'
#' @export
update_last_updated<-function(id){
df<-read.csv("data/classes.csv")

if(length(df$last_updated[df$class_id==id])==0) stop("Error: indicator_id does not match or indicator description is missing.")

df$last_updated[df$class_id==id]<-Sys.Date()
write.csv(df,"data/classes.csv",row.names = F)
}
