#' Function to convert into per capita and per other
#'
#' This function converts e.g. into per capita and then writes the result
#'
#' @param df a data.frame containing the data to be converted
#' @param file_name a character specifiying the name of the file (without path).
#' @param how_many by how many of the object. For example by 1000 inhabitants then how_many=1000. For per capita you have to set how_many=1.
#' @param type like "pop" or "area" (other types give error out)
#' @param simplify_date a bool that simplifies the year in case that it is not an exact match, e.g. 31.12.2020 simply to 2020.
#'
#' @export
#'

convert_and_write_per_unit<-function(df,file_name,how_many=1000,type="pop",simplify_date=F){
  # 21.12.2021: Rewritten; later: added possibilities for area-types as well

  if(type=="pop"){
    file_name<-"data/values/1_01_001.csv"}
  if(type=="area"){
    file_name<-"data/values/3_02_001.csv"}
  if(!(type %in% c("pop","area"))) stop("Invalid type given")

  base<-fread(file_name,select = c("spatialunit_ontology","spatialunit_hist_id","value","time_value"))
  base<-base %>% rename(base=value)


  # not tested yet:
  # supposed to simplify a year-match if it is not exactly e.g. 31.12.2020
  if(simplify_date){
    df$temp_time<-format(df$time_value,"%Y")
    base$temp_time<-format(base$time_value,"%Y")
    base$time_value<-NULL
    df<-merge(df,base,by=c("spatialunit_ontology","spatialunit_hist_id","temp_time"),all.x=T,sort=F)
    df$temp_time<-NULL
  }else{
    df<-merge(df,base,by=c("spatialunit_ontology","spatialunit_hist_id","time_value"),all.x=T,sort=F)
  }


  df$value<-df$value/df$base*how_many
  df$base<-NULL

  write.csv(df,paste0("data/values/",file_name),row.names = F)

}
