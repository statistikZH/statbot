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
  download.file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",get_bfs_asset_nr("px-x-0102010000_101"),"/master"),destfile=destfile)
  options(timeout=600)
  if(check_changes_in_input_file(destfile)|flag_force_update){
    if(flag_force_update) print("flag_force_update") else print("Changes found")

    df<-statbot_read.px(destfile)

    main_language <- extract_main_language(df)
    #extracting spatial reference from metadata
    spatial_reference<-extract_spatial_reference(df$NOTE$value)

    df<-as.data.frame(df)

    unique_dimension_names <- c("age_group_1","population_type", "citizenship_category", "gender" )

    dimension_table <- get_dimensions(unique_dimension_names)

    # Only keep communes - other granularities will be added up again later
    names(df) <- c(unique_dimension_names,"spatialunit_name", "jahr", "value")

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


    for(i in unique_dimension_names) df<-join_dimension_value(df,i,dimension_table, main_language)


    df<-df %>% select(all_of(GLOBAL_TOTAL_LIST), all_of(unique_dimension_names))

    df<-add_granularity_levels_up(df,list_ontologies=c("A.ADM2","A.ADM1","CH"),list_dimensions=unique_dimension_names)

    df<-df %>% select(all_of(GLOBAL_TOTAL_LIST), all_of(unique_dimension_names))



    fwrite(df,"data/values/1_01_001_CH.csv",row.names = F)
    update_last_updated("1_01_001")

    #convert_and_write_per_unit(df,"1_01_001_CH.csv",how_many=1000)


    return("UPDATE OK")
  }else{
    return("UP-TO-DATE")
  }
}
