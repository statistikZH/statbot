import os
import json
from constants import DATA_FOLDER, INDICATOR_ID_MAPPING, URL_MAPPING

def save_json(data: dict, outpath: str):
    '''
    Save dictionnary as json file
    '''
    with open(outpath, 'w') as outfile:
        json.dump(data, outfile)
    
if __name__ == "__main__":
    save_json(INDICATOR_ID_MAPPING, os.path.join(DATA_FOLDER, 'indicator_id_mapping.json'))
    save_json(URL_MAPPING, os.path.join(DATA_FOLDER, 'url_mapping.json'))