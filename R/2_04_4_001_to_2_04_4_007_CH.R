# Version 3.2.0 - 22.02.2022
# History
#
# Version 3.2.0 - 22.02.2022 - First version


# vehicles stock

statbot_src_2_04_4_001_to_2_04_4_007_CH <- function(flag_force_update=FALSE){
  destfile<-"temp/bfs_2_04_4_001_to_2_04_4_007_CH.px"
  download.file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",get_bfs_asset_nr("px-x-1103020100_111"),"/master"),destfile=destfile)



  if(check_changes_in_input_file(destfile)|flag_force_update){
    if(flag_force_update) print("flag_force_update") else print("Changes found")

    df<-statbot_read.px(destfile)

    #extracting first some metadata - added on 06.01.2022
    spatial_reference<-extract_spatial_reference(df$NOTE$value)

    df<-as.data.frame(df)


    df$temp<-stringr::str_locate(pattern =' ',df$Gemeinde)[,1]
    df$spatialunit_current_id<-ifelse(is.na(df$temp),0,as.numeric(substr(df$Gemeinde,0,df$temp)))
    df$spatialunit_ontology<-ifelse(is.na(df$temp),"CH","A.ADM3")
    df$temp<-NULL





    df<-convert_current_to_hist_id(df,reference_point=spatial_reference)

    # this just cleans the ugly name that contains bfs-nr etc. Of course there are other ways to do it :-)
    df$spatialunit_name<-translate_to_spatial_unit_name(df,"de")

    df$time_value<-paste0("31.12.",df$Jahr)
    df$period_value<-NA

    dimension_table <- get_dimensions("fuel")

    df<-df %>% rename(fuel=Treibstoff)
    df<-join_dimension_value(df,"fuel",dimension_table, "de")


    df<-df %>%  select(all_of(GLOBAL_TOTAL_LIST), Fahrzeuggruppe, fuel)



  indicator_input <- tibble(
    indicator_name = unique(df$Fahrzeuggruppe),
    indicator_number = 1:7
  )


  pwalk(indicator_input, ~create_all_aggregations_per_indicator(
    df,
    indicator_col = "Fahrzeuggruppe", ..1, ..2,prefix="2_04_4_")
  )



    return("UPDATE OK")
  }else{
    print("No changes found")
    return("UP-TO-DATE")
  }
}
