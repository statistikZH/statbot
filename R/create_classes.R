#V3.2.0 - 22.02.2022 - Adding further FSO datasets of the first batch
#V3.0.2b - 17.12.2021 - 20.12.2021 - Updating the logic

create_classes <-function(){
  # Cleaning/Removing all the previous variables starting with statbot_ind_ in case that they are still in memory
  rm(list=ls(pat="statbot_ind_"))

  statbot_ind_1_01_001<-data.frame(class_id="1_01_001",class_name="resident_population",
             name_de="Ständige Wohnbevölkerung",name_fr="Ständige Wohnbevölkerung",
             name_it="Ständige Wohnbevölkerung",name_en="Resident Population",
             description_de="Ständige Bevölkerung",description_fr="Ständige Bevölkerung",
             description_it="Ständige Bevölkerung",description_en="Ständige Bevölkerung",
             unit_short_de="Pers.",unit_short_fr="Pers.",unit_short_it="Pers.",unit_short_en="Pers.",
             unit_long_de="Personen",unit_long_fr="Personen",unit_long_it="Personen",unit_long_en="Personen",
             source="BFS-STATPOP",dim1_id=1,dim2_id=2,dim3_id=3,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2010,max_year=2020)

  #'population_density': '1_01_002',
  #'foreigner_proportion': '1_01_003',


  statbot_ind_1_01_004<-data.frame(class_id="1_01_004",class_name="nativity",name_de="Geburten",name_fr="Geburten",
                                name_it="Geburten",name_en="Nativity",
                                description_de="Geburten",description_fr="Geburten",
                                description_it="Geburten",description_en="Geburten",
                                unit_short_de="Pers.",unit_short_fr="Pers.",unit_short_it="Pers.",unit_short_en="Pers.",
                                unit_long_de="Personen",unit_long_fr="Personen",unit_long_it="Personen",unit_long_en="Personen",
                                source="BFS-BEVNAT",dim1_id=1,dim2_id=2,dim3_id=4,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=1969,max_year=2020)


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
  statbot_ind_1_01_016<-data.frame(class_id="1_01_016",class_name="favorite_firstname_rank_girl",name_de="Babynamen Rang weiblich",name_fr="Babynamen Rang weiblich",
                                   name_it="Babynamen Rang weiblich",name_en="Favorite first name rank girl",
                                   description_de="Babynamen Rang weiblich",description_fr="Babynamen Rang weiblich",
                                   description_it="Babynamen Rang weiblich",description_en="Babynamen Rang weiblich",
                                   unit_short_de="Rang",unit_short_fr="Rang",unit_short_it="Rang",unit_short_en="Rang",
                                   unit_long_de="Rang",unit_long_fr="Rang",unit_long_it="Rang",unit_long_en="Rang",
                                   source="BFS-BEVNAT",dim1_id=30,dim2_id=NA,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2000,max_year=2020)

  statbot_ind_1_01_017<-data.frame(class_id="1_01_017",class_name="favorite_firstname_rank_boy",name_de="Babynamen Rang männlich",name_fr="Babynamen Rang männlich",
                                   name_it="Babynamen Rang männlich",name_en="Favorite first name rank boy",
                                   description_de="Babynamen Rang männlich",description_fr="Babynamen Rang männlich",
                                   description_it="Babynamen Rang männlich",description_en="Babynamen Rang männlich",
                                   unit_short_de="Rang",unit_short_fr="Rang",unit_short_it="Rang",unit_short_en="Rang",
                                   unit_long_de="Rang",unit_long_fr="Rang",unit_long_it="Rang",unit_long_en="Rang",
                                   source="BFS-BEVNAT",dim1_id=31,dim2_id=NA,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2000,max_year=2020)


  statbot_ind_1_01_018<-data.frame(class_id="1_01_018",class_name="favorite_firstname_amount_girl",name_de="Babynamen Anzahl weiblich",name_fr="Babynamen Anzahl weiblich",
                                   name_it="Babynamen Anzahl weiblich",name_en="Favorite first name amount girl",
                                   description_de="Babynamen Anzahl weiblich",description_fr="Babynamen Anzahl weiblich",
                                   description_it="Babynamen Anzahl weiblich",description_en="Babynamen Anzahl weiblich",
                                   unit_short_de="Anzahl",unit_short_fr="Anzahl",unit_short_it="Anzahl",unit_short_en="Anzahl",
                                   unit_long_de="Anzahl",unit_long_fr="Anzahl",unit_long_it="Anzahl",unit_long_en="Anzahl",
                                   source="BFS-BEVNAT",dim1_id=30,dim2_id=NA,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2000,max_year=2020)

  statbot_ind_1_01_019<-data.frame(class_id="1_01_019",class_name="favorite_firstname_amount_boy",name_de="Babynamen Anzahl männlich",name_fr="Babynamen Anzahl männlich",
                                   name_it="Babynamen Anzahl männlich",name_en="Favorite first name amount boy",
                                   description_de="Babynamen Anzahl männlich",description_fr="Babynamen Anzahl männlich",
                                   description_it="Babynamen Anzahl männlich",description_en="Babynamen Anzahl männlich",
                                   unit_short_de="Anzahl",unit_short_fr="Anzahl",unit_short_it="Anzahl",unit_short_en="Anzahl",
                                   unit_long_de="Anzahl",unit_long_fr="Anzahl",unit_long_it="Anzahl",unit_long_en="Anzahl",
                                   source="BFS-BEVNAT",dim1_id=31,dim2_id=NA,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2000,max_year=2020)

  # 'favorite_firstname_amount': '1_01_017',
  # 'inflows': '1_01_018',
  # 'inflows_per_1000_residents': '1_01_019',
  # 'departures': '1_01_020',
  # 'departures_per_1000_residents': '1_01_021',
  # 'migration_balance': '1_01_022',
  # 'migration_balance_per_1000_residents': '1_01_023',



  statbot_ind_1_02_001<-data.frame(class_id="1_02_001",class_name="employee",name_de="Beschäftigte",name_fr="Beschäftigte",
                                name_it="Beschäftigte",name_en="Employee",
                                description_de="Beschäftigte",description_fr="Beschäftigte",
                                description_it="Beschäftigte",description_en="Beschäftigte",
                                unit_short_de="Pers.",unit_short_fr="Pers.",unit_short_it="Pers.",unit_short_en="Pers.",
                                unit_long_de="Personen",unit_long_fr="Personen",unit_long_it="Personen",unit_long_en="Personen",
                                source="BFS-STATENT",dim1_id=1,dim2_id=5,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2011,max_year=2018)

  statbot_ind_1_02_002<-data.frame(class_id="1_02_002",class_name="employee_per_1000_residents",name_de="Beschäftigte pro 1000 Einwohner",name_fr="Beschäftigte pro 1000 Einwohner",
                                name_it="Beschäftigte pro 1000 Einwohner",name_en="Employee per 1000 residents",
                                description_de="Beschäftigte pro 1000 Einwohner",description_fr="Beschäftigte pro 1000 Einwohner",
                                description_it="Beschäftigte pro 1000 Einwohner",description_en="Beschäftigte pro 1000 Einwohner",
                                unit_short_de="Pers./1000 Einw.",unit_short_fr="Pers./1000 Einw.",unit_short_it="Pers./1000 Einw.",unit_short_en="Pers./1000 Einw.",
                                unit_long_de="Personen pro 1000 Einwohner",unit_long_fr="Personen pro 1000 Einwohner",unit_long_it="Personen pro 1000 Einwohner",unit_long_en="Personen pro 1000 Einwohner",
                                source="BFS-STATENT",dim1_id=1,dim2_id=5,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2011,max_year=2018)



  statbot_ind_1_02_003<-data.frame(class_id="1_02_003",class_name="fulltime_equivalent",name_de="Vollzeitäquivalente",name_fr="Vollzeitäquivalente",
                                name_it="Vollzeitäquivalente",name_en="Fulltime_equivalent",
                                description_de="Vollzeitäquivalente",description_fr="Vollzeitäquivalente",
                                description_it="Vollzeitäquivalente",description_en="Vollzeitäquivalente",
                                unit_short_de="VZÄ",unit_short_fr="VZÄ",unit_short_it="VZÄ",unit_short_en="VZÄ",
                                unit_long_de="Vollzeitäquivalente",unit_long_fr="Vollzeitäquivalente",unit_long_it="Vollzeitäquivalente",unit_long_en="Vollzeitäquivalente",
                                source="BFS-STATENT",dim1_id=1,dim2_id=5,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2015,max_year=2018)

  statbot_ind_1_02_004<-data.frame(class_id="1_02_004",class_name="fulltime_equivalent_per_1000_residents",name_de="Vollzeitäquivalente pro 1000 Einwohner",name_fr="Vollzeitäquivalente pro 1000 Einwohner",
                                name_it="Vollzeitäquivalente pro 1000 Einwohner",name_en="Fulltime equivalent per 1000 residents",
                                description_de="Vollzeitäquivalente pro 1000 Einwohner",description_fr="Vollzeitäquivalente pro 1000 Einwohner",
                                description_it="Vollzeitäquivalente pro 1000 Einwohner",description_en="Vollzeitäquivalente pro 1000 Einwohner",
                                unit_short_de="VZÄ/1000 Einw.",unit_short_fr="VZÄ/1000 Einw.",unit_short_it="VZÄ/1000 Einw.",unit_short_en="VZÄ/1000 Einw.",
                                unit_long_de="Vollzeitäquivalente pro 1000 Einwohner",unit_long_fr="Vollzeitäquivalente pro 1000 Einwohner",unit_long_it="Vollzeitäquivalente pro 1000 Einwohner",unit_long_en="Vollzeitäquivalente pro 1000 Einwohner",
                                source="BFS-STATENT",dim1_id=1,dim2_id=5,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2015,max_year=2018)

  statbot_ind_1_07_001<-data.frame(class_id="1_07_001",class_name="one_family_houses",name_de="Einfamilienhäuser",name_fr="Einfamilienhäuser",
                                   name_it="Einfamilienhäuser",name_en="One family houses",
                                   description_de="Einfamilienhäuser",description_fr="Einfamilienhäuser",
                                   description_it="Einfamilienhäuser",description_en="Einfamilienhäuser",
                                   unit_short_de="Gebäude",unit_short_fr="Gebäude",unit_short_it="Gebäude",unit_short_en="Buildings",
                                   unit_long_de="Gebäude",unit_long_fr="Gebäude",unit_long_it="Gebäude",unit_long_en="Buildings",
                                   source="BFS-GWS",dim1_id=6,dim2_id=7,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2009,max_year=2020)

  statbot_ind_1_07_002<-data.frame(class_id="1_07_002",class_name="one_family_houses_per_1000_residents",name_de="Einfamilienhäuser pro 1000 Einwohner",name_fr="Einfamilienhäuser pro 1000 Einwohner",
                                   name_it="Einfamilienhäuser pro 1000 Einwohner",name_en="One family houses per 1000 residents",
                                   description_de="Einfamilienhäuser pro 1000 Einwohner",description_fr="Einfamilienhäuser pro 1000 Einwohner",
                                   description_it="Einfamilienhäuser pro 1000 Einwohner",description_en="Einfamilienhäuser pro 1000 Einwohner",
                                   unit_short_de="Gebäude",unit_short_fr="Gebäude",unit_short_it="Gebäude",unit_short_en="Buildings",
                                   unit_long_de="Gebäude",unit_long_fr="Gebäude",unit_long_it="Gebäude",unit_long_en="Buildings",
                                   source="BFS-GWS",dim1_id=6,dim2_id=7,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2009,max_year=2020)

  statbot_ind_1_07_003<-data.frame(class_id="1_07_003",class_name="apartment_buildings",name_de="Mehrfamilienhäuser",name_fr="Mehrfamilienhäuser",
                                   name_it="Mehrfamilienhäuser",name_en="Apartment buildings",
                                   description_de="Mehrfamilienhäuser",description_fr="Mehrfamilienhäuser",
                                   description_it="Mehrfamilienhäuser",description_en="Mehrfamilienhäuser",
                                   unit_short_de="Gebäude",unit_short_fr="Gebäude",unit_short_it="Gebäude",unit_short_en="Buildings",
                                   unit_long_de="Gebäude",unit_long_fr="Gebäude",unit_long_it="Gebäude",unit_long_en="Buildings",
                                   source="BFS-GWS",dim1_id=6,dim2_id=7,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2009,max_year=2020)

  statbot_ind_1_07_004<-data.frame(class_id="1_07_004",class_name="apartment_buildings_per_1000_residents",name_de="Mehrfamilienhäuser pro 1000 Einwohner",name_fr="Mehrfamilienhäuser pro 1000 Einwohner",
                                   name_it="Mehrfamilienhäuser pro 1000 Einwohner",name_en="Apartment buildings per 1000 residents",
                                   description_de="Mehrfamilienhäuser pro 1000 Einwohner",description_fr="Mehrfamilienhäuser pro 1000 Einwohner",
                                   description_it="Mehrfamilienhäuser pro 1000 Einwohner",description_en="Mehrfamilienhäuser pro 1000 Einwohner",
                                   unit_short_de="Gebäude",unit_short_fr="Gebäude",unit_short_it="Gebäude",unit_short_en="Buildings",
                                   unit_long_de="Gebäude",unit_long_fr="Gebäude",unit_long_it="Gebäude",unit_long_en="Buildings",
                                   source="BFS-GWS",dim1_id=6,dim2_id=7,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2009,max_year=2020)

  statbot_ind_1_07_005<-data.frame(class_id="1_07_005",class_name="residential_buildings_with_secondary_use",name_de="Wohngebäude mit Nebennutzung",name_fr="Wohngebäude mit Nebennutzung",
                                   name_it="Wohngebäude mit Nebennutzung",name_en="Residential buildings with secondary use",
                                   description_de="Wohngebäude mit Nebennutzung",description_fr="Wohngebäude mit Nebennutzung",
                                   description_it="Wohngebäude mit Nebennutzung",description_en="Wohngebäude mit Nebennutzung",
                                   unit_short_de="Gebäude",unit_short_fr="Gebäude",unit_short_it="Gebäude",unit_short_en="Buildings",
                                   unit_long_de="Gebäude",unit_long_fr="Gebäude",unit_long_it="Gebäude",unit_long_en="Buildings",
                                   source="BFS-GWS",dim1_id=6,dim2_id=7,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2009,max_year=2020)

  statbot_ind_1_07_006<-data.frame(class_id="1_07_006",class_name="residential_buildings_with_secondary_use_per_1000_residents",name_de="Wohngebäude mit Nebennutzung pro 1000 Einwohner",name_fr="Wohngebäude mit Nebennutzung pro 1000 Einwohner",
                                   name_it="Wohngebäude mit Nebennutzung pro 1000 Einwohner",name_en="Residential buildings with secondary use per 1000 residents",
                                   description_de="Wohngebäude mit Nebennutzung pro 1000 Einwohner",description_fr="Wohngebäude mit Nebennutzung pro 1000 Einwohner",
                                   description_it="Wohngebäude mit Nebennutzung pro 1000 Einwohner",description_en="Wohngebäude mit Nebennutzung pro 1000 Einwohner",
                                   unit_short_de="Gebäude",unit_short_fr="Gebäude",unit_short_it="Gebäude",unit_short_en="Buildings",
                                   unit_long_de="Gebäude",unit_long_fr="Gebäude",unit_long_it="Gebäude",unit_long_en="Buildings",
                                   source="BFS-GWS",dim1_id=6,dim2_id=7,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2009,max_year=2020)

  statbot_ind_1_07_007<-data.frame(class_id="1_07_007",class_name="buildings_with_partial_residential_use",name_de="Gebäude mit teilweiser Wohnnutzung",name_fr="Gebäude mit teilweiser Wohnnutzung",
                                   name_it="Gebäude mit teilweiser Wohnnutzung",name_en="Buildings with partial residential use",
                                   description_de="Gebäude mit teilweiser Wohnnutzung",description_fr="Gebäude mit teilweiser Wohnnutzung",
                                   description_it="Gebäude mit teilweiser Wohnnutzung",description_en="Gebäude mit teilweiser Wohnnutzung",
                                   unit_short_de="Gebäude",unit_short_fr="Gebäude",unit_short_it="Gebäude",unit_short_en="Buildings",
                                   unit_long_de="Gebäude",unit_long_fr="Gebäude",unit_long_it="Gebäude",unit_long_en="Buildings",
                                   source="BFS-GWS",dim1_id=6,dim2_id=7,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2009,max_year=2020)

  statbot_ind_1_07_008<-data.frame(class_id="1_07_008",class_name="buildings_with_partial_residential_use_per_1000_residents",name_de="Gebäude mit teilweiser Wohnnutzung pro 1000 Einwohner",name_fr="Gebäude mit teilweiser Wohnnutzung pro 1000 Einwohner",
                                   name_it="Gebäude mit teilweiser Wohnnutzung pro 1000 Einwohner",name_en="Buildings with partial residential use per 1000 residents",
                                   description_de="Gebäude mit teilweiser Wohnnutzung pro 1000 Einwohner",description_fr="Gebäude mit teilweiser Wohnnutzung pro 1000 Einwohner",
                                   description_it="Gebäude mit teilweiser Wohnnutzung pro 1000 Einwohner",description_en="Gebäude mit teilweiser Wohnnutzung pro 1000 Einwohner",
                                   unit_short_de="Gebäude",unit_short_fr="Gebäude",unit_short_it="Gebäude",unit_short_en="Buildings",
                                   unit_long_de="Gebäude",unit_long_fr="Gebäude",unit_long_it="Gebäude",unit_long_en="Buildings",
                                   source="BFS-GWS",dim1_id=6,dim2_id=7,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2009,max_year=2020)

  statbot_ind_1_07_009<-data.frame(class_id="1_07_009",class_name="all_residential_buildings",name_de="Alle Wohngebäude",name_fr="Alle Wohngebäude",
                                   name_it="Alle Wohngebäude",name_en="All residential buildings",
                                   description_de="Alle Wohngebäude",description_fr="Alle Wohngebäude",
                                   description_it="Alle Wohngebäude",description_en="Alle Wohngebäude",
                                   unit_short_de="Gebäude",unit_short_fr="Gebäude",unit_short_it="Gebäude",unit_short_en="Buildings",
                                   unit_long_de="Gebäude",unit_long_fr="Gebäude",unit_long_it="Gebäude",unit_long_en="Buildings",
                                   source="BFS-GWS",dim1_id=6,dim2_id=7,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2009,max_year=2020)

  statbot_ind_1_07_010<-data.frame(class_id="1_07_010",class_name="all_residential_buildings_per_1000_residents",name_de="Alle Wohngebäude pro 1000 Einwohner",name_fr="Alle Wohngebäude pro 1000 Einwohner",
                                   name_it="Alle Wohngebäude pro 1000 Einwohner",name_en="All residential buildings per 1000 residents",
                                   description_de="Alle Wohngebäude pro 1000 Einwohner",description_fr="Alle Wohngebäude pro 1000 Einwohner",
                                   description_it="Alle Wohngebäude pro 1000 Einwohner",description_en="Alle Wohngebäude pro 1000 Einwohner",
                                   unit_short_de="Gebäude",unit_short_fr="Gebäude",unit_short_it="Gebäude",unit_short_en="Buildings",
                                   unit_long_de="Gebäude",unit_long_fr="Gebäude",unit_long_it="Gebäude",unit_long_en="Buildings",
                                   source="BFS-GWS",dim1_id=6,dim2_id=7,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2009,max_year=2020)


  # "housing": "1_07_011",
  # "housing_per_1000_residents": "1_07_012",
  # "rental_apartments": "1_07_013",
  # "rental_apartments_per_1000_residents": "1_07_014",
  # "condominium": "1_07_015",
  # "condominium_per_1000_residents": "1_07_016",
  # "building": "1_07_017",
  # "building_per_1000_residents": "1_07_018",
  # "household_size": "1_07_019",
  # "empty_dwellings_amount":"1_07_020",
  # "empty_dwellings_quote":"1_07_021",

  # 'voting_results': '1_10_001',
  # 'national_council_elections': '1_10_002'


  statbot_ind_2_03_001<-data.frame(class_id="2_03_001",class_name="workplace",name_de="Arbeitsstätten",name_fr="Arbeitsstätten",
                                name_it="Arbeitsstätten",name_en="Workplace",
                                description_de="Arbeitsstätten",description_fr="Arbeitsstätten",
                                description_it="Arbeitsstätten",description_en="Arbeitsstätten",
                                unit_short_de="Arbeitsstätten",unit_short_fr="Arbeitsstätten",unit_short_it="Arbeitsstätten",unit_short_en="Arbeitsstätten",
                                unit_long_de="Arbeitsstätten",unit_long_fr="Arbeitsstätten",unit_long_it="Arbeitsstätten",unit_long_en="Arbeitsstätten",
                                source="BFS-STATENT",dim1_id=5,dim2_id=NA,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2011,max_year=2018)

  statbot_ind_2_03_002<-data.frame(class_id="2_03_002",class_name="workplace_per_1000_residents",name_de="Arbeitsstätten pro 1000 Einwohner",name_fr="Arbeitsstätten pro 1000 Einwohner",
                                name_it="Arbeitsstätten pro 1000 Einwohner",name_en="Worklace per 1000 residents",
                                description_de="Arbeitsstätten pro 1000 Einwohner",description_fr="Arbeitsstätten pro 1000 Einwohner",
                                description_it="Arbeitsstätten pro 1000 Einwohner",description_en="Arbeitsstätten pro 1000 Einwohner",
                                unit_short_de="Arbeitsstätten pro 1000 Einwohner",unit_short_fr="Arbeitsstätten pro 1000 Einwohner",unit_short_it="Arbeitsstätten pro 1000 Einwohner",unit_short_en="Arbeitsstätten pro 1000 Einwohner",
                                unit_long_de="Arbeitsstätten pro 1000 Einwohner",unit_long_fr="Arbeitsstätten pro 1000 Einwohner",unit_long_it="Arbeitsstätten pro 1000 Einwohner",unit_long_en="Arbeitsstätten pro 1000 Einwohner",
                                source="BFS-STATENT",dim1_id=5,dim2_id=NA,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2011,max_year=2018)


  statbot_ind_2_04_4_001<-data.frame(class_id="2_04_4_001",class_name="stock_passenger_cars",name_de="Bestand Personenwagen",name_fr="Bestand Personenwagen",
                                   name_it="Bestand Personenwagen",name_en="Stock Passenger Cars",
                                   description_de="Bestand Personenwagen",description_fr="Bestand Personenwagen",
                                   description_it="Bestand Personenwagen",description_en="Bestand Personenwagen",
                                   unit_short_de="Fahrzeuge",unit_short_fr="Fahrzeuge",unit_short_it="Fahrzeuge",unit_short_en="Vehicles",
                                   unit_long_de="Fahrzeuge",unit_long_fr="Fahrzeuge",unit_long_it="Fahrzeuge",unit_long_en="Vehicles",
                                   source="ASTRA-IVZ",dim1_id=37,dim2_id=NA,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2010,max_year=2021)

  statbot_ind_2_04_4_002<-data.frame(class_id="2_04_4_002",class_name="stock_passenger_transportation_vehicles",name_de="Bestand Personentransportfahrzeuge",name_fr="Bestand Personentransportfahrzeuge",
                                     name_it="Bestand Personentransportfahrzeuge",name_en="Stock Passenger Transportation Vehicles",
                                     description_de="Bestand Personentransportfahrzeuge",description_fr="Bestand Personentransportfahrzeuge",
                                     description_it="Bestand Personentransportfahrzeuge",description_en="Bestand Personentransportfahrzeuge",
                                     unit_short_de="Fahrzeuge",unit_short_fr="Fahrzeuge",unit_short_it="Fahrzeuge",unit_short_en="Vehicles",
                                     unit_long_de="Fahrzeuge",unit_long_fr="Fahrzeuge",unit_long_it="Fahrzeuge",unit_long_en="Vehicles",
                                     source="ASTRA-IVZ",dim1_id=37,dim2_id=NA,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2010,max_year=2021)

  statbot_ind_2_04_4_003<-data.frame(class_id="2_04_4_003",class_name="stock_cargo_transportation_vehicles",name_de="Bestand Sachentransportfahrzeuge",name_fr="Bestand Sachentransportfahrzeuge",
                                     name_it="Bestand Sachentransportfahrzeuge",name_en="Stock Cargo Transportation Cars",
                                     description_de="Bestand Sachentransportfahrzeuge",description_fr="Bestand Sachentransportfahrzeuge",
                                     description_it="Bestand Sachentransportfahrzeuge",description_en="Bestand Sachentransportfahrzeuge",
                                     unit_short_de="Fahrzeuge",unit_short_fr="Fahrzeuge",unit_short_it="Fahrzeuge",unit_short_en="Vehicles",
                                     unit_long_de="Fahrzeuge",unit_long_fr="Fahrzeuge",unit_long_it="Fahrzeuge",unit_long_en="Vehicles",
                                     source="ASTRA-IVZ",dim1_id=37,dim2_id=NA,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2010,max_year=2021)

  statbot_ind_2_04_4_004<-data.frame(class_id="2_04_4_004",class_name="stock_agricultural_vehicles",name_de="Bestand Landwirtschaftsfahrzeuge",name_fr="Bestand Landwirtschaftsfahrzeuge",
                                     name_it="Bestand Landwirtschaftsfahrzeuge",name_en="Stock Agricultural Vehicles",
                                     description_de="Bestand Landwirtschaftsfahrzeuge",description_fr="Bestand Landwirtschaftsfahrzeuge",
                                     description_it="Bestand Landwirtschaftsfahrzeuge",description_en="Bestand Landwirtschaftsfahrzeuge",
                                     unit_short_de="Fahrzeuge",unit_short_fr="Fahrzeuge",unit_short_it="Fahrzeuge",unit_short_en="Vehicles",
                                     unit_long_de="Fahrzeuge",unit_long_fr="Fahrzeuge",unit_long_it="Fahrzeuge",unit_long_en="Vehicles",
                                     source="ASTRA-IVZ",dim1_id=37,dim2_id=NA,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2010,max_year=2021)

  statbot_ind_2_04_4_005<-data.frame(class_id="2_04_4_005",class_name="stock_industrial_vehicles",name_de="Bestand Industriefahrzeuge",name_fr="Bestand Industriefahrzeuge",
                                     name_it="Bestand Industriefahrzeuge",name_en="Stock Industrial Vehicles",
                                     description_de="Bestand Industriefahrzeuge",description_fr="Bestand Industriefahrzeuge",
                                     description_it="Bestand Industriefahrzeuge",description_en="Bestand Industriefahrzeuge",
                                     unit_short_de="Fahrzeuge",unit_short_fr="Fahrzeuge",unit_short_it="Fahrzeuge",unit_short_en="Vehicles",
                                     unit_long_de="Fahrzeuge",unit_long_fr="Fahrzeuge",unit_long_it="Fahrzeuge",unit_long_en="Vehicles",
                                     source="ASTRA-IVZ",dim1_id=37,dim2_id=NA,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2010,max_year=2021)

  statbot_ind_2_04_4_006<-data.frame(class_id="2_04_4_006",class_name="stock_motorcycles",name_de="Bestand Motorräder",name_fr="Bestand Motorräder",
                                     name_it="Bestand Motorräder",name_en="Stock Motorcycles",
                                     description_de="Bestand Motorräder",description_fr="Bestand Motorräder",
                                     description_it="Bestand Motorräder",description_en="Bestand Motorräder",
                                     unit_short_de="Fahrzeuge",unit_short_fr="Fahrzeuge",unit_short_it="Fahrzeuge",unit_short_en="Vehicles",
                                     unit_long_de="Fahrzeuge",unit_long_fr="Fahrzeuge",unit_long_it="Fahrzeuge",unit_long_en="Vehicles",
                                     source="ASTRA-IVZ",dim1_id=37,dim2_id=NA,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2010,max_year=2021)

  statbot_ind_2_04_4_007<-data.frame(class_id="2_04_4_007",class_name="stock_trailers",name_de="Bestand Anhänger",name_fr="Bestand Anhänger",
                                     name_it="Bestand Anhänger",name_en="Stock Trailers",
                                     description_de="Bestand Anhänger",description_fr="Bestand Anhänger",
                                     description_it="Bestand Anhänger",description_en="Bestand Anhänger",
                                     unit_short_de="Fahrzeuge",unit_short_fr="Fahrzeuge",unit_short_it="Fahrzeuge",unit_short_en="Vehicles",
                                     unit_long_de="Fahrzeuge",unit_long_fr="Fahrzeuge",unit_long_it="Fahrzeuge",unit_long_en="Vehicles",
                                     source="ASTRA-IVZ",dim1_id=37,dim2_id=NA,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2010,max_year=2021)

  statbot_ind_2_04_4_008<-data.frame(class_id="2_04_4_008",class_name="registrations_passenger_cars",name_de="Inverkehrsetzungen Personenwagen",name_fr="Inverkehrsetzungen Personenwagen",
                                     name_it="Inverkehrsetzungen Personenwagen",name_en="Registrations Passenger Cars",
                                     description_de="Inverkehrsetzungen Personenwagen",description_fr="Inverkehrsetzungen Personenwagen",
                                     description_it="Inverkehrsetzungen Personenwagen",description_en="Inverkehrsetzungen Personenwagen",
                                     unit_short_de="Fahrzeuge",unit_short_fr="Fahrzeuge",unit_short_it="Fahrzeuge",unit_short_en="Vehicles",
                                     unit_long_de="Fahrzeuge",unit_long_fr="Fahrzeuge",unit_long_it="Fahrzeuge",unit_long_en="Vehicles",
                                     source="ASTRA-IVZ",dim1_id=37,dim2_id=NA,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2010,max_year=2021)

  statbot_ind_2_04_4_009<-data.frame(class_id="2_04_4_009",class_name="registrations_passenger_transportation_vehicles",name_de="Inverkehrsetzungen Personentransportfahrzeuge",name_fr="Inverkehrsetzungen Personentransportfahrzeuge",
                                     name_it="Inverkehrsetzungen Personentransportfahrzeuge",name_en="Registrations Passenger Transportation Vehicles",
                                     description_de="Inverkehrsetzungen Personentransportfahrzeuge",description_fr="Inverkehrsetzungen Personentransportfahrzeuge",
                                     description_it="Inverkehrsetzungen Personentransportfahrzeuge",description_en="Inverkehrsetzungen Personentransportfahrzeuge",
                                     unit_short_de="Fahrzeuge",unit_short_fr="Fahrzeuge",unit_short_it="Fahrzeuge",unit_short_en="Vehicles",
                                     unit_long_de="Fahrzeuge",unit_long_fr="Fahrzeuge",unit_long_it="Fahrzeuge",unit_long_en="Vehicles",
                                     source="ASTRA-IVZ",dim1_id=37,dim2_id=NA,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2010,max_year=2021)

  statbot_ind_2_04_4_010<-data.frame(class_id="2_04_4_010",class_name="registrations_cargo_transportation_vehicles",name_de="Inverkehrsetzungen Sachentransportfahrzeuge",name_fr="Inverkehrsetzungen Sachentransportfahrzeuge",
                                     name_it="Inverkehrsetzungen Sachentransportfahrzeuge",name_en="Registrations Cargo Transportation Cars",
                                     description_de="Inverkehrsetzungen Sachentransportfahrzeuge",description_fr="Inverkehrsetzungen Sachentransportfahrzeuge",
                                     description_it="Inverkehrsetzungen Sachentransportfahrzeuge",description_en="Inverkehrsetzungen Sachentransportfahrzeuge",
                                     unit_short_de="Fahrzeuge",unit_short_fr="Fahrzeuge",unit_short_it="Fahrzeuge",unit_short_en="Vehicles",
                                     unit_long_de="Fahrzeuge",unit_long_fr="Fahrzeuge",unit_long_it="Fahrzeuge",unit_long_en="Vehicles",
                                     source="ASTRA-IVZ",dim1_id=37,dim2_id=NA,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2010,max_year=2021)

  statbot_ind_2_04_4_011<-data.frame(class_id="2_04_4_011",class_name="registrations_agricultural_vehicles",name_de="Inverkehrsetzungen Landwirtschaftsfahrzeuge",name_fr="Inverkehrsetzungen Landwirtschaftsfahrzeuge",
                                     name_it="Inverkehrsetzungen Landwirtschaftsfahrzeuge",name_en="Registrations Agricultural Vehicles",
                                     description_de="Inverkehrsetzungen Landwirtschaftsfahrzeuge",description_fr="Inverkehrsetzungen Landwirtschaftsfahrzeuge",
                                     description_it="Inverkehrsetzungen Landwirtschaftsfahrzeuge",description_en="Inverkehrsetzungen Landwirtschaftsfahrzeuge",
                                     unit_short_de="Fahrzeuge",unit_short_fr="Fahrzeuge",unit_short_it="Fahrzeuge",unit_short_en="Vehicles",
                                     unit_long_de="Fahrzeuge",unit_long_fr="Fahrzeuge",unit_long_it="Fahrzeuge",unit_long_en="Vehicles",
                                     source="ASTRA-IVZ",dim1_id=37,dim2_id=NA,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2010,max_year=2021)

  statbot_ind_2_04_4_012<-data.frame(class_id="2_04_4_012",class_name="registrations_industrial_vehicles",name_de="Inverkehrsetzungen Industriefahrzeuge",name_fr="Inverkehrsetzungen Industriefahrzeuge",
                                     name_it="Inverkehrsetzungen Industriefahrzeuge",name_en="Registrations Industrial Vehicles",
                                     description_de="Inverkehrsetzungen Industriefahrzeuge",description_fr="Inverkehrsetzungen Industriefahrzeuge",
                                     description_it="Inverkehrsetzungen Industriefahrzeuge",description_en="Inverkehrsetzungen Industriefahrzeuge",
                                     unit_short_de="Fahrzeuge",unit_short_fr="Fahrzeuge",unit_short_it="Fahrzeuge",unit_short_en="Vehicles",
                                     unit_long_de="Fahrzeuge",unit_long_fr="Fahrzeuge",unit_long_it="Fahrzeuge",unit_long_en="Vehicles",
                                     source="ASTRA-IVZ",dim1_id=37,dim2_id=NA,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2010,max_year=2021)

  statbot_ind_2_04_4_013<-data.frame(class_id="2_04_4_013",class_name="registrations_motorcycles",name_de="Inverkehrsetzungen Motorräder",name_fr="Inverkehrsetzungen Motorräder",
                                     name_it="Inverkehrsetzungen Motorräder",name_en="Registrations Motorcycles",
                                     description_de="Inverkehrsetzungen Motorräder",description_fr="Inverkehrsetzungen Motorräder",
                                     description_it="Inverkehrsetzungen Motorräder",description_en="Inverkehrsetzungen Motorräder",
                                     unit_short_de="Fahrzeuge",unit_short_fr="Fahrzeuge",unit_short_it="Fahrzeuge",unit_short_en="Vehicles",
                                     unit_long_de="Fahrzeuge",unit_long_fr="Fahrzeuge",unit_long_it="Fahrzeuge",unit_long_en="Vehicles",
                                     source="ASTRA-IVZ",dim1_id=37,dim2_id=NA,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2010,max_year=2021)

  statbot_ind_2_04_4_014<-data.frame(class_id="2_04_4_014",class_name="registrations_trailers",name_de="Inverkehrsetzungen Anhänger",name_fr="Inverkehrsetzungen Anhänger",
                                     name_it="Inverkehrsetzungen Anhänger",name_en="Registrations Trailers",
                                     description_de="Inverkehrsetzungen Anhänger",description_fr="Inverkehrsetzungen Anhänger",
                                     description_it="Inverkehrsetzungen Anhänger",description_en="Inverkehrsetzungen Anhänger",
                                     unit_short_de="Fahrzeuge",unit_short_fr="Fahrzeuge",unit_short_it="Fahrzeuge",unit_short_en="Vehicles",
                                     unit_long_de="Fahrzeuge",unit_long_fr="Fahrzeuge",unit_long_it="Fahrzeuge",unit_long_en="Vehicles",
                                     source="ASTRA-IVZ",dim1_id=37,dim2_id=NA,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2010,max_year=2021)

  # 'number_of_enterprises': '2_03_003',
  # 'number_of_enterprises_per_1000_residents': '2_03_004',

  statbot_ind_3_02_001<-data.frame(class_id="3_02_001",class_name="area",name_de="Fläche",name_fr="Fläche",
                                name_it="Fläche",name_en="Area",
                                description_de="Fläche",description_fr="Fläche",
                                description_it="Fläche",description_en="Area",
                                unit_short_de="km2",unit_short_fr="km2",unit_short_it="km2",unit_short_en="km2",
                                unit_long_de="km2",unit_long_fr="km2",unit_long_it="km2",unit_long_en="km2",
                                source="BFS-Gemeindeporträt",dim1_id=NA,dim2_id=NA,dim3_id=NA,dim4_id=NA,dim5_id=NA,dim6_id=NA,last_updated=NA,min_year=2016,max_year=2018)


  # merge all the variables starting with statbot_ind_ together
  # and before that also fill all the empty dimensions with NAs if not defined before

  out<-NULL
  for(i in ls(pat="statbot_ind_")){
    temp<-eval(as.name(i))
    #temp<-fill_dimensions_with_na(temp)
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
}
