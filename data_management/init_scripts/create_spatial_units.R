df<-read.csv("data/old_spatialunits.csv")
#selection of columns
df<-df[,1:4]

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
df$spatialunit_id<-ifelse(df$type_id==8&df$name_de=="Zuerich - ganzer Kanton",010000,df$spatialunit_id)
df$spatialunit_id<-ifelse(df$type_id==8&df$name_de=="Kanton Basel-Stadt",120000,df$spatialunit_id)
df$spatialunit_id<-ifelse(df$type_id==3|df$type_id==4,df$spatialunit_id+010000,df$spatialunit_id)
df$spatialunit_id<-ifelse(df$type_id==10,df$spatialunit_id+120000,df$spatialunit_id)

df<-rbind(df,data.frame(spatialunit_id=0,type_id=0,name_de="Schweiz",bfs_nr=NA,type_name="Schweiz",
                        name_fr="Suisse",name_it="Svizzera",name_en="Switzerland"))



                        #saving to the new spatialunits.csv
write.csv(df,"data/spatialunits.csv",row.names = F)
