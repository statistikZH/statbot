library(tidyverse)

df<-read.csv("hackathon_hackzurich/input_data/EN_INDICATOR_VALUES.csv")

dim(df)

make_changes<-function(temp_df,indicator_one,indicator_two,new_indicator){
  df_part<-temp_df[temp_df$INDICATOR_ID %in% c( indicator_one,indicator_two),]
  print(paste0("DIM BEFORE MERGE: ",dim(df_part)))
  df_part_out<-df_part %>% group_by(SPATIALUNIT_ID,YEAR) %>%  summarize(VALUE=sum(VALUE))
  print(paste0("DIM AFTER MERGE: ",dim(df_part)))
  df_part_out$INDICATOR_ID<-new_indicator
  df_part_out$VALUE_ADDITION<-NA
  df_part_out$CAT<-format(Sys.time(), "%d.%m.%y %H:%M")
  return(df_part_out)
}


one<-make_changes(df,611,612,996)

two<-make_changes(df,606,607,997)
length_checker<-nrow(one)+nrow(two)+nrow(df)
df<-rbind(df,one,two)
dim(df)
ifelse(length_checker==nrow(df),"CHECK PASSED","CHECK NOT PASSED")

write.csv(df,"hackathon_hackzurich/input_data/EN_INDICATOR_VALUES.csv",row.names = F)
