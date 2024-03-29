#' Function do download the dataset with the id: 1_01_027
#'
#' Created by: J. Steiger
#' Created at: 2022-03-14
#'
#' @param flag_force_update To force an update of the Dataset. Default: FALSE
#'
#' @export
statbot_src_1_01_027 <- function(flag_force_update=FALSE){
  destfile<-"temp/1_01_027.csv"
  download.file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",get_bfs_asset_nr("px-x-0102010000_104"),"/master"),destfile=destfile)

   if(check_changes_in_input_file(destfile)|flag_force_update){
     if(flag_force_update) print("flag_force_update") else print("Changes found")


     df<-statbot_read.px(destfile)

     main_language <- extract_main_language(df)

     #extracting first some metadata
     spatial_reference<-extract_spatial_reference(df$NOTE$value)

     df<-as.data.frame(df)

     unique_dimension_names <- c("population_type", "citizenship", "place_of_birth")

     dimension_table <- get_dimensions(unique_dimension_names)

     new_names <- c("citizenship", "place_of_birth","population_type","spatialunit_name","jahr", "value")

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



     df<-join_dimension_value(df,"population_type",dimension_table, main_language)
     df<-join_dimension_value(df,"citizenship",dimension_table, main_language)
     df<-join_dimension_value(df,"place_of_birth",dimension_table, main_language)
     df<-df %>% select(all_of(GLOBAL_TOTAL_LIST), population_type,citizenship,place_of_birth)

     df<-add_granularity_levels_up(df,list_ontologies=c("A.ADM2","A.ADM1","CH"),list_dimensions=c("population_type", "citizenship", "place_of_birth"))

     df<-df %>% select(all_of(GLOBAL_TOTAL_LIST), population_type,citizenship,place_of_birth)


     fwrite(df,"data/values/1_01_027.csv",row.names = F)
     update_last_updated("1_01_027")



    return("UPDATE OK")
   }else{
       return("UP-TO-DATE")
   }
}
