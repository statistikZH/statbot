import pandas as pd

def convert_current_to_hist_id(df, reference_point,path):
    spatial_unit_table = pd.read_csv(path, usecols=["spatialunit_ontology","spatialunit_hist_id","spatialunit_current_id","valid_from","valid_until"])
  
    spatial_unit_table['valid_from'] = pd.to_datetime(spatial_unit_table['valid_from'], format = '%Y-%m-%d')
    
    spatial_unit_table.loc[spatial_unit_table['valid_until'] == '2999-12-31', 'valid_until'] = '2262-04-11'

    spatial_unit_table['valid_until'] = pd.to_datetime(spatial_unit_table['valid_until'], format = '%Y-%m-%d')

  
    reference_point = pd.to_datetime(reference_point, format = '%Y-%m-%d')
                                   
    #spatial_unit_table = spatial_unit_table.loc[spatial_unit_table['valid_from'] <= reference_point <= spatial_unit_table['valid_until']]
    
    mask = (spatial_unit_table['valid_until']  >= reference_point)  &  (spatial_unit_table['valid_from']  <= reference_point)
  
    spatial_unit_table = spatial_unit_table.loc[mask]

  
    #df<-merge(df,spatial_unit_table,by=c("spatialunit_ontology","spatialunit_current_id"),all.x=T,sort=F)

    df['spatialunit_ontology'] = df['spatialunit_ontology'].astype(str)
    spatial_unit_table['spatialunit_ontology'] = spatial_unit_table['spatialunit_ontology'].astype(str)

    df['spatialunit_current_id'] = df['spatialunit_current_id'].astype('int16')
    spatial_unit_table['spatialunit_current_id'] = spatial_unit_table['spatialunit_current_id'].astype('int16')

    df = pd.merge(df, spatial_unit_table, how='left', on=['spatialunit_ontology', 'spatialunit_current_id'])
  
    df = df.drop(columns=['valid_from', 'valid_until'])
  
    return df

