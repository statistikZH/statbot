#' Function do download the dataset with the id: 1_01_006_CH
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
statbot_src_1_01_006_CH <- function(flag_force_update=FALSE){
  destfile<-"temp/1_01_006_CH.px"
  download.file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",get_bfs_asset_nr("px-x-0102020206_102"),"/master"),destfile=destfile)

  if(check_changes_in_input_file(destfile)|flag_force_update){
    if(flag_force_update) print("flag_force_update") else print("Changes found")

    df<-statbot_read.px(destfile)
    #extracting first some metadata
    spatial_reference<-extract_spatial_reference(df$NOTE$value)
    dict_gender<-extract_meta_and_generate_dimensions(df,"Geschlecht",1)
    dict_staat<-extract_meta_and_generate_dimensions(df,"Staatsangehörigkeit..Kategorie.",11)
    dict_civil<-extract_meta_and_generate_dimensions(df,"Zivilstand",12)
    dict_alter<-extract_meta_and_generate_dimensions(df,"Altersklasse",13)

    df<-as.data.frame(df)

    new_names <- c("age_class", "marital_status","citizenship_category","gender","spatialunit_name", "jahr", "value")

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
    df<-merge_to_dict(df,"gender",dict_gender)
    df<-merge_to_dict(df,"age_class",dict_alter)
    df<-merge_to_dict(df,"marital_status",dict_civil)
    df<-merge_to_dict(df,"citizenship_category",dict_staat)
    df<-df %>% select(all_of(GLOBAL_TOTAL_LIST), gender,age_class,marital_status,citizenship_category)

    df<-add_granularity_levels_up(df,list_ontologies=c("A.ADM2","A.ADM1","CH"),list_dimensions=c("gender","age_class","marital_status","citizenship_category"))

    df<-df %>% select(all_of(GLOBAL_TOTAL_LIST), gender,age_class,marital_status,citizenship_category)



    write.csv(df,"data/values/1_01_006_CH.csv",row.names = F)
    update_last_updated("1_01_006")

    #convert_and_write_per_unit(df,"1_01_006_CH.csv",how_many=1000)


    return("UPDATE OK")
  }else{
    return("UP-TO-DATE")
  }
}
