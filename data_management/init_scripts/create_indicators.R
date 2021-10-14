


statbot_ind_11001<-data.frame(indicator_id=11001,name_de="Ständige Wohnbevölkerung",name_fr="Ständige Wohnbevölkerung",
           name_it="Ständige Wohnbevölkerung",name_en="Ständige Wohnbevölkerung",
           description_de="Ständige Bevölkerung",description_fr="Ständige Bevölkerung",
           description_it="Ständige Bevölkerung",description_en="Ständige Bevölkerung",
           unit_short_de="Pers.",unit_short_fr="Pers.",unit_short_it="Pers.",unit_short_en="Pers.",
           unit_long_de="Personen",unit_long_fr="Personen",unit_long_it="Personen",unit_long_en="Personen",
           source="BFS-STATPOP",dim1_id=1,dim2_id=2,dim3_id=3,current_date=NA,min_year=2010,max_year=2020)


statbot_ind_11101<-data.frame(indicator_id=11101,name_de="Geburten",name_fr="Geburten",
                              name_it="Geburten",name_en="Geburten",
                              description_de="Geburten",description_fr="Geburten",
                              description_it="Geburten",description_en="Geburten",
                              unit_short_de="Pers.",unit_short_fr="Pers.",unit_short_it="Pers.",unit_short_en="Pers.",
                              unit_long_de="Personen",unit_long_fr="Personen",unit_long_it="Personen",unit_long_en="Personen",
                              source="BFS-BEVNAT",dim1_id=1,dim2_id=2,dim3_id=4,current_date=NA,min_year=1969,max_year=2020)


statbot_ind_32001<-data.frame(indicator_id=32001,name_de="Fläche",name_fr="Fläche",
                              name_it="Fläche",name_en="Fläche",
                              description_de="Fläche",description_fr="Fläche",
                              description_it="Fläche",description_en="Fläche",
                              unit_short_de="km2",unit_short_fr="km2",unit_short_it="km2",unit_short_en="km2",
                              unit_long_de="km2",unit_long_fr="km2",unit_long_it="km2",unit_long_en="km2",
                              source="BFS-Gemeindeporträt",dim1_id=NA,dim2_id=NA,dim3_id=NA,current_date=NA,min_year=2016,max_year=2016)



# merge all the variables starting with statbot_ind_ together
out<-NULL
for(i in ls(pat="statbot_ind_")){
  out<-rbind(out,eval(as.name(i)))
}

# output
write.csv(out,"data/indicators.csv",row.names = F)
