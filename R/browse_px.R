#' Function to quickly browse a px-file
#'
#'
#' @param px-number a character with the px code
#'
#' @export
browse_px<-function(px_number){
  browseURL(paste0("https://www.pxweb.bfs.admin.ch/pxweb/de/",px_number,"/",px_number,"/",px_number,".px"))
}
