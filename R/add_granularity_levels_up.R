#' Function add data to higher granularity levels
#'
#' This function generates values for higher granularity levels.
#' At the moment it takes A.ADM3 and adds them up to A.ADM2 and A.ADM1 and CH.
#'
#' @param df a data.frame where the values are included
#' @param list_ontologies a character vector with ontologies to be summed up to.
#'
#' @export
add_granularity_levels_up<-function(df,list_ontologies,list_dimensions=NULL){
  # TODO: This function needs period_value functionality later


  spatial_unit_table<-read.csv("data/spatialunits.csv")[,c(
    "spatialunit_ontology","spatialunit_hist_id","canton_hist_id","district_hist_id")]

  #put all the rows out that are not adm3
  df_out<-df
  #continue only with adm3 data
  df<-df[df$spatialunit_ontology=="A.ADM3",]

  df<-merge(df,spatial_unit_table,by=c("spatialunit_ontology","spatialunit_hist_id"),all.x=T,sort=F)

  if("A.ADM2" %in% list_ontologies){
    list_to_group<-c("district_hist_id","time_value",list_dimensions)
    df_adm2<-df %>% group_by(!!!syms(list_to_group)) %>% summarize(value=sum(value,na.rm=T))
    df_adm2$spatialunit_ontology<-"A.ADM2"
    df_adm2$spatialunit_hist_id<-df_adm2$district_hist_id
    df_adm2$spatialunit_name<-translate_to_spatial_unit_name(df_adm2,"de")
    df_adm2$period_value<-NA
    df_out<-rbind(df_out,df_adm2[,c(GLOBAL_TOTAL_LIST,list_dimensions)])
    df_adm2<-NULL
  }
  if("A.ADM1" %in% list_ontologies){
    list_to_group<-c("canton_hist_id","time_value",list_dimensions)
    df_adm1<-df %>% group_by(!!!syms(list_to_group)) %>% summarize(value=sum(value,na.rm=T))
    df_adm1$spatialunit_ontology<-"A.ADM1"
    df_adm1$spatialunit_hist_id<-df_adm1$canton_hist_id
    df_adm1$spatialunit_name<-translate_to_spatial_unit_name(df_adm1,"de")
    df_adm1$period_value<-NA
    df_out<-rbind(df_out,df_adm1[,c(GLOBAL_TOTAL_LIST,list_dimensions)])
    df_adm1<-NULL
  }
  if("CH" %in% list_ontologies){
    list_to_group<-c("time_value",list_dimensions)
    df_ch<-df %>% group_by(!!!syms(list_to_group)) %>% summarize(value=sum(value,na.rm=T))
    df_ch$spatialunit_ontology<-"CH"
    df_ch$spatialunit_hist_id<-0
    df_ch$spatialunit_name<-"Schweiz"
    df_ch$period_value<-NA
    df_out<-rbind(df_out,df_ch[,c(GLOBAL_TOTAL_LIST,list_dimensions)])
    df_ch<-NULL
  }

  return(df_out[,c(GLOBAL_TOTAL_LIST,list_dimensions)])
}
