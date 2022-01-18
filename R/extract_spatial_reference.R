#' Function to extract spatial reference from metadata
#'
#' This function extracts the value of the spatial reference that is mentioned in the px-metadata.
#' It is based on many assumptions and can thus be very buggy! Careful!
#'
#' @param char_input a character vector containing the metadata string
#'
#' @export
extract_spatial_reference <- function(char_input){
  loc<-stringr::str_locate(pattern ='Raumbezug',char_input)[,1]
  temp<-substr(char_input,loc+11,loc+90)
  loc<-stringr::str_locate(pattern ='[0-9][0-9][0-9][0-9]',temp)[,1]
  temp<-substr(temp,1,loc+3)
  loc<-stringr::str_locate(pattern ='[0-9]',temp)[,1]
  temp<-substr(temp,loc,nchar(temp))
  time<-lubridate::parse_date_time(temp, orders = c("dmy"),locale="de_DE.UTF-8")
  time<-format(time,format="%d.%m.%Y")
  return(time)
}
