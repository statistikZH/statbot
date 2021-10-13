df<-read.csv("data/spatialunits.csv")
#selection of columns
df<-df[,1:4]
#create variable type_name out of type_ids (Does not need an own table)
df$TYPE_NAME<-ifelse(df$TYPE_ID==1,"Gemeinde","")
df$TYPE_NAME<-ifelse(df$TYPE_ID==8,"Kanton",df$TYPE_NAME)
df$TYPE_NAME<-ifelse(df$TYPE_ID==4,"Region",df$TYPE_NAME)
df$TYPE_NAME<-ifelse(df$TYPE_ID==3,"Bezirk",df$TYPE_NAME)
df$TYPE_NAME<-ifelse(df$TYPE_ID==9,"Gemeinde alt",df$TYPE_NAME)

#lets create a name_col for every language
colnames(df)[colnames(df)=="NAME"]<-"NAME_DE"
df$NAME_FR<-df$NAME_DE
df$NAME_IT<-df$NAME_DE
df$NAME_EN<-df$NAME_DE


# new spatial units
df$SPATIALUNIT_ID<-ifelse(df$TYPE_ID==1|df$TYPE_ID==9,df$BFS_NR,df$SPATIALUNIT_ID)
df$SPATIALUNIT_ID<-ifelse(df$TYPE_ID==8&df$NAME_DE=="Zuerich - ganzer Kanton",010000,df$SPATIALUNIT_ID)
df$SPATIALUNIT_ID<-ifelse(df$TYPE_ID==8&df$NAME_DE=="Kanton Basel-Stadt",120000,df$SPATIALUNIT_ID)
df$SPATIALUNIT_ID<-ifelse(df$TYPE_ID==3|df$TYPE_ID==4,df$SPATIALUNIT_ID+010000,df$SPATIALUNIT_ID)


#saving to the new spatialunits.csv
write.csv(df,"data/spatialunits.csv",row.names = F)
