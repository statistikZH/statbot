
GLOBAL_MAX_DIM<-6



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
    hash_file$hash[hash_file$file_name==file_name] <- hash
    write.csv(hash_file,"data/hashes.csv",row.names = F)
    return(TRUE)
  }
}


GLOBAL_TOTAL_LIST<-c("spatialunit_ontology","spatialunit_hist_id","spatialunit_name",
                  "time_value","period_value","value")


update_last_updated<-function(id){
  df<-read.csv("data/classes.csv")

  if(length(df$last_updated[df$class_id==id])==0) stop("Error: indicator_id does not match or indicator description is missing.")

  df$last_updated[df$class_id==id]<-Sys.Date()
  write.csv(df,"data/classes.csv",row.names = F)
}

# TODO VERY WRONG
convert_and_write_per_unit<-function(df,new_id,file_name,how_many=1000){
  df$value<-df$value/how_many
  df$indicator_id<-new_id
  write.csv(df,paste0("data/values/",file_name),row.names = F)

}


#TODO HAS TO BE CHECKED AND PUT IN SEPARATE FILE
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
                                                                        dim4_value_id=first(dim4_value_id),.groups="drop")
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
                                                                              dim4_value_id=first(dim4_value_id),.groups="drop")
    temp$SPATIALUNIT_ID.y<-NULL


    df<-rbind(df,temp)

  return(df)



}







