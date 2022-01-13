import pandas as pd


def translate_to_spatial_unit_name(df,language,path):
    if not (language in ["de","fr","it","en"]):
        print("not a correct language selected.\n") 
        sys.exit(1)

    spatial_unit_table = pd.read_csv(path, usecols=["spatialunit_ontology","spatialunit_hist_id","spatialunit_name_"+language])

    df_temp = pd.merge(df, spatial_unit_table, how='left', on=['spatialunit_ontology', 'spatialunit_hist_id'])
    
    
    return df_temp["spatialunit_name_"+language]