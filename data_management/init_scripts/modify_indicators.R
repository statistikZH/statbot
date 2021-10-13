


statbot_ind_11001<-data.frame(INDICATOR_ID=11001,NAME_DE="Ständige Wohnbevölkerung",NAME_FR="Ständige Wohnbevölkerung",
           NAME_IT="Ständige Wohnbevölkerung",NAME_EN="Ständige Wohnbevölkerung",
           DESCRIPTION_DE="Ständige Bevölkerung",DESCRIPTION_FR="Ständige Bevölkerung",
           DESCRIPTION_IT="Ständige Bevölkerung",DESCRIPTION_EN="Ständige Bevölkerung",
           UNIT_SHORT_DE="Pers.",UNIT_SHORT_FR="Pers.",UNIT_SHORT_IT="Pers.",UNIT_SHORT_EN="Pers.",
           UNIT_LONG_DE="Personen",UNIT_LONG_FR="Personen",UNIT_LONG_IT="Personen",UNIT_LONG_EN="Personen",
           SOURCE="BFS-STATPOP",dim1_id=1,dim2_id=2,dim3_id=3,CURRENT_DATE=0,MIN_YEAR=2010,MAX_YEAR=2020)


statbot_ind_11004<-data.frame(INDICATOR_ID=11004,NAME_DE="Geburten",NAME_FR="Geburten",
                              NAME_IT="Geburten",NAME_EN="Geburten",
                              DESCRIPTION_DE="Geburten",DESCRIPTION_FR="Geburten",
                              DESCRIPTION_IT="Geburten",DESCRIPTION_EN="Geburten",
                              UNIT_SHORT_DE="Pers.",UNIT_SHORT_FR="Pers.",UNIT_SHORT_IT="Pers.",UNIT_SHORT_EN="Pers.",
                              UNIT_LONG_DE="Personen",UNIT_LONG_FR="Personen",UNIT_LONG_IT="Personen",UNIT_LONG_EN="Personen",
                              SOURCE="BFS-BEVNAT",dim1_id=1,dim2_id=2,dim3_id=4,CURRENT_DATE=0,MIN_YEAR=1969,MAX_YEAR=2020)



# merge all the variables starting with statbot_ind_ together
out<-NULL
for(i in ls(pat="statbot_ind_")){
  out<-rbind(out,eval(as.name(i)))
}

# output
write.csv(out,"data/indicators.csv",row.names = F)
