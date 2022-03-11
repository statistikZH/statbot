#' Function do download the dataset with the id: 1_01_008_CH
#'
#' Created by: Christian Ruiz
#' Created at: 2022-01-06
#' Version 3.2.0 - 11.03.2022 - Merging with older data
#'
#' History
#'
#' Version 3.2.1 - 11.03.2022 - Merging with older data
#' Version 3.2.0 - 18.02.2022 - new dimensions extraction
#' Version 3.1.2 - 06.01.2022 - First Version
#'
#' @param flag_force_update To force an update of the Dataset. Default: FALSE
#'
#' @export
statbot_src_1_01_008_CH <- function(flag_force_update=FALSE){
  destfile<-"temp/1_01_008_CH.px"
  download.file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",get_bfs_asset_nr("px-x-0102020202_102"),"/master"),destfile=destfile)
  destfile2<-"temp/divorces_longterm.px"
  download.file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",get_bfs_asset_nr("px-x-0102020202_110"),"/master"),destfile=destfile2)

   if(check_changes_in_input_file(destfile)|flag_force_update){
     if(flag_force_update) print("flag_force_update") else print("Changes found")

      df<-statbot_read.px(destfile)
      #extracting first some metadata
      spatial_reference<-extract_spatial_reference(df$NOTE$value)

      df<-as.data.frame(df)

      new_names <- c("citizenship_category_wife", "citizenship_category_husband", "spatialunit_name", "jahr", "value")

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

      # The following is NOT needed with the marriages because
      #the FSO coding is wrong. So it has to be done manually
      #dimension_table <- get_dimensions(unique_dimension_names)
      #df<-join_dimension_value(df,"citizenship_category_wife",dimension_table, main_language)
      #df<-join_dimension_value(df,"citizenship_category_husband",dimension_table, main_language)

      df <- mutate(df, citizenship_category_wife = case_when(citizenship_category_wife=="Staatsangehörigkeit der Ehefrau - Total"~-1,
                                                                citizenship_category_wife=="Schweiz"~1,
                                                                citizenship_category_wife=="Ausland"~2),
                   citizenship_category_husband = case_when(citizenship_category_husband=="Staatsangehörigkeit des Ehemannes - Total"~-1,
                                                            citizenship_category_husband=="Schweiz"~1,
                                                            citizenship_category_husband=="Ausland"~2))


      df<-df %>% select(all_of(GLOBAL_TOTAL_LIST), citizenship_category_wife, citizenship_category_husband)

      df<-add_granularity_levels_up(df,list_ontologies=c("A.ADM2","A.ADM1","CH"),list_dimensions=c("citizenship_category_wife","citizenship_category_husband"))

      df<-df %>% select(all_of(GLOBAL_TOTAL_LIST), citizenship_category_wife, citizenship_category_husband)

      # added on 11.03.2022 to include older data

      df2<-statbot_read.px(destfile2)
      df2<-as.data.frame(df2)

      oldest_year_df<-1969

      df2<-df2[as.numeric(as.character(df2$Jahr))<oldest_year_df&df2$Demografisches.Merkmal.und.Indikator=="Heiraten - Total",]

      df2$Demografisches.Merkmal.und.Indikator<-NULL
      df2<-df2 %>% rename(time_value=Jahr)
      df2$spatialunit_name<-"Schweiz"
      df2$spatialunit_current_id<-0
      df2$spatialunit_hist_id<-0
      df2$spatialunit_ontology<-"CH"
      df2$time_value<-paste0("31.12.",df2$time_value)
      df2$period_value<-NA
      df2$citizenship_category_wife<--1
      df2$citizenship_category_husband<--1

      df2<-df2 %>% select(all_of(GLOBAL_TOTAL_LIST), citizenship_category_wife, citizenship_category_husband)

      df<-rbind(df,df2)
      #end of new code from 09.03.2022


      fwrite(df,"data/values/1_01_008_CH.csv",row.names = F)
      update_last_updated("1_01_008")

      #convert_and_write_per_unit(df,"1_01_008_CH.csv",how_many=1000)


    return("UPDATE OK")
   }else{
       return("UP-TO-DATE")
   }
}
