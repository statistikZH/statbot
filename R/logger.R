#' function to quicker log some output
#'
#' @param log_string message to be logged
#'
#' @export
logger<-function(log_string){
  cat(log_string,sep = "\n",file=paste0(log_folder,"main_",datetime,".log"),append=TRUE)
}
