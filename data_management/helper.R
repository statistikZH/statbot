check_changes_in_input_file<-function(file_name){
  hash<-tools::md5sum(file_name)
  if(is.na(hash)) stop("Error: Could not build a md5sum")
  hash_file<-read.csv("data/hashes.csv")
  selected_hash<-hash_file$hash[hash_file$file_name==file_name]
  if(!is.character(selected_hash)) selected_hash<-"NO"
  if(length(selected_hash)==0) selected_hash<-"NO"
  if(selected_hash==hash){
    #no change
    return(FALSE)
  }else{
    #change occured
    new_line<-data.frame(file_name=file_name,hash=hash)
    hash_file<-rbind(hash_file,new_line)
    write.csv(hash_file,"data/hashes.csv",row.names = F)
    return(TRUE)
  }
}

global_total_list<-c("indicator_id","spatialunit_id","time_value","timeinfo_id",
                     "value","dim1_value_id","dim2_value_id","dim3_value_id","dim4_value_id")

bring_indicator_values_to_order<-function(df, final_length=F){

  if(sum(names(df) %in% global_total_list)<length(names(df))) stop("Error: invalid var-name(s)")

  list_to_select<-global_total_list[global_total_list %in% names(df)]
  if(final_length&length(list_to_select)!=length(global_total_list)) stop(paste0("Error: Amount of cols incorrect: ",length(list_to_select)," instead of ",length(global_total_list),"."))
  if(length(list_to_select)<length(global_total_list)) print("Info: Subset selected")

  return(df[,list_to_select])
}

update_last_updated<-function(id){
  df<-read.csv("data/indicators.csv")

  if(length(df$last_updated[df$indicator_id==id])==0) stop("Error: indicator_id does not match or indicator description is missing.")

  df$last_updated[df$indicator_id==id]<-Sys.Date()
  write.csv(df,"data/indicators.csv",row.names = F)
}

convert_and_write_per_unit<-function(df,new_id,file_name,how_many=1000){
  df$value<-df$value/how_many
  df$indicator_id<-new_id
  write.csv(df,paste0("data/values/",file_name),row.names = F)

}

zh_add_regions_bezirke<-function(df){
  zh<-read.csv("data/old_spatialunits.csv")
  zh_com<-zh[zh$TYPE_ID %in% c(1,9),c("SPATIALUNIT_ID","REGION_ID")]
  zh_reg<-zh[zh$TYPE_ID==4,c("SPATIALUNIT_ID","REGION_ID")]
  zh_reg$SPATIALUNIT_ID<-zh_reg$SPATIALUNIT_ID+010000
  zh_reg<-merge(zh_com,zh_reg,by="REGION_ID")

  temp<-merge(df,zh_reg,by.x="spatialunit_id",by.y="SPATIALUNIT_ID.x")
    temp<-temp %>% group_by(SPATIALUNIT_ID.y,time_value) %>% dplyr::summarize(value=sum(value,na.rm=T),

                                                                        spatialunit_id=first(SPATIALUNIT_ID.y),
                                                                        indicator_id=first(indicator_id),
                                                                        timeinfo_id=first(timeinfo_id),
                                                                        dim1_value_id=first(dim1_value_id),
                                                                        dim2_value_id=first(dim2_value_id),
                                                                        dim3_value_id=first(dim3_value_id),
                                                                        dim4_value_id=first(dim4_value_id))
    temp$SPATIALUNIT_ID.y<-NULL


    df<-rbind(df,temp)

    # bezirke

    zh_com<-zh[zh$TYPE_ID %in% c(1,9),c("SPATIALUNIT_ID","DISTRICT_ID")]
    zh_reg<-zh[zh$TYPE_ID==4,c("SPATIALUNIT_ID","DISTRICT_ID")]
    zh_reg$SPATIALUNIT_ID<-zh_reg$SPATIALUNIT_ID+010000
    zh_reg<-merge(zh_com,zh_reg,by="DISTRICT_ID")

    temp<-merge(df,zh_reg,by.x="spatialunit_id",by.y="SPATIALUNIT_ID.x")
    temp<-temp %>% group_by(SPATIALUNIT_ID.y,time_value) %>% dplyr::summarize(value=sum(value,na.rm=T),

                                                                              spatialunit_id=first(SPATIALUNIT_ID.y),
                                                                              indicator_id=first(indicator_id),
                                                                              timeinfo_id=first(timeinfo_id),
                                                                              dim1_value_id=first(dim1_value_id),
                                                                              dim2_value_id=first(dim2_value_id),
                                                                              dim3_value_id=first(dim3_value_id),
                                                                              dim4_value_id=first(dim4_value_id))
    temp$SPATIALUNIT_ID.y<-NULL


    df<-rbind(df,temp)

  return(df)



}
