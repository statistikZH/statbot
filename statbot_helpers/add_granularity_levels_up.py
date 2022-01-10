import pandas as pd
import numpy as np
import os

def add_granularity_levels_up(df,list_ontologies, path, list_dimensions = None):

    spatial_unit_table = pd.read_csv(os.path.join(path,"data/spatialunits.csv"), 
                                 usecols=["spatialunit_ontology","spatialunit_hist_id","canton_hist_id","district_hist_id"])

    spatial_unit_table[['canton_hist_id', 'district_hist_id']] = spatial_unit_table[['canton_hist_id', 'district_hist_id']].astype('Int64')


    df_out = df.copy()

    df = df[df['spatialunit_ontology'] == 'A.ADM3']

    df = pd.merge(df, spatial_unit_table, how='left', on=['spatialunit_ontology', 'spatialunit_hist_id'])


    if 'A.ADM2' in list_ontologies:
        list_to_group = ["district_hist_id","time_value"] + list_dimensions
        df_adm2 = df.groupby(by=list_to_group)['value'].sum()
        df_adm2['spatialunit_ontology'] = 'A.ADM2'
        df_adm2['spatialunit_hist_id'] = spatial_unit_table['district_hist_id']
        #df_adm2['spatialunit_name'] = translate_to_spatial_unit_name(df_asdm2, "de")
        df_adm2['period_value'] = np.NAN
        df_out =  df_out.append(df_adm2)
    
    
    
    return df_out