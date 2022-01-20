import pandas as pd

def convert_current_to_hist_id(df, reference_point,path):
    # read cols from csv
    spatial_unit_table = pd.read_csv(path, usecols=["spatialunit_ontology","spatialunit_hist_id","spatialunit_current_id","valid_from","valid_until"])
    # convert to datetime
    spatial_unit_table['valid_from'] = pd.to_datetime(spatial_unit_table['valid_from'], format = '%Y-%m-%d')
    # check for values too big for datetime
    spatial_unit_table.loc[spatial_unit_table['valid_until'] == '2999-12-31', 'valid_until'] = '2262-04-11'
    # convert to datetime
    spatial_unit_table['valid_until'] = pd.to_datetime(spatial_unit_table['valid_until'], format = '%Y-%m-%d')

    # convert to datetime
    reference_point = pd.to_datetime(reference_point, format = '%Y-%m-%d')
                                   
    #spatial_unit_table = spatial_unit_table.loc[spatial_unit_table['valid_from'] <= reference_point <= spatial_unit_table['valid_until']]
    
    
    mask = (spatial_unit_table['valid_from']  <= reference_point) & (spatial_unit_table['valid_until']  >= reference_point)
    
    spatial_unit_table = spatial_unit_table.loc[mask]
    
    df['spatialunit_ontology'] = df['spatialunit_ontology'].astype(str)
    spatial_unit_table['spatialunit_ontology'] = spatial_unit_table['spatialunit_ontology'].astype(str)

    df['spatialunit_current_id'] = df['spatialunit_current_id'].astype('Int64')
    spatial_unit_table['spatialunit_current_id'] = spatial_unit_table['spatialunit_current_id'].astype('Int64')

    df = pd.merge(df, spatial_unit_table, how='left', on=['spatialunit_ontology', 'spatialunit_current_id'])
    
    df = df.drop(columns=['valid_from', 'valid_until', 'spatialunit_current_id'])
  
    return df