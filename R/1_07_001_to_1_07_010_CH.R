# V3.1.0b - 21.12.2021 - First version
# History
#

# buildings cube for EFH, MFH, 2 other categories. Plus calculation of all residential buildings.

# it is one px-file that contains all these four kind of categories.

# Stichtag is 31.12 of that year

statbot_src_1_07_001_to_1_07_010_CH <- function(flag_force_update=FALSE){
  destfile<-"temp/bfs_1_07_001_to_1_07_010_CH.px"
  download.file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",get_bfs_asset_nr("px-x-0902020200_102"),"/master"),destfile=destfile)



  if(check_changes_in_input_file(destfile)|flag_force_update){
    if(flag_force_update) print("flag_force_update") else print("Changes found")

    df<-statbot_read.px(destfile)
    df<-as.data.frame(df)

    # Only keep communes - other granularities will be added up again later
    df$spatialunit_name<-df$Kanton.......Bezirk........Gemeinde.........
    df$Kanton.......Bezirk........Gemeinde.........<-NULL
    df$temp<-stringr::str_locate(pattern ='\\.\\.\\.\\.\\.\\.',df$spatialunit_name)[,1]
    df<-df[!is.na(df$temp),]
    df$temp<-stringr::str_locate(pattern =' ',df$spatialunit_name)[,1]
    df$spatialunit_current_id<-as.numeric(substr(df$spatialunit_name,7,df$temp))
    df$spatialunit_ontology<-"A.ADM3"

    # at the moment the date for the gemeinde validity is: "18.10.2020"
    # while the max year is 2020
    # thus we could hope that this stays always the same
    maximum_year<-max(as.integer(as.character(df$Jahr)))
    reference_point<-paste0("18.10.",maximum_year)



    df<-convert_current_to_hist_id(df,reference_point=reference_point)

    # this just cleans the ugly name that contains bfs-nr etc. Of course there are other ways to do it :-)
    df$spatialunit_name<-translate_to_spatial_unit_name(df,"de")

    df$time_value<-paste0("31.12.",df$Jahr)
    df$period_value<-NA

    i<-1
    for(gebkat in unique(df$Gebäudekategorie)){
      df$temp<-stringr::str_locate(pattern =gebkat,df$Gebäudekategorie)[,1]
      sub_df<-df[!is.na(df$temp),]
      sub_df<-sub_df %>% mutate(rooms = case_when(Anzahl.Zimmer=="1 Zimmer"~1,
                                                  Anzahl.Zimmer=="2 Zimmer"~2,
                                                  Anzahl.Zimmer=="3 Zimmer"~3,
                                                  Anzahl.Zimmer=="4 Zimmer"~4,
                                                  Anzahl.Zimmer=="5 Zimmer"~5,
                                                  Anzahl.Zimmer=="6+ Zimmer"~6,),
                                building_period = case_when(Bauperiode=="Vor 1919"~1,
                                                            Bauperiode=="1919-1945"~2,
                                                            Bauperiode=="1946-1960"~3,
                                                            Bauperiode=="1961-1970"~4,
                                                            Bauperiode=="1971-1980"~5,
                                                            Bauperiode=="1981-1990"~6,
                                                            Bauperiode=="1991-2000"~7,
                                                            Bauperiode=="2001-2005"~8,
                                                            Bauperiode=="2006-2020"~9))


      total_df<-sub_df %>% group_by(spatialunit_hist_id,time_value,building_period) %>%
            summarize(spatialunit_ontology="A.ADM3",value=sum(value),rooms=-1,,spatialunit_name=first(spatialunit_name),period_value=NA)
      total_df<-total_df[,c(GLOBAL_TOTAL_LIST,"rooms","building_period")]
      total2_df<-sub_df %>% group_by(spatialunit_hist_id,time_value,rooms) %>%
        summarize(spatialunit_ontology="A.ADM3",value=sum(value),building_period=-1,,spatialunit_name=first(spatialunit_name),period_value=NA)
      total2_df<-total2_df[,c(GLOBAL_TOTAL_LIST,"rooms","building_period")]

      sub_df<-sub_df[,c(GLOBAL_TOTAL_LIST,"rooms","building_period")]
      sub_df<-rbind(sub_df,total_df,total2_df)

      sub_df<-add_granularity_levels_up(sub_df,list_ontologies=c("A.ADM2","A.ADM1","CH"),list_dimensions=c("rooms","building_period"))

      sub_df<-sub_df[,c(GLOBAL_TOTAL_LIST,"rooms","building_period")]



      write.csv(sub_df,paste0("data/values/1_07_",str_pad(i,3,pad="0"),"_CH.csv"),row.names = F)
      update_last_updated(paste0("1_07_",str_pad(i,3,pad="0")))
      i<-i+1
      #TODO WAITING FOR THE POP-FILE...
      #convert_and_write_per_unit(sub_df,paste0("1_07_",str_pad(i,3,pad="0"),"_CH.csv"),how_many=1000)
      i<-i+1

    }


    sub_df<-df
    sub_df<-sub_df %>% mutate(rooms = case_when(Anzahl.Zimmer=="1 Zimmer"~1,
                                                Anzahl.Zimmer=="2 Zimmer"~2,
                                                Anzahl.Zimmer=="3 Zimmer"~3,
                                                Anzahl.Zimmer=="4 Zimmer"~4,
                                                Anzahl.Zimmer=="5 Zimmer"~5,
                                                Anzahl.Zimmer=="6+ Zimmer"~6,),
                              building_period = case_when(Bauperiode=="Vor 1919"~1,
                                                          Bauperiode=="1919-1945"~2,
                                                          Bauperiode=="1946-1960"~3,
                                                          Bauperiode=="1961-1970"~4,
                                                          Bauperiode=="1971-1980"~5,
                                                          Bauperiode=="1981-1990"~6,
                                                          Bauperiode=="1991-2000"~7,
                                                          Bauperiode=="2001-2005"~8,
                                                          Bauperiode=="2006-2020"~9))


    total_df<-sub_df %>% group_by(spatialunit_hist_id,time_value,building_period) %>%
      summarize(spatialunit_ontology="A.ADM3",value=sum(value),rooms=-1,,spatialunit_name=first(spatialunit_name),period_value=NA)
    total_df<-total_df[,c(GLOBAL_TOTAL_LIST,"rooms","building_period")]
    total2_df<-sub_df %>% group_by(spatialunit_hist_id,time_value,rooms) %>%
      summarize(spatialunit_ontology="A.ADM3",value=sum(value),building_period=-1,,spatialunit_name=first(spatialunit_name),period_value=NA)
    total2_df<-total2_df[,c(GLOBAL_TOTAL_LIST,"rooms","building_period")]

    sub_df<-sub_df[,c(GLOBAL_TOTAL_LIST,"rooms","building_period")]
    sub_df<-rbind(sub_df,total_df,total2_df)

    sub_df<-add_granularity_levels_up(sub_df,list_ontologies=c("A.ADM2","A.ADM1","CH"),list_dimensions=c("rooms","building_period"))

    sub_df<-sub_df[,c(GLOBAL_TOTAL_LIST,"rooms","building_period")]



    write.csv(sub_df,"data/values/1_07_009_CH.csv",row.names = F)
    update_last_updated("1_07_009")
    # TODO: WAITING FOR POP-FILE...
    #convert_and_write_per_unit(sub_df,paste0("1_07_010_CH.csv"),how_many=1000)







    return("UPDATE OK")
  }else{
    print("No changes found")
    return("UP-TO-DATE")
  }
}
