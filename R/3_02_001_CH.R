# V3.1.0b - 21.12.2021 - redone version, plus aggregate to bezirke

#consists of communal (+swiss total) and of cantonal areas

statbot_src_3_02_001_CH <- function(flag_force_update=FALSE){

  bfs_nr_gem <- "je-d-21.03.01"

  asset_number_gem <- get_bfs_asset_nr(bfs_nr_gem)

  destfile<-"temp/bfs_gp.xlsx"
  download.file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",asset_number_gem,"/master"),destfile=destfile)

  bfs_nr_kt <- "je-d-21.03.02"

  asset_number_kt <- get_bfs_asset_nr(bfs_nr_kt)

  destfile2<-"temp/bfs_kantone.xlsx"
  download.file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",asset_number_kt,"/master"),destfile=destfile2)

  if(check_changes_in_input_file(destfile)|check_changes_in_input_file(destfile2)|flag_force_update){
    if(flag_force_update) print("flag_force_update") else print("Changes found")
    # 1. communal area data
    df<-read.xlsx(destfile,1,startRow=6,header=T) %>% janitor::clean_names()
    year_value<-df$gesamtflache_in_km_1[1]
    df<-df[3:nrow(df),]

    df$gemeindecode[1]<-0
    new_df<-df[,c("gesamtflache_in_km_1","gemeindecode")]

    colnames(new_df)[colnames(new_df)=="gesamtflache_in_km_1"]<-"value"
    colnames(new_df)[colnames(new_df)=="gemeindecode"]<-"spatialunit_current_id"
    new_df$time_value<-year_value
    new_df$spatialunit_ontology="A.ADM3"
    new_df$spatialunit_ontology[1]="CH"
    new_df$period_value<-NA

    # 2. cantonal area data
    df2<-read.xlsx(destfile2,1,startRow=36,header=T) %>% janitor::clean_names()
    df2<-df2[1,]
    #check
    if(substr(df2[1,1],1,12)!="Fläche in km") stop("Error: Excel-File seems not to be OK")
    year_value<-as.numeric(df2[1,2])
    df2<-df2[,4:29]
    df2<-as.data.frame(t(df2))
    colnames(df2)<-c("value")
    df2$spatialunit_current_id<-seq(1,26)
    df2$time_value<-year_value
    df2$spatialunit_ontology<-"A.ADM1"
    df2$period_value<-NA


    new_df<-rbind(new_df,df2)

    # there are some values that have to be cleaned
    # the warnng of coercing NA's is correct - we want it to produce NAs so that the can be eliminated
    new_df$spatialunit_current_id<-as.integer(new_df$spatialunit_current_id)
    new_df<-new_df[!is.na(new_df$spatialunit_current_id),]



    new_df<-convert_current_to_hist_id(new_df,reference_point = paste0("1.1.",year_value) )

    new_df$time_value<-paste0("1.1.",new_df$time_value)

    new_df$spatialunit_name<-translate_to_spatial_unit_name(new_df,"de")

    new_df$value<-as.integer(new_df$value)

    new_df<-new_df[,c(GLOBAL_TOTAL_LIST)]

    new_df<-add_granularity_levels_up(new_df,list_ontologies=c("A.ADM2"))

    new_df<-new_df[,c(GLOBAL_TOTAL_LIST)]





    write.csv(new_df,"data/values/3_02_001_CH.csv",row.names = F)
    update_last_updated("3_02_001")


    return("UPDATE OK")
  }else{
    print("No changes found")
    return("UP-TO-DATE")
  }
}
