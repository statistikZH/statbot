df<-read.csv("data/spatialunits.csv")
df<-df[,1:4]
df$TYPE_NAME<-ifelse(df$TYPE_ID==1,"Gemeinde","")
df$TYPE_NAME<-ifelse(df$TYPE_ID==8,"Kanton",df$TYPE_NAME)
df$TYPE_NAME<-ifelse(df$TYPE_ID==4,"Region",df$TYPE_NAME)
df$TYPE_NAME<-ifelse(df$TYPE_ID==3,"Bezirk",df$TYPE_NAME)
df$TYPE_NAME<-ifelse(df$TYPE_ID==9,"Gemeinde alt",df$TYPE_NAME)
names(df)[]
