source("helper.R")
library("xlsx")
library("janitor")
library("tidyverse")
library("pxR")

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
    sub_df$dim1_value_id<-1
    sub_df$dim2_value_id<-5
    sub_df$dim3_value_id<-NA
    sub_df$dim4_value_id<-NA
    colnames(sub_df)[colnames(sub_df)=="Jahr"]<-"time_value"

    sub_df<-bring_indicator_values_to_order(sub_df[,global_total_list],final_length=T)

    write.csv(sub_df,"data/values/12001_CH.csv",row.names = F)
    update_last_updated(12001)

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
    sub_df$dim1_value_id<-1
    sub_df$dim2_value_id<-5
    sub_df$dim3_value_id<-NA
    sub_df$dim4_value_id<-NA
    colnames(sub_df)[colnames(sub_df)=="Jahr"]<-"time_value"

    sub_df<-bring_indicator_values_to_order(sub_df[,global_total_list],final_length=T)

    write.csv(sub_df,"data/values/12101_CH.csv",row.names = F)
    update_last_updated(12101)

    # Arbeitsstaette

    df$temp<-stringr::str_locate(pattern ='Arbeitsstätten',df$Beobachtungseinheit)[,1]
    sub_df<-df[!is.na(df$temp),]
    sub_df<-sub_df %>% mutate(dim1_value_id = case_when(Wirtschaftssektor=="Wirtschaftssektor - Total"~0,
                                                        Wirtschaftssektor=="Primärsektor"~1,
                                                        Wirtschaftssektor=="Sekundärer Sektor"~2,
                                                        Wirtschaftssektor=="Tertiärer Sektor"~3))


    sub_df$indicator_id<-23001
    sub_df$timeinfo_id<-1
    sub_df$dim1_value_id<-5
    sub_df$dim2_value_id<-NA
    sub_df$dim3_value_id<-NA
    sub_df$dim4_value_id<-NA
    colnames(sub_df)[colnames(sub_df)=="Jahr"]<-"time_value"

    sub_df<-bring_indicator_values_to_order(sub_df[,global_total_list],final_length=T)

    write.csv(sub_df,"data/values/23001_CH.csv",row.names = F)
    update_last_updated(23001)


    return("UPDATE OK")
  }else{
    print("No changes found")
    return("UP-TO-DATE")
  }
}
