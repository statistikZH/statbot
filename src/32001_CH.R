source("helper.R")
library("xlsx")
library("janitor")
library("tidyverse")

#consists of communal (+swiss total) and of cantonal areas

statbot_src_32001_CH <- function(flag_force_update=FALSE){

  bfs_nr_gem <- "je-d-21.03.01"

  asset_number_gem <- get_bfs_asset_nr(bfs_nr_gem)

  destfile<-"temp/bfs_gp.xlsx"
  download.file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",asset_number_gem,"/master"),destfile=destfile)

  bfs_nr_kt <- "je-d-21.03.02"

  asset_number_kt <- get_bfs_asset_nr(bfs_nr_kt)

  destfile2<-"temp/bfs_kantone.xlsx"
  download.file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",asset_number_kt,"/master"),destfile=destfile2)

  if(check_changes_in_input_file(destfile)|check_changes_in_input_file(destfile2)|flag_force_update){
    if(flag_force_update) print("flag_force_update") else print("Changes found")
    # 1. communal area data
    df<-read.xlsx(destfile,1,startRow=6,header=T) %>% janitor::clean_names()
    year_value<-df$gesamtflache_in_km_1[1]
    df<-df[3:nrow(df),]

    df$gemeindecode[1]<-0
    new_df<-df[,c("gesamtflache_in_km_1","gemeindecode")]

    colnames(new_df)[colnames(new_df)=="gesamtflache_in_km_1"]<-"value"
    colnames(new_df)[colnames(new_df)=="gemeindecode"]<-"spatialunit_id"
    new_df$time_value<-year_value

    # 2. cantonal area data
    df2<-read.xlsx(destfile2,1,startRow=36,header=T) %>% janitor::clean_names()
    df2<-df2[1,]
    #check
    if(substr(df2[1,1],1,12)!="Fläche in km") stop("Error: Excel-File seems not to be OK")
    year_value<-as.numeric(df2[1,2])
    df2<-df2[,4:29]
    df2<-as.data.frame(t(df2))
    colnames(df2)<-c("value")
    df2$spatialunit_id<-seq(10000,260000,by=10000)
    df2$time_value<-year_value

    new_df<-bring_indicator_values_to_order(new_df)
    df2<-bring_indicator_values_to_order(df2)
    new_df<-rbind(new_df,df2)

    new_df$indicator_id<-32001
    new_df$timeinfo_id<-1
    new_df<-fill_dimensions_with_na(new_df,value_id=TRUE)

    new_df<-bring_indicator_values_to_order(new_df,final_length=T)

    write.csv(new_df,"data/values/32001_CH.csv",row.names = F)
    update_last_updated(32001)


    return("UPDATE OK")
  }else{
    print("No changes found")
    return("UP-TO-DATE")
  }
}
