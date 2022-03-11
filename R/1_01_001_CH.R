#' Function do download the dataset with the id: 1_01_001_CH
#'
#' Created by: Jorin Steiger
#' Created at: 2022-02-23
#' Version 3.2.0 - 2022-02-23
#'
#' History
#'
#'
#'
#'
#' @param flag_force_update To force an update of the Dataset. Default: FALSE
#'
#' @export
statbot_src_1_01_001_CH <- function(flag_force_update=FALSE){
  destfile<-"temp/1_01_001_CH.px"
  destfile_hist<-"temp/1_01_001_CH_hist.px"
  download.file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",get_bfs_asset_nr("px-x-0102010000_101"),"/master"),destfile=destfile)
  download.file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",get_bfs_asset_nr("px-x-0102030000_101"),"/master"),destfile=destfile_hist)



  if(check_changes_in_input_file(destfile)|check_changes_in_input_file(destfile_hist)|flag_force_update){
    if(flag_force_update) print("flag_force_update") else print("Changes found")

    df<-statbot_read.px(destfile)
    df_hist <- statbot_read.px(destfile_hist)

    main_language <- extract_main_language(df)
    main_language_hist <- extract_main_language(df_hist)


    #extracting first some metadata
    spatial_reference<-extract_spatial_reference(df$NOTE$value)


    unique_dimension_names <- c("population_type", "citizenship_category", "gender", "age_group_1")

    dimension_table <- get_dimensions(unique_dimension_names)

    # prepare df_hist

    df<-as.data.frame(df)
    df_hist<-as.data.frame(df_hist)

    names(df_hist) <- c("jahr", "age_group_1", "gender", "value")
    df_hist$citizenship_category <- "Staatsangehörigkeit (Kategorie) - Total"
    df_hist$population_type <- "Ständige Wohnbevölkerung"
    df_hist$spatialunit_name <- "Schweiz"
    df_hist$spatialunit_hist_id <- "CH"
    df_hist$spatialunit_ontology <- "CH"


    df_hist$time_value<-paste0("31.12.",df_hist$jahr)
    df_hist$period_value<-NA

    df_hist<-join_dimension_value(df_hist,"gender",dimension_table, main_language_hist)
    df_hist<-join_dimension_value(df_hist,"age_group_1",dimension_table, main_language_hist)
    df_hist<-join_dimension_value(df_hist,"population_type",dimension_table, main_language_hist)
    df_hist<-join_dimension_value(df_hist,"citizenship_category",dimension_table, main_language_hist)
    df_hist<-df_hist %>% select(all_of(GLOBAL_TOTAL_LIST), gender,age_group_1,population_type,citizenship_category)






    ##### from here on @christian you can take over :)
    new_names <- c("age_group_1", "population_type","citizenship_category","gender","spatialunit_name", "jahr", "value")

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


    #theoretically, this could be converted to a function
    df<-join_dimension_value(df,"gender",dimension_table, main_language)
    df<-join_dimension_value(df,"age_group_1",dimension_table, main_language)
    df<-join_dimension_value(df,"population_type",dimension_table, main_language)
    df<-join_dimension_value(df,"citizenship_category",dimension_table, main_language)
    df<-df %>% select(all_of(GLOBAL_TOTAL_LIST), gender,age_group_1,population_type,citizenship_category)

    df<-add_granularity_levels_up(df,list_ontologies=c("A.ADM2","A.ADM1","CH"),list_dimensions=c("gender","age_group_1","population_type","citizenship_category"))

    df<-df %>% select(all_of(GLOBAL_TOTAL_LIST), gender,age_group_1,population_type,citizenship_category)

    df <- df %>% rbind(df_hist)

    fwrite(df,"data/values/1_01_001_CH.csv",row.names = F)
    update_last_updated("1_01_001")

    #convert_and_write_per_unit(df,"1_01_001_CH.csv",how_many=1000)


    return("UPDATE OK")
  }else{
    return("UP-TO-DATE")
  }
}
