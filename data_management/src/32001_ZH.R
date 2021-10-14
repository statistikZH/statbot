source("helper.R")


#consists of communal (+swiss total) and of cantonal areas

statbot_src_32001_ZH <- function(flag_force_update=FALSE){

  source("sql/32001_ZH.R")
  new_df<-statbot_sql_32001_ZH()

  new_df$indicator_id<-32001
  new_df$timeinfo_id<-1
  new_df$dim1_value_id<-NA
  new_df$dim2_value_id<-NA
  new_df$dim3_value_id<-NA
  new_df$dim4_value_id<-NA

  new_df<-bring_indicator_values_to_order(new_df,final_length=T)

  write.csv(new_df,"data/values/32001_ZH.csv",row.names = F)


  return("UPDATE OK")

}
