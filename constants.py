# Spatial units ontology (geoname such as here http://www.geonames.org/ontology)
SPATIAL_UNIT_ONTOLOGY = {
    'COUNTRY': 'CH',
    'CANTONS': 'A.ADM1',
    'DISTRICT': 'A.ADM2',
    'REGION': 'A.ADM2H',
    'COMMUNITY': 'A.ADM3',
    'RESIDENTIAL_AREA': 'A.ADM4'
}

# Spatial unit id (bfs-id of the respective granularity. bfs-nr or communes, bfs-26 for cantons )
TIME_INFO_ID = {
    'YEAR': 1,
    'MONTH': 2,
    'QUARTER': 3,
    'WEEK_NUMBER': 4,
    'DAY': 5,
    'TIME': 6
}

# Time elements


# Indicator ID
INDICATOR_ID_MAPPING = {
    'resident_population': '1_01_001',
    'population_density': '1_01_002',
    'foreigner_proportion': '1_01_003',
    'nativity': '1_01_004',
    'nativity_per_1000_residents': '1_01_005',
    'death': '1_01_006',
    'death_per_1000_residents': '1_01_112',
    'marriage': '1_01_121',
    'marriage_per_1000_residents': '1_01_122',
    'divorce': '1_01_131',
    'divorce_per_1000_residents': '1_01_132',
    'civil_union': '1_01_141',
    'civil_union_per_1000_residents': '1_01_142',
    'stillbirth': '1_01_151',
    'stillbirth_per_1000_residents': '1_01_152',
    'favorite_firstname': '1_01_161',
    'inflows': '1_01_201',
    'inflows_per_1000_residents': '1_01_202',
    'departures': '1_01_211',
    'departures_per_1000_residents': '1_01_212',
    'migration_balance': '1_01_221',
    'migration_balance_per_1000_residents': '1_01_222',
    'workplace': '2_03_001',
    'workplace_per_1000_residents': '2_03_002',
    'employee': '1_02_001',
    'employee_per_1000_residents': '1_02_002',
    'fulltime_equivalent': '1_02_101',
    'fulltime_equivalent_per_1000_residents': '1_02_102',
    'number_of_enterprises': '2_03_101',
    'number_of_enterprises_per_1000_residents': '2_03_102',
    'housing': '1_07_001',
    'housing_per_1000_residents': '1_07_002',
    'rental_apartments': '1_07_003',
    'rental_apartments_per_1000_residents': '1_07_003',
    'condominium': '1_07_005',
    'condominium_per_1000_residents': '1_07_006',
    'building': '1_07_101',
    'building_per_1000_residents': '1_07_102',
    'one_family_house': '1_07_201',
    'one_family_house_per_1000_residents': '1_07_202',
    'apartment_building': '1_07_203',
    'apartment_building_per_1000_residents': '1_07_204',
    'household_size': '1_07_301',
    'area': '3_02_001',
    'voting_results': '1_10_001'
    'national_council_elections': '1_10_101'
}


# URL Mapping 
URL_MAPPING = {
    'resident_population': 'TBD',
    'population_density': 'TBD',
    'foreigner_proportion': 'TBD',
    'nativity': 'https://www.bfs.admin.ch/bfsstatic/dam/assets/17664382/master',
    'nativity_per_1000_resident': 'TBD',
    'death': 'TBD',
    'death_per_1000_resident': 'TBD',
    'marriage': 'TBD',
    'marriage_per_1000_resident': 'TBD',
    'divorce': 'TBD',
    'divorce_per_1000_resident': 'TBD',
    'civil_union': 'TBD',
    'civil_union_per_1000_resident': 'TBD',
    'stillbirth': 'TBD',
    'stillbirth_per_1000_resident': 'TBD',
    'national_council_elections': 'https://www.bfs.admin.ch/bfsstatic/dam/assets/12948000/master'
}
