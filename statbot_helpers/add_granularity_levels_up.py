import pandas as pd
import numpy as np
import os
import json
import sys 
import statbot_helpers as sbh

def add_granularity_levels_up(df,list_ontologies, path, list_dimensions = None):

    spatial_unit_table = pd.read_csv(os.path.join(path,"data/spatialunits.csv"), 
                                 usecols=["spatialunit_ontology","spatialunit_hist_id","canton_hist_id","district_hist_id"])

    spatial_unit_table[['canton_hist_id', 'district_hist_id']] = spatial_unit_table[['canton_hist_id', 'district_hist_id']].astype('Int64')


    df_out = df.copy()

    df = df[df['spatialunit_ontology'] == 'A.ADM3']

    df = pd.merge(df, spatial_unit_table, how='left', on=['spatialunit_ontology', 'spatialunit_hist_id'])

    with open(os.path.join(path,"constants/"+"constants.json")) as f:
        GLOBAL_TOTAL_LIST = json.load(f)

    allcols = list(GLOBAL_TOTAL_LIST['GLOBAL_TOTAL_LIST']) + list_dimensions
    
    if 'A.ADM2' in list_ontologies:
        list_to_group = ["district_hist_id","time_value"] + list_dimensions
        df_adm2 = df.groupby(by=list_to_group).agg({'value': ['sum']}).reset_index()
        df_adm2['spatialunit_ontology'] = 'A.ADM2'
        df_adm2['spatialunit_hist_id'] = df_adm2['district_hist_id']
        df_adm2['spatialunit_name'] = sbh.translate_to_spatial_unit_name(df_adm2, "de", os.path.join(path,"data/spatialunits.csv"))
        df_adm2['period_value'] = np.NAN
        df_adm2 = df_adm2[allcols]
        #df_out = df_out[allcols]
    
        df_adm2.columns = allcols
    
        df_out =  df_out.append(df_adm2, ignore_index=True)
    
    return df_out