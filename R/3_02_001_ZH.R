
# specific script for Zurich regions


statbot_src_3_02_001_ZH <- function(flag_force_update=FALSE){
  file_name<-"sql/3_02_001_ZH.R"
  if(!file.exists(file_name)) return("WARNING: Local script 3_02_001_ZH not active")
  source(file_name)
  new_df<-statbot_sql_3_02_001_ZH()

  new_df$time_value<-paste0("1.1.",new_df$time_value)
  new_df$period_value<-NA
  new_df$spatialunit_ontology<-"A.ADM2H"

  new_df$spatialunit_name<-translate_to_spatial_unit_name(new_df,"de")


  new_df<-new_df[,c(GLOBAL_TOTAL_LIST)]


  write.csv(new_df,"data/values/3_02_001_ZH.csv",row.names = F)
  #update_last_updated("3_02_001")


  return("UPDATE OK")

}
