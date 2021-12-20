import os

# Constants
BFS_HOME = "https://www.bfs.admin.ch"

# Data folders
DATA_FOLDER = '../data'
INDICATOR_ID_MAPPING_PATH = os.path.join(DATA_FOLDER, 'indicator_mapping.csv')
URL_MAPPING_PATH = os.path.join(DATA_FOLDER, 'url_mapping.csv')

# Spatial units ontology (geoname such as here http://www.geonames.org/ontology)
SPATIAL_UNIT_ONTOLOGY = {
    'COUNTRY': 'CH',
    'CANTONS': 'A.ADM1',
    'DISTRICT': 'A.ADM2',
    'REGION': 'A.ADM2H',
    'COMMUNITY': 'A.ADM3',
    'RESIDENTIAL_AREA': 'A.ADM4'
}

# Spatial unit id 
TIME_INFO_ID = {
    'REFERENCE_DAY': 1, 
    'DURATION': 2
}

# Indicator ID
INDICATOR_ID_MAPPING = {
    'resident_population': '1_01_001',
    'population_density': '1_01_002',
    'foreigner_proportion': '1_01_003',
    'nativity': '1_01_004',
    'nativity_per_1000_residents': '1_01_005',
    'death': '1_01_006',
    'death_per_1000_residents': '1_01_007',
    'marriage': '1_01_008',
    'marriage_per_1000_residents': '1_01_009',
    'divorce': '1_01_010',
    'divorce_per_1000_residents': '1_01_011',
    'civil_union': '1_01_012',
    'civil_union_per_1000_residents': '1_01_013',
    'stillbirth': '1_01_014',
    'stillbirth_per_1000_residents': '1_01_015',
    'favorite_firstname': '1_01_016',
    'inflows': '1_01_017',
    'inflows_per_1000_residents': '1_01_018',
    'departures': '1_01_019',
    'departures_per_1000_residents': '1_01_020',
    'migration_balance': '1_01_021',
    'migration_balance_per_1000_residents': '1_01_022',
    'employee': '1_02_001',
    'employee_per_1000_residents': '1_02_002',
    'fulltime_equivalent': '1_02_003',
    'fulltime_equivalent_per_1000_residents': '1_02_004',
    'housing': '1_07_001',
    'housing_per_1000_residents': '1_07_002',
    'rental_apartments': '1_07_003',
    'rental_apartments_per_1000_residents': '1_07_004',
    'condominium': '1_07_005',
    'condominium_per_1000_residents': '1_07_006',
    'building': '1_07_007',
    'building_per_1000_residents': '1_07_008',
    'one_family_house': '1_07_009',
    'one_family_house_per_1000_residents': '1_07_010',
    'apartment_building': '1_07_011',
    'apartment_building_per_1000_residents': '1_07_012',
    'household_size': '1_07_013',
    'voting_results': '1_10_001',
    'national_council_elections': '1_10_002'
    'workplace': '2_03_001',
    'workplace_per_1000_residents': '2_03_002',
    'number_of_enterprises': '2_03_003',
    'number_of_enterprises_per_1000_residents': '2_03_004',
    'area': '3_02_001',
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
    '': 'TBD',
    '': 'TBD',
    '': 'TBD',
    # etc
    'national_council_elections': 'https://www.bfs.admin.ch/bfsstatic/dam/assets/12948000/master'
}
