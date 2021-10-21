
source("helper.R")

# Cleaning/Removing all the previous variables starting with statbot_ind_ in case that they are still in memory
rm(list=ls(pat="statbot_ind_"))

statbot_ind_11001<-data.frame(indicator_id=11001,name_de="Ständige Wohnbevölkerung",name_fr="Ständige Wohnbevölkerung",
           name_it="Ständige Wohnbevölkerung",name_en="Ständige Wohnbevölkerung",
           description_de="Ständige Bevölkerung",description_fr="Ständige Bevölkerung",
           description_it="Ständige Bevölkerung",description_en="Ständige Bevölkerung",
           unit_short_de="Pers.",unit_short_fr="Pers.",unit_short_it="Pers.",unit_short_en="Pers.",
           unit_long_de="Personen",unit_long_fr="Personen",unit_long_it="Personen",unit_long_en="Personen",
           source="BFS-STATPOP",dim1_id=1,dim2_id=2,dim3_id=3,dim4_id=NA,last_updated=NA,min_year=2010,max_year=2020)


statbot_ind_11101<-data.frame(indicator_id=11101,name_de="Geburten",name_fr="Geburten",
                              name_it="Geburten",name_en="Geburten",
                              description_de="Geburten",description_fr="Geburten",
                              description_it="Geburten",description_en="Geburten",
                              unit_short_de="Pers.",unit_short_fr="Pers.",unit_short_it="Pers.",unit_short_en="Pers.",
                              unit_long_de="Personen",unit_long_fr="Personen",unit_long_it="Personen",unit_long_en="Personen",
                              source="BFS-BEVNAT",dim1_id=1,dim2_id=2,dim3_id=4,dim4_id=NA,last_updated=NA,min_year=1969,max_year=2020)


statbot_ind_32001<-data.frame(indicator_id=32001,name_de="Fläche",name_fr="Fläche",
                              name_it="Fläche",name_en="Fläche",
                              description_de="Fläche",description_fr="Fläche",
                              description_it="Fläche",description_en="Fläche",
                              unit_short_de="km2",unit_short_fr="km2",unit_short_it="km2",unit_short_en="km2",
                              unit_long_de="km2",unit_long_fr="km2",unit_long_it="km2",unit_long_en="km2",
                              source="BFS-Gemeindeporträt",dim1_id=NA,dim2_id=NA,dim3_id=NA,dim4_id=NA,last_updated=NA,min_year=2016,max_year=2018)

statbot_ind_12001<-data.frame(indicator_id=12001,name_de="Beschäftigte",name_fr="Beschäftigte",
                              name_it="Beschäftigte",name_en="Beschäftigte",
                              description_de="Beschäftigte",description_fr="Beschäftigte",
                              description_it="Beschäftigte",description_en="Beschäftigte",
                              unit_short_de="Pers.",unit_short_fr="Pers.",unit_short_it="Pers.",unit_short_en="Pers.",
                              unit_long_de="Personen",unit_long_fr="Personen",unit_long_it="Personen",unit_long_en="Personen",
                              source="BFS-STATENT",dim1_id=1,dim2_id=5,dim3_id=NA,dim4_id=NA,last_updated=NA,min_year=2011,max_year=2018)

statbot_ind_12002<-data.frame(indicator_id=12002,name_de="Beschäftigte pro 1000 Einwohner",name_fr="Beschäftigte pro 1000 Einwohner",
                              name_it="Beschäftigte pro 1000 Einwohner",name_en="Beschäftigte pro 1000 Einwohner",
                              description_de="Beschäftigte pro 1000 Einwohner",description_fr="Beschäftigte pro 1000 Einwohner",
                              description_it="Beschäftigte pro 1000 Einwohner",description_en="Beschäftigte pro 1000 Einwohner",
                              unit_short_de="Pers./1000 Einw.",unit_short_fr="Pers./1000 Einw.",unit_short_it="Pers./1000 Einw.",unit_short_en="Pers./1000 Einw.",
                              unit_long_de="Personen pro 1000 Einwohner",unit_long_fr="Personen pro 1000 Einwohner",unit_long_it="Personen pro 1000 Einwohner",unit_long_en="Personen pro 1000 Einwohner",
                              source="BFS-STATENT",dim1_id=1,dim2_id=5,dim3_id=NA,dim4_id=NA,last_updated=NA,min_year=2011,max_year=2018)


statbot_ind_12101<-data.frame(indicator_id=12101,name_de="Vollzeitäquivalente",name_fr="Vollzeitäquivalente",
                              name_it="Vollzeitäquivalente",name_en="Vollzeitäquivalente",
                              description_de="Vollzeitäquivalente",description_fr="Vollzeitäquivalente",
                              description_it="Vollzeitäquivalente",description_en="Vollzeitäquivalente",
                              unit_short_de="VZÄ",unit_short_fr="VZÄ",unit_short_it="VZÄ",unit_short_en="VZÄ",
                              unit_long_de="Vollzeitäquivalente",unit_long_fr="Vollzeitäquivalente",unit_long_it="Vollzeitäquivalente",unit_long_en="Vollzeitäquivalente",
                              source="BFS-STATENT",dim1_id=1,dim2_id=5,dim3_id=NA,dim4_id=NA,last_updated=NA,min_year=2015,max_year=2018)

statbot_ind_12102<-data.frame(indicator_id=12102,name_de="Vollzeitäquivalente pro 1000 Einwohner",name_fr="Vollzeitäquivalente pro 1000 Einwohner",
                              name_it="Vollzeitäquivalente pro 1000 Einwohner",name_en="Vollzeitäquivalente pro 1000 Einwohner",
                              description_de="Vollzeitäquivalente pro 1000 Einwohner",description_fr="Vollzeitäquivalente pro 1000 Einwohner",
                              description_it="Vollzeitäquivalente pro 1000 Einwohner",description_en="Vollzeitäquivalente pro 1000 Einwohner",
                              unit_short_de="VZÄ/1000 Einw.",unit_short_fr="VZÄ/1000 Einw.",unit_short_it="VZÄ/1000 Einw.",unit_short_en="VZÄ/1000 Einw.",
                              unit_long_de="Vollzeitäquivalente pro 1000 Einwohner",unit_long_fr="Vollzeitäquivalente pro 1000 Einwohner",unit_long_it="Vollzeitäquivalente pro 1000 Einwohner",unit_long_en="Vollzeitäquivalente pro 1000 Einwohner",
                              source="BFS-STATENT",dim1_id=1,dim2_id=5,dim3_id=NA,dim4_id=NA,last_updated=NA,min_year=2015,max_year=2018)

statbot_ind_23001<-data.frame(indicator_id=23001,name_de="Arbeitsstätten",name_fr="Arbeitsstätten",
                              name_it="Arbeitsstätten",name_en="Arbeitsstätten",
                              description_de="Arbeitsstätten",description_fr="Arbeitsstätten",
                              description_it="Arbeitsstätten",description_en="Arbeitsstätten",
                              unit_short_de="Arbeitsstätten",unit_short_fr="Arbeitsstätten",unit_short_it="Arbeitsstätten",unit_short_en="Arbeitsstätten",
                              unit_long_de="Arbeitsstätten",unit_long_fr="Arbeitsstätten",unit_long_it="Arbeitsstätten",unit_long_en="Arbeitsstätten",
                              source="BFS-STATENT",dim1_id=5,dim2_id=NA,dim3_id=NA,dim4_id=NA,last_updated=NA,min_year=2011,max_year=2018)

statbot_ind_23002<-data.frame(indicator_id=23002,name_de="Arbeitsstätten pro 1000 Einwohner",name_fr="Arbeitsstätten pro 1000 Einwohner",
                              name_it="Arbeitsstätten pro 1000 Einwohner",name_en="Arbeitsstätten pro 1000 Einwohner",
                              description_de="Arbeitsstätten pro 1000 Einwohner",description_fr="Arbeitsstätten pro 1000 Einwohner",
                              description_it="Arbeitsstätten pro 1000 Einwohner",description_en="Arbeitsstätten pro 1000 Einwohner",
                              unit_short_de="Arbeitsstätten pro 1000 Einwohner",unit_short_fr="Arbeitsstätten pro 1000 Einwohner",unit_short_it="Arbeitsstätten pro 1000 Einwohner",unit_short_en="Arbeitsstätten pro 1000 Einwohner",
                              unit_long_de="Arbeitsstätten pro 1000 Einwohner",unit_long_fr="Arbeitsstätten pro 1000 Einwohner",unit_long_it="Arbeitsstätten pro 1000 Einwohner",unit_long_en="Arbeitsstätten pro 1000 Einwohner",
                              source="BFS-STATENT",dim1_id=5,dim2_id=NA,dim3_id=NA,dim4_id=NA,last_updated=NA,min_year=2011,max_year=2018)


# merge all the variables starting with statbot_ind_ together
# and before that also fill all the empty dimensions with NAs if not defined before

out<-NULL
for(i in ls(pat="statbot_ind_")){
  temp<-eval(as.name(i))
  temp<-fill_dimensions_with_na(temp)
  out<-rbind(out,temp)
}

# reorder
out<- out[,c("indicator_id","name_de","name_fr","name_it","name_en",
"description_de","description_fr","description_it","description_en","unit_short_de",
"unit_short_fr","unit_short_it","unit_short_en","unit_long_de","unit_long_fr",
"unit_long_it","unit_long_en","source","dim1_id","dim2_id","dim3_id","dim4_id",
"dim5_id","dim6_id","min_year","max_year","last_updated")]

# output
write.csv(out,"data/indicators.csv",row.names = F)
