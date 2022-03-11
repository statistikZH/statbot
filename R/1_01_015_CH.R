#' Function do download the dataset with the id: 1_01_015_CH
#'
#' Created by: Christian Ruiz
#' Created at: 2022-03-11
#' Version 3.2.0 - 2022-02-22
#'
#' History
#'
#'
#'
#'
#' @param flag_force_update To force an update of the Dataset. Default: FALSE
#'
#' @export
statbot_src_1_01_015_CH <- function(flag_force_update=FALSE){
  destfile<-"temp/1_01_015_CH.px"
  download_bfs_file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",get_bfs_asset_nr("px-x-0102020204_112"),"/master"),destfile=destfile)

  if(check_changes_in_input_file(destfile)|flag_force_update){
    if(flag_force_update) print("flag_force_update") else print("Changes found")

    df<-statbot_read.px(destfile)

    main_language <- extract_main_language(df)
    #extracting first some metadata
    spatial_reference<-extract_spatial_reference(df$NOTE$value)


    df<-as.data.frame(df)

    unique_dimension_names <- c("demographic_characteristic_stillbirth", "gender_of_child_stillbirth")

    dimension_table <- get_dimensions(unique_dimension_names)

    ##### from here on @christian you can take over :)
    new_names <- c("gender_of_child_stillbirth","demographic_characteristic_stillbirth", "jahr", "value")

    # Only keep communes - other granularities will be added up again later
    names(df) <- new_names


    df$spatialunit_current_id<-0
    df$spatialunit_ontology<-"CH"

    df$spatialunit_hist_id<-0

    # this just cleans the ugly name that contains bfs-nr etc. Of course there are other ways to do it :-)
    df$spatialunit_name<-"Schweiz"

    df$time_value<-paste0("31.12.",df$jahr)
    df$period_value<-NA


    #theoretically, this could be converted to a function
    df<-join_dimension_value(df,"gender_of_child_stillbirth",dimension_table, main_language)
    df<-join_dimension_value(df,"demographic_characteristic_stillbirth",dimension_table, main_language)
    df<-df %>% select(all_of(GLOBAL_TOTAL_LIST), gender_of_child_stillbirth,demographic_characteristic_stillbirth)


    write.csv(df,"data/values/1_01_015_CH.csv",row.names = F)
    update_last_updated("1_01_015")

    #convert_and_write_per_unit(df,"1_01_015_CH.csv",how_many=1000)


    return("UPDATE OK")
  }else{
    return("UP-TO-DATE")
  }
}
