# last update 21.12.2021 - according to V3

# includes arbeitsstaette, beschaeftigte and VZAE

# this file only contains swiss and communal data
# thus no bezirks or cantonal data

# it is one px-file that contains all these three kind of data

# Stichtag is 31.12 of that year (actually FSO talks about reference period December)

statbot_src_2_03_001.2_03_002.1_02_001.1_02_002.1_02_003.1_02_004_CH <- function(flag_force_update=FALSE){
  destfile<-"temp/bfs_2_03_001-2_03_002-1_02_001-1_02_002-1_02_003-1_02_004_CH.px"
  download.file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",get_bfs_asset_nr("px-x-0602010000_102"),"/master"),destfile=destfile)



  if(check_changes_in_input_file(destfile)|flag_force_update){
    if(flag_force_update) print("flag_force_update") else print("Changes found")

    df<-statbot_read.px(destfile)
    df<-as.data.frame(df)

    # if switzerland then ID=0 and ontology=CH otherwise ID=BFS-NR and ontology=A.ADM.3
    df$temp<-stringr::str_locate(pattern =' ',df$Gemeinde)[,1]
    df$spatialunit_current_id<-ifelse(is.na(df$temp),0,as.numeric(substr(df$Gemeinde,0,df$temp)))
    df$spatialunit_ontology<-ifelse(is.na(df$temp),"CH","A.ADM3")

    # at the moment the date for the gemeinde validity is: "1.1.2019"
    # while the max year is 2019
    # thus we could hope that this stays always the same
    maximum_year<-max(as.integer(as.character(df$Jahr)))
    reference_point<-paste0("1.1.",maximum_year)



    df$spatialunit_hist_id<-convert_current_to_hist_id(df,reference_point=reference_point)

    df$time_value<-paste0("31.12.",df$Jahr)
    df$period_value<-NA

    df<- df %>% rename(spatialunit_name=Gemeinde)






    # Beschäftigte

    df$temp<-stringr::str_locate(pattern ='Beschäftigte',df$Variable)[,1]
    sub_df<-df[!is.na(df$temp),]
    sub_df<-sub_df %>% mutate(gender = case_when(Variable=="Beschäftigte"~0,
                                             Variable=="Beschäftigte Männer"~1,
                                             Variable=="Beschäftigte Frauen"~2),
                              economic_sector = case_when(Wirtschaftssektor=="Wirtschaftssektor - Total"~0,
                                                        Wirtschaftssektor=="Primärsektor"~1,
                                                        Wirtschaftssektor=="Sekundärer Sektor"~2,
                                                        Wirtschaftssektor=="Tertiärer Sektor"~3))


    sub_df$indicator_id<-"1_02_001"

    sub_df<-sub_df[,c(GLOBAL_TOTAL_LIST,"gender","economic_sector")]

    #TODO
    #sub_df<-zh_add_regions_bezirke(sub_df)


    write.csv(sub_df,"data/values/1_02_001_CH.csv",row.names = F)
    update_last_updated("1_02_001")

    convert_and_write_per_unit(sub_df,"1_02_002","1_02_002_CH.csv",how_many=1000)

    # VZAE

    df$temp<-stringr::str_locate(pattern ='Vollzeitäquivalente',df$Variable)[,1]
    sub_df<-df[!is.na(df$temp),]
    sub_df<-sub_df %>% mutate(gender = case_when(Variable=="Vollzeitäquivalente"~0,
                                                        Variable=="Vollzeitäquivalente Männer"~1,
                                                        Variable=="Vollzeitäquivalente Frauen"~2),
                              economic_sector = case_when(Wirtschaftssektor=="Wirtschaftssektor - Total"~0,
                                                        Wirtschaftssektor=="Primärsektor"~1,
                                                        Wirtschaftssektor=="Sekundärer Sektor"~2,
                                                        Wirtschaftssektor=="Tertiärer Sektor"~3))


    sub_df$indicator_id<-"1_02_003"

    sub_df<-sub_df[,c(GLOBAL_TOTAL_LIST,"gender","economic_sector")]

    #TODO
    #sub_df<-zh_add_regions_bezirke(sub_df)

    write.csv(sub_df,"data/values/1_02_003_CH.csv",row.names = F)
    update_last_updated("1_02_003")

    convert_and_write_per_unit(sub_df,"1_02_004","1_02_004_CH.csv",how_many=1000)

    # Arbeitsstaette

    df$temp<-stringr::str_locate(pattern ='Arbeitsstätten',df$Variable)[,1]
    sub_df<-df[!is.na(df$temp),]
    sub_df<-sub_df %>% mutate(economic_sector = case_when(Wirtschaftssektor=="Wirtschaftssektor - Total"~0,
                                                        Wirtschaftssektor=="Primärsektor"~1,
                                                        Wirtschaftssektor=="Sekundärer Sektor"~2,
                                                        Wirtschaftssektor=="Tertiärer Sektor"~3))


    sub_df$indicator_id<-"2_03_001"

    sub_df<-sub_df[,c(GLOBAL_TOTAL_LIST,"economic_sector")]

    #TODO: HAS TO BE MODIFIED
    #sub_df<-zh_add_regions_bezirke(sub_df)

    write.csv(sub_df,"data/values/2_03_001_CH.csv",row.names = F)
    update_last_updated("2_03_001")
    convert_and_write_per_unit(sub_df,"2_03_002","2_03_002_CH.csv",how_many=1000)


    return("UPDATE OK")
  }else{
    print("No changes found")
    return("UP-TO-DATE")
  }
}
