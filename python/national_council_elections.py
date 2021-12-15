import pandas as pd

from constants import INDICATOR_ID_MAPPING, SPATIAL_UNIT_ONTOLOGY, TIME_INFO_ID
from utils import map_name_to_number, read_data, save_data


def prepare_national_council_elections() -> None:
    '''
    Prepares the national_council_elections dataset
    from FSO website to dataframe
    '''
    dataset_name = 'national_council_elections'
    df = read_data(dataset_name)

    # Specific column name translations
    df = df.rename(columns={
        'Kanton (-) / Bezirk (>>) / Gemeinde (......)': 'name_de', 
        'Jahr': 'year', 
        'Ergebnisse': 'results', 
        'DATA': 'data'
    })

    # Specific data handling
    df['name_de'] = df['name_de'].str.replace('.', '')
    df['name_de'] = df['name_de'].str.replace('>> ', '')
    df['name_de'] = df['name_de'].str.replace('   ', '')

    # Map columns
    df, metadata = map_name_to_number(df, columns_to_map=['results'])

    # Create new dataframe
    df_new = pd.DataFrame({
        'indicator_id': INDICATOR_ID_MAPPING[dataset_name],
        'spatialunit_name': df['name_de'],
        'spatialunit_id': 'TODO', # TODO once list is done
        'time_value': df['year'],
        'timeinfo_id': TIME_INFO_ID['REFERENCE_DAY'],
        'results': df['results'],
        'value': df['data']
    })

    # Save data and metadata in specific files
    save_data(df_new, metadata, dataset_name)
    
if __name__ == "__main__":
    prepare_national_council_elections()