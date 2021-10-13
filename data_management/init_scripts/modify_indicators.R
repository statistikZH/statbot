


df<-data.frame(INDICATOR_ID=11001,NAME_DE="Ständige Wohnbevölkerung",NAME_FR="Ständige Wohnbevölkerung",
           NAME_IT="Ständige Wohnbevölkerung",NAME_EN="Ständige Wohnbevölkerung",
           DESCRIPTION_DE="Ständige Bevölkerung",DESCRIPTION_FR="Ständige Bevölkerung",
           DESCRIPTION_IT="Ständige Bevölkerung",DESCRIPTION_EN="Ständige Bevölkerung",
           UNIT_SHORT_DE="Pers.",UNIT_SHORT_FR="Pers.",UNIT_SHORT_IT="Pers.",UNIT_SHORT_EN="Pers.",
           UNIT_LONG_DE="Personen",UNIT_LONG_FR="Personen",UNIT_LONG_IT="Personen",UNIT_LONG_EN="Personen",
           SOURCE="BFS-STATPOP",dim1_id=1,dim2_id=2,dim3_id=3,CURRENT_DATE=0,MIN_YEAR=2010,MAX_YEAR=2020)

write.csv(df,"data/indicators.csv",row.names = F)
