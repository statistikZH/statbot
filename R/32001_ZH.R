
#consists of communal (+swiss total) and of cantonal areas

statbot_src_32001_ZH <- function(flag_force_update=FALSE){

  source("sql/32001_ZH.R")
  new_df<-statbot_sql_32001_ZH()

  new_df$indicator_id<-32001
  new_df$timeinfo_id<-1
  new_df<-fill_dimensions_with_na(new_df,value_id=TRUE)

  new_df<-bring_indicator_values_to_order(new_df,final_length=T)

  write.csv(new_df,"data/values/32001_ZH.csv",row.names = F)
  update_last_updated(32001)


  return("UPDATE OK")

}
