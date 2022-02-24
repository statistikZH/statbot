#' Function do download the dataset with the id: 1_01_016_CH
#'
#' Created by: Christian Ruiz
#' Created at: 2022-02-15
#' Version 3.2.0 - 15.02.2022
#'
#' History
#'
#' Version 3.2.0 - 15.02.2022 - First Version
#'
#' @param flag_force_update To force an update of the Dataset. Default: FALSE
#'
#' @export
statbot_src_1_01_016_CH <- function(flag_force_update=FALSE){
  destfile_w<-"temp/1_01_016_CH_w.px"
  destfile_m<-"temp/1_01_016_CH_m.px"
  download.file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",get_bfs_asset_nr("px-x-0104050000_102"),"/master"),destfile=destfile_w)
  download.file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",get_bfs_asset_nr("px-x-0104050000_101"),"/master"),destfile=destfile_m)
  if(check_changes_in_input_file(destfile)|flag_force_update){
    if(flag_force_update) print("flag_force_update") else print("Changes found")

    df<-statbot_read.px(destfile_w)
    df2<-statbot_read.px(destfile_m)
    #extracting first some metadata
    #I do not think that we need it twice
    spatial_reference<-extract_spatial_reference(df$NOTE$value)


    df<-as.data.frame(df)
    df2<-as.data.frame(df2)
    #df$gender<-2
    #df2$gender<-1
    df<-df %>% rename(first_name_girl=Vorname)
    df2<-df2 %>% rename(first_name_boy=Vorname)

    unique_dimension_names <- c("first_name_girl","first_name_boy")
    dimension_table <- get_dimensions(unique_dimension_names)
    df<-join_dimension_value(df,"first_name_girl",dimension_table, "de")
    df2<-join_dimension_value(df2,"first_name_boy",dimension_table, "de")

    #df<-df %>% rename(first_name=first_name_girl)
    #df2<-df2 %>% rename(first_name=first_name_boy)

    #df<-rbind(df,df2)

    total_df<-df[df$Sprachgebiet...Kanton=="Schweiz",]
    total_df2<-df2[df2$Sprachgebiet...Kanton=="Schweiz",]

    df<-df[as.integer(df$Sprachgebiet...Kanton)>=6,]
    df2<-df2[as.integer(df2$Sprachgebiet...Kanton)>=6,]

    df$spatialunit_hist_id<-convert_cantonal_name_to_current_id(droplevels(df$Sprachgebiet...Kanton),type="easy")
    df2$spatialunit_hist_id<-convert_cantonal_name_to_current_id(droplevels(df2$Sprachgebiet...Kanton),type="easy")

    total_df$spatialunit_hist_id<-0
    df$spatialunit_ontology<-"A.ADM1"
    total_df$spatialunit_ontology<-"CH"
    df$spatialunit_name<-translate_to_spatial_unit_name(df,"de")
    total_df$spatialunit_name<-"Schweiz"
    df<-rbind(df,total_df)

    total_df2$spatialunit_hist_id<-0
    df2$spatialunit_ontology<-"A.ADM1"
    total_df2$spatialunit_ontology<-"CH"
    df2$spatialunit_name<-translate_to_spatial_unit_name(df2,"de")
    total_df2$spatialunit_name<-"Schweiz"
    df2<-rbind(df2,total_df2)


    # this just cleans the ugly name that contains bfs-nr etc. Of course there are other ways to do it :-)

    df$Sprachgebiet...Kanton<-NULL
    df$time_value<-paste0("31.12.",df$Jahr)
    df$period_value<-NA

    df2$Sprachgebiet...Kanton<-NULL
    df2$time_value<-paste0("31.12.",df2$Jahr)
    df2$period_value<-NA


    df<-df %>% select(all_of(GLOBAL_TOTAL_LIST), first_name_girl,Masseinheit)
    df2<- df2 %>% select(all_of(GLOBAL_TOTAL_LIST), first_name_boy,Masseinheit)

    #girls weiblich
    df_rang_w<-df[df$Masseinheit=="Rang",]
    df_rang_w$Masseinheit<-NULL
    df<-df[df$Masseinheit=="Anzahl",]
    df$Masseinheit<-NULL
    #boys maennlich
    df_rang_m<-df2[df2$Masseinheit=="Rang",]
    df_rang_m$Masseinheit<-NULL
    df2<-df2[df2$Masseinheit=="Anzahl",]
    df2$Masseinheit<-NULL



    write.csv(df_rang_w,"data/values/1_01_016_CH.csv",row.names = F)
    update_last_updated("1_01_016")
    write.csv(df_rang_m,"data/values/1_01_017_CH.csv",row.names = F)
    update_last_updated("1_01_017")
    write.csv(df,"data/values/1_01_018_CH.csv",row.names = F)
    update_last_updated("1_01_018")
    write.csv(df2,"data/values/1_01_019_CH.csv",row.names = F)
    update_last_updated("1_01_019")

    #convert_and_write_per_unit(df,"1_01_016_CH.csv",how_many=1000)


    return("UPDATE OK")
  }else{
    return("UP-TO-DATE")
  }
}
