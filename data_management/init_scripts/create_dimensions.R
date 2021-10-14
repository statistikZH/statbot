
# Geschlecht nach eCH-0011 V8.1 und eCH-0044 V4.1
# Abweichung vom eCH: 0 als Total
# 3 wäre unebstimmt laut eCH

statbot_dim_geschlecht<-data.frame(  dim_id=1,
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

# Herkunft wie intern verwendet. Keine eCH gefunden

statbot_dim_herkunft<-data.frame(  dim_id=2,
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

# Alter nach BFS Bevölkerungsschema
# keine eCH gefunden

statbot_dim_alter<-data.frame(  dim_id=3,
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

statbot_dim_altersklasse_mutter<-data.frame(  dim_id=4,
                                dim_name_de="Altersklasse der Mutter",
                                dim_name_fr="Altersklasse der Mutter",
                                dim_name_it="Altersklasse der Mutter",
                                dim_name_en="Altersklasse der Mutter",
                                value_id=seq(0,5),
                                value_name_de=c("Total","Unter 25 Jahren","25-29 Jahre","30-34 Jahre","35-39 Jahre","40 Jahre und mehr"),
                                value_name_fr=c("Total","Unter 25 Jahren","25-29 Jahre","30-34 Jahre","35-39 Jahre","40 Jahre und mehr"),
                                value_name_it=c("Total","Unter 25 Jahren","25-29 Jahre","30-34 Jahre","35-39 Jahre","40 Jahre und mehr"),
                                value_name_en=c("Total","Unter 25 Jahren","25-29 Jahre","30-34 Jahre","35-39 Jahre","40 Jahre und mehr")
)

statbot_dim_wirtschaftssektor<-data.frame(  dim_id=5,
                                              dim_name_de="Wirtschaftssektor",
                                              dim_name_fr="Wirtschaftssektor",
                                              dim_name_it="Wirtschaftssektor",
                                              dim_name_en="Wirtschaftssektor",
                                              value_id=seq(0,3),
                                              value_name_de=c("Total","Primärsektor","Sekundärer Sektor","Tertiärer Sektor"),
                                              value_name_fr=c("Total","Primärsektor","Sekundärer Sektor","Tertiärer Sektor"),
                                              value_name_it=c("Total","Primärsektor","Sekundärer Sektor","Tertiärer Sektor"),
                                              value_name_en=c("Total","Primärsektor","Sekundärer Sektor","Tertiärer Sektor")
)

# merge all the variables starting with statbot_dim_ together
out<-NULL
for(i in ls(pat="statbot_dim_")){
  out<-rbind(out,eval(as.name(i)))
}

# output
write.csv(out,"data/dimensions.csv",row.names = F)
