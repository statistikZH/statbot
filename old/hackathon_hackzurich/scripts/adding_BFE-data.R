library(tidyverse)

anz_ls<-read.csv("https://github.com/statistikZH/geocoords2spatialunits/raw/main/anzahl_ladestationen.csv")
bev<-read.csv2("https://www.web.statistik.zh.ch/ogd/data/KANTON_ZUERICH_133.csv")

bev<-bev[bev$INDIKATOR_JAHR==2020&bev$BFS_NR!=0,]
df<-merge(anz_ls,bev,by.x="bfs_num",by.y="BFS_NR",all.y=T)
df$Anzahl_Ladestationen<-ifelse(is.na(df$Anzahl_Ladestationen),0,df$Anzahl_Ladestationen)

df$Anzahl_Ladestationen_pro1000<-df$Anzahl_Ladestationen/df$INDIKATOR_VALUE*1000

df_999<-data.frame(INDICATOR_ID=999,SPATIALUNIT_ID=df$bfs_num,YEAR=2021,VALUE=df$Anzahl_Ladestationen,VALUE_ADDITION="",CAT=format(Sys.time(), '%d.%m.%Y %H:%M'))
df_998<-data.frame(INDICATOR_ID=998,SPATIALUNIT_ID=df$bfs_num,YEAR=2021,VALUE=df$Anzahl_Ladestationen_pro1000,VALUE_ADDITION="",CAT=format(Sys.time(), '%d.%m.%Y %H:%M'))

values<-read.csv("hackathon_hackzurich/input_data/EN_INDICATOR_VALUES.csv")

values<-rbind(values,df_999,df_998)

write.csv(values,"hackathon_hackzurich/input_data/EN_INDICATOR_VALUES.csv",row.names = F)
