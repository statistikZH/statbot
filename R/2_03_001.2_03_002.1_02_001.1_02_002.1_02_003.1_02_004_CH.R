# V3.1.1b - 06.01.22 - Now with cantons, spatial reference
# History
# V3.1.0b - 21.12.2021 - Changing the totals to -1 instead of 0
# V3.0.2 - 21.12.2021 - according to V3

# includes arbeitsstaette, beschaeftigte and VZAE

# this file only contains swiss and communal data
# thus no bezirks or cantonal data

# it is one px-file that contains all these three kind of data

# Stichtag is 31.12 of that year (actually FSO talks about reference period December)

statbot_src_2_03_001.2_03_002.1_02_001.1_02_002.1_02_003.1_02_004_CH <- function(flag_force_update=FALSE){
  destfile<-"temp/bfs_2_03_001-2_03_002-1_02_001-1_02_002-1_02_003-1_02_004_CH.px"
  destfile2<-"temp/bfs_2_03_001-2_03_002-1_02_001-1_02_002-1_02_003-1_02_004_KANTONE.px"
  download.file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",get_bfs_asset_nr("px-x-0602010000_102"),"/master"),destfile=destfile)
  download.file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",get_bfs_asset_nr("px-x-0602010000_108"),"/master"),destfile=destfile2)



  if(check_changes_in_input_file(destfile)|check_changes_in_input_file(destfile2)|flag_force_update){
    if(flag_force_update) print("flag_force_update") else print("Changes found")

    df<-statbot_read.px(destfile)
    #extracting first some metadata - added on 06.01.2022
    spatial_reference<-extract_spatial_reference(df$NOTE$value)
    df<-as.data.frame(df)
    df_kantone<-statbot_read.px(destfile2)
    df_kantone<-as.data.frame(df_kantone)


    # if switzerland then ID=0 and ontology=CH otherwise ID=BFS-NR and ontology=A.ADM.3
    df$temp<-stringr::str_locate(pattern =' ',df$Gemeinde)[,1]
    df$spatialunit_current_id<-ifelse(is.na(df$temp),0,as.numeric(substr(df$Gemeinde,0,df$temp)))
    df$spatialunit_ontology<-ifelse(is.na(df$temp),"CH","A.ADM3")
    df$temp<-NULL

    # eliminate switzerland from the file with the cantons and arrange levels
    df_kantone<-df_kantone[df_kantone$Kanton!="Schweiz",]
    df_kantone<-df_kantone %>% group_by(Beobachtungseinheit,Wirtschaftssektor,Kanton,Jahr) %>% summarize(value=sum(value,na.rm=T))
    df_kantone$Kanton<-droplevels(df_kantone$Kanton)
    df_kantone$spatialunit_current_id<-convert_cantonal_name_to_current_id(df_kantone$Kanton)
    df_kantone$spatialunit_ontology<-"A.ADM1"

    df_kantone<-rename(df_kantone,Variable=Beobachtungseinheit,Gemeinde=Kanton)
    df$Variable<-ifelse(df$Variable=="Institutionelle Einheiten","Arbeitsstätten",df$Variable)


    #merge kantone and other file
    df<-rbind(df,df_kantone)





    df<-convert_current_to_hist_id(df,reference_point=spatial_reference)

    # this just cleans the ugly name that contains bfs-nr etc. Of course there are other ways to do it :-)
    df<- df %>% rename(spatialunit_name=Gemeinde)
    df$spatialunit_name<-translate_to_spatial_unit_name(df,"de")

    df$time_value<-paste0("31.12.",df$Jahr)
    df$period_value<-NA








    # Beschäftigte

    df$temp<-stringr::str_locate(pattern ='Beschäftigte',df$Variable)[,1]
    sub_df<-df[!is.na(df$temp),]
    sub_df<-sub_df %>% mutate(gender = case_when(Variable=="Beschäftigte"~-1,
                                             Variable=="Beschäftigte Männer"~1,
                                             Variable=="Beschäftigte Frauen"~2),
                              economic_sector = case_when(Wirtschaftssektor=="Wirtschaftssektor - Total"~-1,
                                                        Wirtschaftssektor=="Primärsektor"~1,
                                                        Wirtschaftssektor=="Sekundärer Sektor"~2,
                                                        Wirtschaftssektor=="Tertiärer Sektor"~3))



    sub_df<-sub_df[,c(GLOBAL_TOTAL_LIST,"gender","economic_sector")]

    #sub_df<-add_granularity_levels_up(sub_df,list_ontologies=c("A.ADM2","A.ADM1","CH"),list_dimensions=c("gender","economic_sector"))

    sub_df<-sub_df[,c(GLOBAL_TOTAL_LIST,"gender","economic_sector")]


    write.csv(sub_df,"data/values/1_02_001_CH.csv",row.names = F)
    update_last_updated("1_02_001")

    #convert_and_write_per_unit(sub_df,"1_02_002_CH.csv",how_many=1000)

    # VZAE

    df$temp<-stringr::str_locate(pattern ='Vollzeitäquivalente',df$Variable)[,1]
    sub_df<-df[!is.na(df$temp),]
    sub_df<-sub_df %>% mutate(gender = case_when(Variable=="Vollzeitäquivalente"~-1,
                                                        Variable=="Vollzeitäquivalente Männer"~1,
                                                        Variable=="Vollzeitäquivalente Frauen"~2),
                              economic_sector = case_when(Wirtschaftssektor=="Wirtschaftssektor - Total"~-1,
                                                        Wirtschaftssektor=="Primärsektor"~1,
                                                        Wirtschaftssektor=="Sekundärer Sektor"~2,
                                                        Wirtschaftssektor=="Tertiärer Sektor"~3))



    sub_df<-sub_df[,c(GLOBAL_TOTAL_LIST,"gender","economic_sector")]

    #sub_df<-add_granularity_levels_up(sub_df,list_ontologies=c("A.ADM2","A.ADM1","CH"),list_dimensions=c("gender","economic_sector"))

    sub_df<-sub_df[,c(GLOBAL_TOTAL_LIST,"gender","economic_sector")]



    write.csv(sub_df,"data/values/1_02_003_CH.csv",row.names = F)
    update_last_updated("1_02_003")

    #convert_and_write_per_unit(sub_df,"1_02_004_CH.csv",how_many=1000)

    # Arbeitsstaette

    df$temp<-stringr::str_locate(pattern ='Arbeitsstätten',df$Variable)[,1]
    sub_df<-df[!is.na(df$temp),]
    sub_df<-sub_df %>% mutate(economic_sector = case_when(Wirtschaftssektor=="Wirtschaftssektor - Total"~-1,
                                                        Wirtschaftssektor=="Primärsektor"~1,
                                                        Wirtschaftssektor=="Sekundärer Sektor"~2,
                                                        Wirtschaftssektor=="Tertiärer Sektor"~3))



    sub_df<-sub_df[,c(GLOBAL_TOTAL_LIST,"economic_sector")]

    #sub_df<-add_granularity_levels_up(sub_df,list_ontologies=c("A.ADM2","A.ADM1","CH"),list_dimensions=c("economic_sector"))

    sub_df<-sub_df[,c(GLOBAL_TOTAL_LIST,"economic_sector")]

    write.csv(sub_df,"data/values/2_03_001_CH.csv",row.names = F)
    update_last_updated("2_03_001")
    #convert_and_write_per_unit(sub_df,"2_03_002_CH.csv",how_many=1000)


    return("UPDATE OK")
  }else{
    print("No changes found")
    return("UP-TO-DATE")
  }
}
