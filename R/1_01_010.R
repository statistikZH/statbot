#' Function do download the dataset with the id: 1_01_010_CH
#'
#' Created by: Christian Ruiz
#' Created at: 2022-01-06
#' Version 3.1.2 - 06.01.2022
#'
#' History
#'
#' Version 3.1.2 - 06.01.2022 - First Version
#'
#' @param flag_force_update To force an update of the Dataset. Default: FALSE
#'
#' @export
statbot_src_1_01_010_CH <- function(flag_force_update=FALSE){
  destfile<-"temp/1_01_010_CH.px"
  download.file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",get_bfs_asset_nr("px-x-0102020203_103"),"/master"),destfile=destfile)

  if(check_changes_in_input_file(destfile)|flag_force_update){
    if(flag_force_update) print("flag_force_update") else print("Changes found")

    df<-statbot_read.px(destfile)
    #extracting first some metadata
    spatial_reference<-extract_spatial_reference(df$NOTE$value)
    dict_husband<-extract_meta_and_generate_dimensions(df,"Staatsangehörigkeit..Kategorie..des.Ehemannes",8)
    dict_wife<-extract_meta_and_generate_dimensions(df,"Staatsangehörigkeit..Kategorie..der.Ehefrau",9)
    dict_duration<-extract_meta_and_generate_dimensions(df,"Ehedauer",10)


    df<-as.data.frame(df)

    new_names <- c("citizenship_category_of_wife", "citizenship_category_of_husband", "duration_of_marriage","spatialunit_name", "jahr", "value")

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
    df<-merge_to_dict(df,"citizenship_category_of_wife",dict_wife)
    df<-merge_to_dict(df,"citizenship_category_of_husband",dict_husband)
    df<-merge_to_dict(df,"duration_of_marriage",dict_duration)
    df<-df %>% select(all_of(GLOBAL_TOTAL_LIST), citizenship_category_of_wife, citizenship_category_of_husband,duration_of_marriage)

    df<-add_granularity_levels_up(df,list_ontologies=c("A.ADM2","A.ADM1","CH"),list_dimensions=c("citizenship_category_of_wife","citizenship_category_of_husband","duration_of_marriage"))

    df<-df %>% select(all_of(GLOBAL_TOTAL_LIST), citizenship_category_of_wife, citizenship_category_of_husband,duration_of_marriage)



    write.csv(df,"data/values/1_01_010_CH.csv",row.names = F)
    update_last_updated("1_01_010")

    #convert_and_write_per_unit(df,"1_01_010_CH.csv",how_many=1000)


    return("UPDATE OK")
  }else{
    return("UP-TO-DATE")
  }
}
