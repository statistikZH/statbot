#' Function to convert into per capita and per other
#'
#' This function converts e.g. into per capita and then writes the result
#'
#' @param df a data.frame containing the data to be converted
#' @param file_name a character specifiying the name of the file (without path).
#' @param how_many by how many of the object. For example by 1000 inhabitants then how_many=1000.
#' @param type like "pop" or "area" (not implemented yet)
#' @param simplify_date a bool that simplifies the year in case that it is not an exact match, e.g. 31.12.2020 simply to 2020.
#'
#' @export
#'

convert_and_write_per_unit<-function(df,file_name,how_many=1000,type="pop",simplify_date=F){
pop<-fread("data/values/1_01_001.csv",select = c("spatialunit_ontology","spatialunit_hist_id","value","time_value"))
pop<-pop %>% rename(pop=value)

# not tested yet:
# supposed to simplify a year-match if it is not exactly e.g. 31.12.2020
if(simplify_date){
  df$temp_time<-format(df$time_value,"%Y")
  pop$temp_time<-format(pop$time_value,"%Y")
  pop$time_value<-NULL
  df<-merge(df,pop,by=c("spatialunit_ontology","spatialunit_hist_id","temp_time"),all.x=T,sort=F)
  df$temp_time<-NULL
}else{
  df<-merge(df,pop,by=c("spatialunit_ontology","spatialunit_hist_id","time_value"),all.x=T,sort=F)
}


df$value<-df$value/df$pop*how_many
df$pop<-NULL

write.csv(df,paste0("data/values/",file_name),row.names = F)

}
