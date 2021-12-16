import os
import json
import pandas as pd
from constants import INDICATOR_ID_MAPPING, INDICATOR_ID_MAPPING_PATH, URL_MAPPING, URL_MAPPING_PATH

def save_mapping(data: dict, outpath: str):
    '''
    Save mapping as a csv file
    '''
    df = pd.DataFrame({
        'indicators': list(data.keys()),
        'value': list(data.values())
    })
    df.to_csv(outpath, header=True, index=False)
    
if __name__ == "__main__":
    save_mapping(INDICATOR_ID_MAPPING, INDICATOR_ID_MAPPING_PATH)
    save_mapping(URL_MAPPING, URL_MAPPING_PATH)