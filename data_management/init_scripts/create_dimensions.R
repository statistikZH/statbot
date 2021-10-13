
# Geschlecht nach eCH-0011 V8.1 und eCH-0044 V4.1
# Abweichung vom eCH: 0 als Total
# 3 wäre unebstimmt laut eCH

geschlecht<-data.frame(  dim_id=1,
                 dim_name_de="Geschlecht",
                 dim_name_fr="Geschlecht",
                 dim_name_it="Geschlecht",
                 dim_name_en="Geschlecht",
                 value_id=c(1,2,0),
                 value_name_de=c("Männer","Frauen","Total"),
                 value_name_fr=c("Männer","Frauen","Total"),
                 value_name_it=c("Männer","Frauen","Total"),
                 value_name_en=c("Männer","Frauen","Total")
)
herkunft<-data.frame(  dim_id=2,
                         dim_name_de="Herkunft",
                         dim_name_fr="Herkunft",
                         dim_name_it="Herkunft",
                         dim_name_en="Herkunft",
                         value_id=c(1,2,0),
                         value_name_de=c("Schweiz","Ausland","Total"),
                         value_name_fr=c("Schweiz","Ausland","Total"),
                         value_name_it=c("Schweiz","Ausland","Total"),
                         value_name_en=c("Schweiz","Ausland","Total")
)
alter<-data.frame(  dim_id=3,
                       dim_name_de="Alter",
                       dim_name_fr="Alter",
                       dim_name_it="Alter",
                       dim_name_en="Alter",
                       value_id=seq(0,100),
                       value_name_de=c("Alter Total",paste0(seq(1,99),"-jährig"),"100 Jahre und mehr"),
                       value_name_fr=c("Alter Total",paste0(seq(1,99),"-jährig"),"100 Jahre und mehr"),
                       value_name_it=c("Alter Total",paste0(seq(1,99),"-jährig"),"100 Jahre und mehr"),
                       value_name_en=c("Alter Total",paste0(seq(1,99),"-jährig"),"100 Jahre und mehr")
)
out<-rbind(geschlecht,herkunft,alter)
write.csv(out,"data/dimensions.csv",row.names = F)
