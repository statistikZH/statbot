


statbot_ind_11001<-data.frame(indicator_id=11001,name_de="Ständige Wohnbevölkerung",name_fr="Ständige Wohnbevölkerung",
           name_it="Ständige Wohnbevölkerung",name_en="Ständige Wohnbevölkerung",
           description_de="Ständige Bevölkerung",description_fr="Ständige Bevölkerung",
           description_it="Ständige Bevölkerung",description_en="Ständige Bevölkerung",
           unit_short_de="Pers.",unit_short_fr="Pers.",unit_short_it="Pers.",unit_short_en="Pers.",
           unit_long_de="Personen",unit_long_fr="Personen",unit_long_it="Personen",unit_long_en="Personen",
           source="BFS-STATPOP",dim1_id=1,dim2_id=2,dim3_id=3,current_date=0,min_year=2010,max_year=2020)


statbot_ind_11004<-data.frame(indicator_id=11004,name_de="Geburten",name_fr="Geburten",
                              name_it="Geburten",name_en="Geburten",
                              description_de="Geburten",description_fr="Geburten",
                              description_it="Geburten",description_en="Geburten",
                              unit_short_de="Pers.",unit_short_fr="Pers.",unit_short_it="Pers.",unit_short_en="Pers.",
                              unit_long_de="Personen",unit_long_fr="Personen",unit_long_it="Personen",unit_long_en="Personen",
                              source="BFS-BEVNAT",dim1_id=1,dim2_id=2,dim3_id=4,current_date=0,min_year=1969,max_year=2020)



# merge all the variables starting with statbot_ind_ together
out<-NULL
for(i in ls(pat="statbot_ind_")){
  out<-rbind(out,eval(as.name(i)))
}

# output
write.csv(out,"data/indicators.csv",row.names = F)
