#' Function do download the dataset with the id: 1_01_011_CH
#'
#' Created by: Christian Ruiz
#' Created at: 2022-03-09
#' Version 3.2.0 - 09.03.2022
#'
#' History
#'
#' Version 3.2.0 - 09.03.2022 - First version copied from 1_01_011
#'
#' @param flag_force_update To force an update of the Dataset. Default: FALSE
#'
#' @export
statbot_src_1_01_011_CH <- function(flag_force_update=FALSE){
  destfile<-"temp/1_01_011_CH.px"
  download.file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",get_bfs_asset_nr("px-x-0102020203_104"),"/master"),destfile=destfile)

  if(check_changes_in_input_file(destfile)|flag_force_update){
    if(flag_force_update) print("flag_force_update") else print("Changes found")

    df<-statbot_read.px(destfile)
    #extracting first some metadata
    spatial_reference<-extract_spatial_reference(df$NOTE$value)

    df<-as.data.frame(df)

    new_names <- c("age_class_wife", "age_class_husband", "duration_of_marriage","spatialunit_name", "jahr", "value")

    # Only keep communes - other granularities will be added up again later
    names(df) <- new_names

    total_df<-df[df$spatialunit_name=="Schweiz",]
    df<-df[df$spatialunit_name!="Schweiz",]

    df$spatialunit_hist_id<-convert_cantonal_name_to_current_id(droplevels(df$spatialunit_name),type="easy")
    df$spatialunit_current_id<-df$spatialunit_hist_id
    df$spatialunit_ontology<-"A.ADM1"

    # this just cleans the ugly name that contains bfs-nr etc. Of course there are other ways to do it :-)
    df$spatialunit_name<-translate_to_spatial_unit_name(df,"de")

    total_df$spatialunit_hist_id<-0
    total_df$spatialunit_current_id<-0
    total_df$spatialunit_ontology<-"CH"

    df<-rbind(total_df,df)

    df$time_value<-paste0("31.12.",df$jahr)
    df$period_value<-NA

    unique_dimension_names <- c("age_class_wife","age_class_husband","duration_of_marriage")
    dimension_table <- get_dimensions(unique_dimension_names)
    main_language<-"de"
    df<-join_dimension_value(df,"age_class_wife",dimension_table, main_language)
    df<-join_dimension_value(df,"age_class_husband",dimension_table, main_language)
    df<-join_dimension_value(df,"duration_of_marriage",dimension_table, main_language)

    df<-df %>% select(all_of(GLOBAL_TOTAL_LIST), age_class_wife, age_class_husband,duration_of_marriage)


    write.csv(df,"data/values/1_01_011_CH.csv",row.names = F)
    update_last_updated("1_01_011")

    #convert_and_write_per_unit(df,"1_01_011_CH.csv",how_many=1000)


    return("UPDATE OK")
  }else{
    return("UP-TO-DATE")
  }
}
