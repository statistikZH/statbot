source("helper.R")
library("xlsx")
library("janitor")
library("tidyverse")

statbot_src_32001_CH <- function(){
  destfile<-"temp/bfs_gp.xlsx"
  download.file("https://www.bfs.admin.ch/bfsstatic/dam/assets/15864450/master",destfile=destfile)
  # TODO ONLY EXECUTE IF CHANGES
  check_changes_in_input_file(destfile)
  df<-read.xlsx(destfile,1,startRow=6,header=T) %>% janitor::clean_names()
  year_value<-df$gesamtflache_in_km_1[1]
  df<-df[3:nrow(df),]

  df$gemeindecode[1]<-0
  new_df<-df[,c("gesamtflache_in_km_1","gemeindecode")]

  colnames(new_df)[colnames(new_df)=="gesamtflache_in_km_1"]<-"value"
  colnames(new_df)[colnames(new_df)=="gemeindecode"]<-"spatialunit_id"
  new_df$indicator_id<-32001
  new_df$time_value<-year_value
  new_df$timeinfo_id<-1
  new_df$dim1_value_id<-NA
  new_df$dim2_value_id<-NA
  new_df$dim3_value_id<-NA

  write.csv(new_df,"data/values/32001_CH.csv")


  return("OK")
}
