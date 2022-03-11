#' Function do download the dataset with the id: 1_01_026_CH
#'
#' Created by: J.Steiger
#' Created at: 2022-03-09
#'
#' @param flag_force_update To force an update of the Dataset. Default: FALSE
#'
#' @export
statbot_src_1_01_026_CH <- function(flag_force_update=FALSE){
  destfile<-"temp/1_01_026_CH.csv"
  download.file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",get_bfs_asset_nr("px-x-0105090000_102"),"/master"),destfile=destfile)


   if(check_changes_in_input_file(destfile)|flag_force_update){
     if(flag_force_update) print("flag_force_update") else print("Changes found")

      df<-statbot_read.px(destfile)

      main_language <- extract_main_language(df)
      #extracting first some metadata
      spatial_reference<-extract_spatial_reference(df$NOTE$value)

      df<-as.data.frame(df)


      # Jahr, Bürgerrecht, Geschlecht und Altersklasse

      unique_dimension_names <- c("citizenship_status", "age_group_minor_adults_senior", "state_of_residence", "gender")
      dimension_table <- get_dimensions(unique_dimension_names)

      df$spatialunit_name = "Schweiz"
      df$spatialunit_ontology<-"CH"


      ##### from here on @christian you can take over :)
      new_names <- c("age_group_minor_adults_senior", "gender", "citizenship_status", "state_of_residence", "jahr", "value", "spatialunit_name", "spatialunit_ontology")

      # Only keep communes - other granularities will be added up again later
      names(df) <- new_names


      df$time_value<-paste0("31.12.",df$jahr)
      df$period_value<-NA


      df <- join_dimension_value(df,'citizenship_status', dimension_table, main_language)
      df <- join_dimension_value(df,"gender",dimension_table, main_language)

      df$state_of_residence <- str_replace(df$state_of_residence, regex(">> [0-9][0-9][0-9][0-9] "), "")
      df$state_of_residence <- str_replace(df$state_of_residence, regex("- "), "")
      df$state_of_residence <- str_replace(df$state_of_residence, regex("\\* "), "")


      df <- join_dimension_value(df,"state_of_residence",dimension_table, main_language)

      df <- join_dimension_value(df,"age_group_minor_adults_senior",dimension_table, main_language)

      df$spatialunit_hist_id<-0


      df <- df %>% select(all_of(GLOBAL_TOTAL_LIST), citizenship_status, gender, state_of_residence, age_group_minor_adults_senior)

      write.csv(df,"data/values/1_01_026_CH.csv",row.names = F)
      update_last_updated("1_01_026")


    return("UPDATE OK")
   }else{
       return("UP-TO-DATE")
   }
}
