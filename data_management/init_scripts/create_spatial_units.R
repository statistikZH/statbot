df<-read.csv("data/old_spatialunits.csv")
ch<-read.csv("data/ch_gemeinden.csv",col.names = c("SPATIALUNIT_ID","NAME"))
#selection of columns
df<-df[,1:4]

# 15.10.2021: Temporary workaround: Taking Gemeinde values from an outdated BFS file
# also take the cantons out and make it later clean
df<-df[df$TYPE_ID!=1 & df$TYPE_ID!=8,]
ch$BFS_NR<-ch$SPATIALUNIT_ID
ch$TYPE_ID<-1
df<-rbind(df,ch)


#convert to minor letters
colnames(df)[colnames(df)=="TYPE_ID"]<-"type_id"
colnames(df)[colnames(df)=="SPATIALUNIT_ID"]<-"spatialunit_id"
colnames(df)[colnames(df)=="BFS_NR"]<-"bfs_nr"

#create variable type_name out of type_ids (Does not need an own table)
df$type_name<-ifelse(df$type_id==1,"Gemeinde","")
df$type_name<-ifelse(df$type_id==8,"Kanton",df$type_name)
df$type_name<-ifelse(df$type_id==4,"Region",df$type_name)
df$type_name<-ifelse(df$type_id==3,"Bezirk",df$type_name)
df$type_name<-ifelse(df$type_id==9,"Gemeinde alt",df$type_name)

#lets create a name_col for every language
colnames(df)[colnames(df)=="NAME"]<-"name_de"
df$name_fr<-df$name_de
df$name_it<-df$name_de
df$name_en<-df$name_de


# new spatial units
df$spatialunit_id<-ifelse(df$type_id==1|df$type_id==9,df$bfs_nr,df$spatialunit_id)
df$spatialunit_id<-ifelse(df$type_id==8&df$name_de=="Kanton Zürich - ganzer Kanton",010000,df$spatialunit_id)
df$spatialunit_id<-ifelse(df$type_id==8&df$name_de=="Kanton Basel-Stadt",120000,df$spatialunit_id)
df$spatialunit_id<-ifelse(df$type_id==3|df$type_id==4,df$spatialunit_id+010000,df$spatialunit_id)
df$spatialunit_id<-ifelse(df$type_id==10,df$spatialunit_id+120000,df$spatialunit_id)

df<-rbind(df,data.frame(spatialunit_id=0,type_id=0,name_de="Schweiz",bfs_nr=NA,type_name="Schweiz",
                        name_fr="Suisse",name_it="Svizzera",name_en="Switzerland"))

df<-rbind(df,data.frame(spatialunit_id=seq(010000,260000,10000),type_id=8,
      name_de=c("Kanton Zürich","Kanton Bern","Kanton Luzern","Kanton Uri","Kanton Schwyz","Kanton Obwalden","Kanton Nidwalden","Kanton Glarus","Kanton Zug","Kanton Freiburg","Kanton Solothurn","Kanton Basel-Stadt","Kanton Basel-Landschaft","Kanton Schaffhausen","Kanton Appenzell Ausserrhoden","Kanton Appenzell Innerrhoden","Kanton St. Gallen","Kanton Graubünden","Kanton Aargau","Kanton Thurgau","Kanton Tessin","Kanton Waadt","Kanton Wallis","Kanton Neuenburg","Kanton Genf","Kanton Jura"),
      bfs_nr=NA,type_name="Kanton",
      name_fr=c("Canton de Zurich","Canton de Berne","Canton de Lucerne","Canton d'Uri","Canton de Schwyz","Canton d'Obwald","Canton de Nidwald","Canton de Glaris","Canton de Zug","Canton de Fribourg","Canton de Soleure","Canton de Bâle-Ville","Canton de Bâle-Campagne","Canton de Schaffhouse","Canton d'Appenzell Rhodes-Extérieures","Canton d'Appenzell Rhodes-Intérieures","Canton de St. Gallen","Canton des Grisons","Canton d'Argovie","Canton de Thurgovie","Canton du Tessin","Canton de Vaud","Canton du Valais","Canton de Neuchâtel","Canton de Genève","Canton du Jura"),
      name_it=c("Cantone di Zurigo","Cantone di Berna","Cantone di Lucerna","Cantone di Uri","Cantone di Svitto","Cantone di Obvaldo","Cantone di Nidvaldo","Cantone di Glarona","Cantone di Zugo","Cantone di Friburgo","Cantone di Soletta","Cantone di Basilea Città","Cantone di Basilea Campagna","Cantone di Sciaffusa","Cantone di Appenzello Esterno","Cantone di Appenzello Interno","Cantone di St. Gallen","Canton Grigioni","Canton Argovia","Canton Turgovia","Canton Ticino","Canton Vaud","Canton Vallese","Canton Neuchâtel","Canton Ginevra","Canton Giura"),
      name_en=c("Canton of Zurich","Canton of Bern","Canton of Lucerne","Canton of Uri","Canton of Schwyz","Canton of Obwalden","Canton of Nidwalden","Canton of Glarus","Canton of Zug","Canton of Fribourg","Canton of Solothurn","Canton of Basel-Stadt","Canton of Basel-Landschaft","Canton of Schaffhausen","Canton of Appenzell Ausserrhoden","Canton of Appenzell Innerrhoden","Canton of St. Gallen","Canton Graubünden","Canton Aargau","Canton Thurgau","Canton Ticino","Canton Vaud","Canton Valais","Canton Neuchâtel","Canton Geneva","Canton Jura")
      ))






                        #saving to the new spatialunits.csv
write.csv(df,"data/spatialunits.csv",row.names = F)
