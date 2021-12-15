# includes arbeitsstaette, beschaeftigte and VZAE

statbot_src_2300X_1200X_1210X_CH <- function(flag_force_update=FALSE){
  destfile<-"temp/bfs_2300X_1200X_1210X.px"
  download.file("https://www.bfs.admin.ch/bfsstatic/dam/assets/13787332/master",destfile=destfile)



  if(check_changes_in_input_file(destfile)|flag_force_update){
    if(flag_force_update) print("flag_force_update") else print("Changes found")

    df<-statbot_read.px(destfile)
    df<-as.data.frame(df)

    df$temp<-stringr::str_locate(pattern =' ',df$Gemeinde)[,1]
    df$spatialunit_id<-ifelse(is.na(df$temp),0,as.numeric(substr(df$Gemeinde,0,df$temp)))

    #If you want to have a list of all Swiss communes, then do the following
    #ch<-unique(df[df$spatialunit_id!=0,c("spatialunit_id","Gemeinde","temp")])
    #ch$Gemeinde<-substr(ch$Gemeinde,ch$temp,length(ch$Gemeinde))
    #write.csv(ch[,c("spatialunit_id","Gemeinde")],"data/ch_gemeinden.csv",row.names = F)




    # Beschäftigte

    df$temp<-stringr::str_locate(pattern ='Beschäftigte',df$Beobachtungseinheit)[,1]
    sub_df<-df[!is.na(df$temp),]
    sub_df<-sub_df %>% mutate(dim1_value_id = case_when(Beobachtungseinheit=="Beschäftigte"~0,
                                             Beobachtungseinheit=="Beschäftigte Männer"~1,
                                             Beobachtungseinheit=="Beschäftigte Frauen"~2),
                              dim2_value_id = case_when(Wirtschaftssektor=="Wirtschaftssektor - Total"~0,
                                                        Wirtschaftssektor=="Primärsektor"~1,
                                                        Wirtschaftssektor=="Sekundärer Sektor"~2,
                                                        Wirtschaftssektor=="Tertiärer Sektor"~3))


    sub_df$indicator_id<-12001
    sub_df$timeinfo_id<-1
    sub_df<-fill_dimensions_with_na(sub_df,value_id=TRUE)
    colnames(sub_df)[colnames(sub_df)=="Jahr"]<-"time_value"


    sub_df<-bring_indicator_values_to_order(sub_df[,GLOBAL_TOTAL_LIST],final_length=T)
    #TODO
    #sub_df<-zh_add_regions_bezirke(sub_df)
    sub_df<-bring_indicator_values_to_order(sub_df[,GLOBAL_TOTAL_LIST],final_length=T)

    write.csv(sub_df,"data/values/12001_CH.csv",row.names = F)
    update_last_updated(12001)
    convert_and_write_per_unit(sub_df,12002,"12002_CH.csv",how_many=1000)

    # VZAE

    df$temp<-stringr::str_locate(pattern ='Vollzeitäquivalente',df$Beobachtungseinheit)[,1]
    sub_df<-df[!is.na(df$temp),]
    sub_df<-sub_df %>% mutate(dim1_value_id = case_when(Beobachtungseinheit=="Vollzeitäquivalente"~0,
                                                        Beobachtungseinheit=="Vollzeitäquivalente Männer"~1,
                                                        Beobachtungseinheit=="Vollzeitäquivalente Frauen"~2),
                              dim2_value_id = case_when(Wirtschaftssektor=="Wirtschaftssektor - Total"~0,
                                                        Wirtschaftssektor=="Primärsektor"~1,
                                                        Wirtschaftssektor=="Sekundärer Sektor"~2,
                                                        Wirtschaftssektor=="Tertiärer Sektor"~3))


    sub_df$indicator_id<-12101
    sub_df$timeinfo_id<-1
    sub_df<-fill_dimensions_with_na(sub_df,value_id=TRUE)
    colnames(sub_df)[colnames(sub_df)=="Jahr"]<-"time_value"


    sub_df<-bring_indicator_values_to_order(sub_df[,GLOBAL_TOTAL_LIST],final_length=T)
    #TODO
    #sub_df<-zh_add_regions_bezirke(sub_df)
    sub_df<-bring_indicator_values_to_order(sub_df[,GLOBAL_TOTAL_LIST],final_length=T)

    write.csv(sub_df,"data/values/12101_CH.csv",row.names = F)
    update_last_updated(12101)
    convert_and_write_per_unit(sub_df,12102,"12102_CH.csv",how_many=1000)

    # Arbeitsstaette

    df$temp<-stringr::str_locate(pattern ='Arbeitsstätten',df$Beobachtungseinheit)[,1]
    sub_df<-df[!is.na(df$temp),]
    sub_df<-sub_df %>% mutate(dim1_value_id = case_when(Wirtschaftssektor=="Wirtschaftssektor - Total"~0,
                                                        Wirtschaftssektor=="Primärsektor"~1,
                                                        Wirtschaftssektor=="Sekundärer Sektor"~2,
                                                        Wirtschaftssektor=="Tertiärer Sektor"~3))


    sub_df$indicator_id<-23001
    sub_df$timeinfo_id<-1
    sub_df<-fill_dimensions_with_na(sub_df,value_id=TRUE)
    colnames(sub_df)[colnames(sub_df)=="Jahr"]<-"time_value"


    sub_df<-bring_indicator_values_to_order(sub_df[,GLOBAL_TOTAL_LIST],final_length=T)
    #TODO: HAS TO BE MODIFIED
    #sub_df<-zh_add_regions_bezirke(sub_df)
    sub_df<-bring_indicator_values_to_order(sub_df[,GLOBAL_TOTAL_LIST],final_length=T)

    write.csv(sub_df,"data/values/23001_CH.csv",row.names = F)
    update_last_updated(23001)
    convert_and_write_per_unit(sub_df,23002,"23002_CH.csv",how_many=1000)


    return("UPDATE OK")
  }else{
    print("No changes found")
    return("UP-TO-DATE")
  }
}
