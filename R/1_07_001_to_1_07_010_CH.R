# V3.1.1b - 06.01.2022
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

    #extracting first some metadata - added on 06.01.2022
    spatial_reference<-extract_spatial_reference(df$NOTE$value)

    df<-as.data.frame(df)

    new_names <- c("jahr", "bauperiode", "n_zimmer", "gebaeudekategorie", "spatialunit_name", "value")

    # Only keep communes - other granularities will be added up again later
    #df$spatialunit_name<-df$Kanton.......Bezirk........Gemeinde.........
    #df$Kanton.......Bezirk........Gemeinde.........<-NULL
    names(df) <- new_names

    df$temp<-stringr::str_locate(pattern ='\\.\\.\\.\\.\\.\\.',df$spatialunit_name)[,1]
    df<-df[!is.na(df$temp),]
    df$temp<-stringr::str_locate(pattern =' ',df$spatialunit_name)[,1]
    df$spatialunit_current_id<-as.numeric(substr(df$spatialunit_name,7,df$temp))
    df$spatialunit_ontology<-"A.ADM3"



    df<-convert_current_to_hist_id(df,reference_point=spatial_reference)

    # this just cleans the ugly name that contains bfs-nr etc. Of course there are other ways to do it :-)
    df$spatialunit_name<-translate_to_spatial_unit_name(df,"de")

    df$time_value<-paste0("31.12.",df$jahr)
    df$period_value<-NA


    df <- mutate(df, rooms = case_when(n_zimmer=="1 Zimmer"~1,
                             n_zimmer=="2 Zimmer"~2,
                             n_zimmer=="3 Zimmer"~3,
                             n_zimmer=="4 Zimmer"~4,
                             n_zimmer=="5 Zimmer"~5,
                             n_zimmer=="6+ Zimmer"~6,),
           building_period = case_when(bauperiode=="Vor 1919"~1,
                                       bauperiode=="1919-1945"~2,
                                       bauperiode=="1946-1960"~3,
                                       bauperiode=="1961-1970"~4,
                                       bauperiode=="1971-1980"~5,
                                       bauperiode=="1981-1990"~6,
                                       bauperiode=="1991-2000"~7,
                                       bauperiode=="2001-2005"~8,
                                       bauperiode=="2006-2020"~9)) %>%
      select(all_of(GLOBAL_TOTAL_LIST), gebaeudekategorie, rooms, building_period)



  indicator_input <- tibble(
    indicator_name = unique(df$gebaeudekategorie),
    indicator_number = c(1,3,5,7)
  )

  pwalk(indicator_input, ~create_all_aggregations_per_indicator(
    df,
    indicator_col = "gebaeudekategorie", ..1, ..2)
  )



    return("UPDATE OK")
  }else{
    print("No changes found")
    return("UP-TO-DATE")
  }
}
