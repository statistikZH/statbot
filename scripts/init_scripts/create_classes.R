#V3.0.2 - 17.12.2021 - Updating the logic

# Cleaning/Removing all the previous variables starting with statbot_ind_ in case that they are still in memory
rm(list=ls(pat="statbot_ind_"))

statbot_ind_1_01_001<-data.frame(class_id="1_01_001",class_name="resident_population",name_de="Ständige Wohnbevölkerung",name_fr="Ständige Wohnbevölkerung",
           name_it="Ständige Wohnbevölkerung",name_en="Resident Population",
           description_de="Ständige Bevölkerung",description_fr="Ständige Bevölkerung",
           description_it="Ständige Bevölkerung",description_en="Ständige Bevölkerung",
           unit_short_de="Pers.",unit_short_fr="Pers.",unit_short_it="Pers.",unit_short_en="Pers.",
           unit_long_de="Personen",unit_long_fr="Personen",unit_long_it="Personen",unit_long_en="Personen",
           source="BFS-STATPOP",dim1_id=1,dim2_id=2,dim3_id=3,dim4_id=NA,last_updated=NA,min_year=2010,max_year=2020)

#'population_density': '1_01_002',
#'foreigner_proportion': '1_01_003',


statbot_ind_1_01_004<-data.frame(class_id="1_01_004",class_name="nativity",name_de="Geburten",name_fr="Geburten",
                              name_it="Geburten",name_en="Nativity",
                              description_de="Geburten",description_fr="Geburten",
                              description_it="Geburten",description_en="Geburten",
                              unit_short_de="Pers.",unit_short_fr="Pers.",unit_short_it="Pers.",unit_short_en="Pers.",
                              unit_long_de="Personen",unit_long_fr="Personen",unit_long_it="Personen",unit_long_en="Personen",
                              source="BFS-BEVNAT",dim1_id=1,dim2_id=2,dim3_id=4,dim4_id=NA,last_updated=NA,min_year=1969,max_year=2020)


# 'nativity_per_1000_residents': '1_01_005',
# 'death': '1_01_006',
# 'death_per_1000_residents': '1_01_007',
# 'marriage': '1_01_008',
# 'marriage_per_1000_residents': '1_01_009',
# 'divorce': '1_01_010',
# 'divorce_per_1000_residents': '1_01_011',
# 'civil_union': '1_01_012',
# 'civil_union_per_1000_residents': '1_01_013',
# 'stillbirth': '1_01_014',
# 'stillbirth_per_1000_residents': '1_01_015',
# 'favorite_firstname': '1_01_016',
# 'inflows': '1_01_017',
# 'inflows_per_1000_residents': '1_01_018',
# 'departures': '1_01_019',
# 'departures_per_1000_residents': '1_01_020',
# 'migration_balance': '1_01_021',
# 'migration_balance_per_1000_residents': '1_01_022',



statbot_ind_1_02_001<-data.frame(class_id="1_02_001",class_name="employee",name_de="Beschäftigte",name_fr="Beschäftigte",
                              name_it="Beschäftigte",name_en="Employee",
                              description_de="Beschäftigte",description_fr="Beschäftigte",
                              description_it="Beschäftigte",description_en="Beschäftigte",
                              unit_short_de="Pers.",unit_short_fr="Pers.",unit_short_it="Pers.",unit_short_en="Pers.",
                              unit_long_de="Personen",unit_long_fr="Personen",unit_long_it="Personen",unit_long_en="Personen",
                              source="BFS-STATENT",dim1_id=1,dim2_id=5,dim3_id=NA,dim4_id=NA,last_updated=NA,min_year=2011,max_year=2018)

statbot_ind_1_02_002<-data.frame(class_id="1_02_002",class_name="employee_per_1000_residents",name_de="Beschäftigte pro 1000 Einwohner",name_fr="Beschäftigte pro 1000 Einwohner",
                              name_it="Beschäftigte pro 1000 Einwohner",name_en="Employee per 1000 residents",
                              description_de="Beschäftigte pro 1000 Einwohner",description_fr="Beschäftigte pro 1000 Einwohner",
                              description_it="Beschäftigte pro 1000 Einwohner",description_en="Beschäftigte pro 1000 Einwohner",
                              unit_short_de="Pers./1000 Einw.",unit_short_fr="Pers./1000 Einw.",unit_short_it="Pers./1000 Einw.",unit_short_en="Pers./1000 Einw.",
                              unit_long_de="Personen pro 1000 Einwohner",unit_long_fr="Personen pro 1000 Einwohner",unit_long_it="Personen pro 1000 Einwohner",unit_long_en="Personen pro 1000 Einwohner",
                              source="BFS-STATENT",dim1_id=1,dim2_id=5,dim3_id=NA,dim4_id=NA,last_updated=NA,min_year=2011,max_year=2018)



statbot_ind_1_02_003<-data.frame(class_id="1_02_003",class_name="fulltime_equivalent",name_de="Vollzeitäquivalente",name_fr="Vollzeitäquivalente",
                              name_it="Vollzeitäquivalente",name_en="Fulltime_equivalent",
                              description_de="Vollzeitäquivalente",description_fr="Vollzeitäquivalente",
                              description_it="Vollzeitäquivalente",description_en="Vollzeitäquivalente",
                              unit_short_de="VZÄ",unit_short_fr="VZÄ",unit_short_it="VZÄ",unit_short_en="VZÄ",
                              unit_long_de="Vollzeitäquivalente",unit_long_fr="Vollzeitäquivalente",unit_long_it="Vollzeitäquivalente",unit_long_en="Vollzeitäquivalente",
                              source="BFS-STATENT",dim1_id=1,dim2_id=5,dim3_id=NA,dim4_id=NA,last_updated=NA,min_year=2015,max_year=2018)

statbot_ind_1_02_004<-data.frame(class_id="1_02_004",class_name="fulltime_equivalent_per_1000_residents",name_de="Vollzeitäquivalente pro 1000 Einwohner",name_fr="Vollzeitäquivalente pro 1000 Einwohner",
                              name_it="Vollzeitäquivalente pro 1000 Einwohner",name_en="Fulltime equivalent per 1000 residents",
                              description_de="Vollzeitäquivalente pro 1000 Einwohner",description_fr="Vollzeitäquivalente pro 1000 Einwohner",
                              description_it="Vollzeitäquivalente pro 1000 Einwohner",description_en="Vollzeitäquivalente pro 1000 Einwohner",
                              unit_short_de="VZÄ/1000 Einw.",unit_short_fr="VZÄ/1000 Einw.",unit_short_it="VZÄ/1000 Einw.",unit_short_en="VZÄ/1000 Einw.",
                              unit_long_de="Vollzeitäquivalente pro 1000 Einwohner",unit_long_fr="Vollzeitäquivalente pro 1000 Einwohner",unit_long_it="Vollzeitäquivalente pro 1000 Einwohner",unit_long_en="Vollzeitäquivalente pro 1000 Einwohner",
                              source="BFS-STATENT",dim1_id=1,dim2_id=5,dim3_id=NA,dim4_id=NA,last_updated=NA,min_year=2015,max_year=2018)


# 'housing': '1_07_001',
# 'housing_per_1000_residents': '1_07_002',
# 'rental_apartments': '1_07_003',
# 'rental_apartments_per_1000_residents': '1_07_004',
# 'condominium': '1_07_005',
# 'condominium_per_1000_residents': '1_07_006',
# 'building': '1_07_007',
# 'building_per_1000_residents': '1_07_008',
# 'one_family_house': '1_07_009',
# 'one_family_house_per_1000_residents': '1_07_010',
# 'apartment_building': '1_07_011',
# 'apartment_building_per_1000_residents': '1_07_012',
# 'household_size': '1_07_013',
# 'voting_results': '1_10_001',
# 'national_council_elections': '1_10_002'


statbot_ind_2_03_001<-data.frame(class_id="2_03_001",class_name="workplace",name_de="Arbeitsstätten",name_fr="Arbeitsstätten",
                              name_it="Arbeitsstätten",name_en="Workplace",
                              description_de="Arbeitsstätten",description_fr="Arbeitsstätten",
                              description_it="Arbeitsstätten",description_en="Arbeitsstätten",
                              unit_short_de="Arbeitsstätten",unit_short_fr="Arbeitsstätten",unit_short_it="Arbeitsstätten",unit_short_en="Arbeitsstätten",
                              unit_long_de="Arbeitsstätten",unit_long_fr="Arbeitsstätten",unit_long_it="Arbeitsstätten",unit_long_en="Arbeitsstätten",
                              source="BFS-STATENT",dim1_id=5,dim2_id=NA,dim3_id=NA,dim4_id=NA,last_updated=NA,min_year=2011,max_year=2018)

statbot_ind_2_03_002<-data.frame(class_id="2_03_002",class_name="workplace_per_1000_residents",name_de="Arbeitsstätten pro 1000 Einwohner",name_fr="Arbeitsstätten pro 1000 Einwohner",
                              name_it="Arbeitsstätten pro 1000 Einwohner",name_en="Worklace per 1000 residents",
                              description_de="Arbeitsstätten pro 1000 Einwohner",description_fr="Arbeitsstätten pro 1000 Einwohner",
                              description_it="Arbeitsstätten pro 1000 Einwohner",description_en="Arbeitsstätten pro 1000 Einwohner",
                              unit_short_de="Arbeitsstätten pro 1000 Einwohner",unit_short_fr="Arbeitsstätten pro 1000 Einwohner",unit_short_it="Arbeitsstätten pro 1000 Einwohner",unit_short_en="Arbeitsstätten pro 1000 Einwohner",
                              unit_long_de="Arbeitsstätten pro 1000 Einwohner",unit_long_fr="Arbeitsstätten pro 1000 Einwohner",unit_long_it="Arbeitsstätten pro 1000 Einwohner",unit_long_en="Arbeitsstätten pro 1000 Einwohner",
                              source="BFS-STATENT",dim1_id=5,dim2_id=NA,dim3_id=NA,dim4_id=NA,last_updated=NA,min_year=2011,max_year=2018)


# 'number_of_enterprises': '2_03_003',
# 'number_of_enterprises_per_1000_residents': '2_03_004',

statbot_ind_3_02_001<-data.frame(class_id="3_02_001",class_name="area",name_de="Fläche",name_fr="Fläche",
                              name_it="Fläche",name_en="Area",
                              description_de="Fläche",description_fr="Fläche",
                              description_it="Fläche",description_en="Area",
                              unit_short_de="km2",unit_short_fr="km2",unit_short_it="km2",unit_short_en="km2",
                              unit_long_de="km2",unit_long_fr="km2",unit_long_it="km2",unit_long_en="km2",
                              source="BFS-Gemeindeporträt",dim1_id=NA,dim2_id=NA,dim3_id=NA,dim4_id=NA,last_updated=NA,min_year=2016,max_year=2018)


# merge all the variables starting with statbot_ind_ together
# and before that also fill all the empty dimensions with NAs if not defined before

out<-NULL
for(i in ls(pat="statbot_ind_")){
  temp<-eval(as.name(i))
  temp<-fill_dimensions_with_na(temp)
  out<-rbind(out,temp)
}

# reorder
out<- out[,c("class_id","class_name","name_de","name_fr","name_it","name_en",
"description_de","description_fr","description_it","description_en","unit_short_de",
"unit_short_fr","unit_short_it","unit_short_en","unit_long_de","unit_long_fr",
"unit_long_it","unit_long_en","source","dim1_id","dim2_id","dim3_id","dim4_id",
"dim5_id","dim6_id","min_year","max_year","last_updated")]

# output
write.csv(out,"data/classes.csv",row.names = F)
