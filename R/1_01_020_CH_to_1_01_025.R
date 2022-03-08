#' Function do download the dataset with the id: 1_01_021_CH
#'
#' Created by: Jorin Steiger
#' Created at: 2022-02-25
#' Version 3.2.0 - 2022-03-08
#'
#' History
#'
#'
#'
#'
#' @param flag_force_update To force an update of the Dataset. Default: FALSE
#'
#' @export
statbot_src_1_01_021_CH <- function(flag_force_update=FALSE){
  destfile<-"temp/1_01_021_CH.px"
  download.file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",get_bfs_asset_nr("px-x-0103010200_121"),"/master"),destfile=destfile)

  if(check_changes_in_input_file(destfile)|flag_force_update){
    if(flag_force_update) print("flag_force_update") else print("Changes found")


    df<-statbot_read.px(destfile)

    main_language <- extract_main_language(df)
    #extracting first some metadata
    spatial_reference<-extract_spatial_reference(df$NOTE$value)

    df<-as.data.frame(df)




    unique_dimension_names <- c("gender","citizenship_selection")
    dimension_table <- get_dimensions(unique_dimension_names)



    ##### from here on @christian you can take over :)
    new_names <- c("variable","gender","citizenship_selection","spatialunit_name", "jahr", "value")

    # Only keep communes - other granularities will be added up again later
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




    #--------------------------------
    #  Einwanderung inkl. Änderung des Bevölkerungstyps

    df$temp<-stringr::str_locate(pattern ='Einwanderung inkl. Änderung des Bevölkerungstyps',df$variable)[,1]
    sub_df<-df[!is.na(df$temp),]

    sub_df <- join_dimension_value(sub_df, 'citizenship_selection', dimension_table, main_language)
    sub_df <- join_dimension_value(sub_df,"gender",dimension_table, main_language)
    sub_df <- sub_df %>% select(all_of(GLOBAL_TOTAL_LIST), gender,citizenship_selection)
    sub_df <- add_granularity_levels_up(sub_df,list_ontologies=c("A.ADM2","A.ADM1","CH"),list_dimensions=c("gender","citizenship_selection"))
    sub_df <- sub_df %>% select(all_of(GLOBAL_TOTAL_LIST), gender,citizenship_selection)



    write.csv(sub_df,"data/values/1_01_020_CH.csv",row.names = F)
    update_last_updated("1_01_020")

    #convert_and_write_per_unit(df,"1_01_001_CH.csv",how_many=1000)



    #--------------------------------
    #  Auswanderung

    df$temp<-stringr::str_locate(pattern ='Auswanderung',df$variable)[,1]
    sub_df<-df[!is.na(df$temp),]

    sub_df <- join_dimension_value(sub_df, 'citizenship_selection', dimension_table, main_language)
    sub_df <- join_dimension_value(sub_df,"gender",dimension_table, main_language)
    sub_df <- sub_df %>% select(all_of(GLOBAL_TOTAL_LIST), gender,citizenship_selection)
    sub_df <- add_granularity_levels_up(sub_df,list_ontologies=c("A.ADM2","A.ADM1","CH"),list_dimensions=c("gender","citizenship_selection"))
    sub_df <- sub_df %>% select(all_of(GLOBAL_TOTAL_LIST), gender,citizenship_selection)



    write.csv(sub_df,"data/values/1_01_021_CH.csv",row.names = F)
    update_last_updated("1_01_021")

    #convert_and_write_per_unit(df,"1_01_001_CH.csv",how_many=1000)



    #--------------------------------
    #  Interkantonaler Zuzug

    df$temp<-stringr::str_locate(pattern ='Interkantonaler Zuzug',df$variable)[,1]
    sub_df<-df[!is.na(df$temp),]

    sub_df <- join_dimension_value(sub_df, 'citizenship_selection', dimension_table, main_language)
    sub_df <- join_dimension_value(sub_df,"gender",dimension_table, main_language)
    sub_df <- sub_df %>% select(all_of(GLOBAL_TOTAL_LIST), gender,citizenship_selection)
    sub_df <- add_granularity_levels_up(sub_df,list_ontologies=c("A.ADM2","A.ADM1","CH"),list_dimensions=c("gender","citizenship_selection"))
    sub_df <- sub_df %>% select(all_of(GLOBAL_TOTAL_LIST), gender,citizenship_selection)



    write.csv(sub_df,"data/values/1_01_022_CH.csv",row.names = F)
    update_last_updated("1_01_022")

    #convert_and_write_per_unit(df,"1_01_001_CH.csv",how_many=1000)



    #--------------------------------
    #  Interkantonaler Wegzug

    df$temp<-stringr::str_locate(pattern ='Interkantonaler Wegzug',df$variable)[,1]
    sub_df<-df[!is.na(df$temp),]

    sub_df <- join_dimension_value(sub_df, 'citizenship_selection', dimension_table, main_language)
    sub_df <- join_dimension_value(sub_df,"gender",dimension_table, main_language)
    sub_df <- sub_df %>% select(all_of(GLOBAL_TOTAL_LIST), gender,citizenship_selection)
    sub_df <- add_granularity_levels_up(sub_df,list_ontologies=c("A.ADM2","A.ADM1","CH"),list_dimensions=c("gender","citizenship_selection"))
    sub_df <- sub_df %>% select(all_of(GLOBAL_TOTAL_LIST), gender,citizenship_selection)



    write.csv(sub_df,"data/values/1_01_023_CH.csv",row.names = F)
    update_last_updated("1_01_023")

    #convert_and_write_per_unit(df,"1_01_001_CH.csv",how_many=1000)



    #--------------------------------
    #  Intrakantonaler Zuzug

    df$temp<-stringr::str_locate(pattern ='Intrakantonaler Zuzug',df$variable)[,1]
    sub_df<-df[!is.na(df$temp),]

    sub_df <- join_dimension_value(sub_df, 'citizenship_selection', dimension_table, main_language)
    sub_df <- join_dimension_value(sub_df,"gender",dimension_table, main_language)
    sub_df <- sub_df %>% select(all_of(GLOBAL_TOTAL_LIST), gender,citizenship_selection)
    sub_df <- add_granularity_levels_up(sub_df,list_ontologies=c("A.ADM2","A.ADM1","CH"),list_dimensions=c("gender","citizenship_selection"))
    sub_df <- sub_df %>% select(all_of(GLOBAL_TOTAL_LIST), gender,citizenship_selection)



    write.csv(sub_df,"data/values/1_01_024_CH.csv",row.names = F)
    update_last_updated("1_01_024")

    #convert_and_write_per_unit(df,"1_01_001_CH.csv",how_many=1000)



    #--------------------------------
    #  Intrakantonaler Wegzug

    df$temp<-stringr::str_locate(pattern ='Intrakantonaler Wegzug',df$variable)[,1]
    sub_df<-df[!is.na(df$temp),]

    sub_df <- join_dimension_value(sub_df, 'citizenship_selection', dimension_table, main_language)
    sub_df <- join_dimension_value(sub_df,"gender",dimension_table, main_language)
    sub_df <- sub_df %>% select(all_of(GLOBAL_TOTAL_LIST), gender,citizenship_selection)
    sub_df <- add_granularity_levels_up(sub_df,list_ontologies=c("A.ADM2","A.ADM1","CH"),list_dimensions=c("gender","citizenship_selection"))
    sub_df <- sub_df %>% select(all_of(GLOBAL_TOTAL_LIST), gender,citizenship_selection)



    write.csv(sub_df,"data/values/1_01_025_CH.csv",row.names = F)
    update_last_updated("1_01_025")

    #convert_and_write_per_unit(df,"1_01_001_CH.csv",how_many=1000)




    return("UPDATE OK")
  }else{
    return("UP-TO-DATE")
  }
}
