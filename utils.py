import os
import json
from typing import Union

import pandas as pd
from pyaxis import pyaxis

from constants import DATA_FOLDER, URL_MAPPING

def read_data(dataset_name: str) -> pd.DataFrame:
    '''
    Parse dataset from FSO website
    
    '''
    data = pyaxis.parse(URL_MAPPING[dataset_name], encoding='ISO-8859-2') 
    return data['DATA']


def save_data(df, metadata, dataset_name) -> None:
    '''
    Saves the processed dataframe and its metadata
    '''
    # save as csv
    df.to_csv(
        os.path.join(DATA_FOLDER, dataset_name + '.csv'), 
        index=False, 
        na_rep='NA'
    )
    
    # save as dictionnary
    with open(os.path.join(DATA_FOLDER, dataset_name + '.json'), 'w') as outfile:
        json.dump(metadata, outfile)
        

def map_name_to_number(
    df: pd.DataFrame, 
    columns_to_map: list
) -> Union[pd.DataFrame, dict[str, str]]:
    '''
    Maps dataframe's columns to integer and create mapping dictionnary
    Parameters:
        - df: dataframe whose columns need to be mapped
        - columns_to_map: list of names of the columns to map
    
    Returns:
        - df: dataframe with integer instead of strings in columns_to_map
        - metadata: dictionnary containing metadata 
    '''
    metadata = {}
    for col in columns_to_map:
        conversion_dict = {}
        metadata_col = {}
        options = set(df[col])
        for i, option in enumerate(options):
            conversion_dict[option] = i
            metadata_col[i] = option
        df[col] = df[col].map(conversion_dict)
        metadata[col] = metadata_col
    return df, metadata
