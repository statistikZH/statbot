#!/usr/bin/env python
# coding: utf-8


from pyaxis import pyaxis
import pandas as pd
import sys

# load data from bfs

URL = 'https://www.bfs.admin.ch/bfsstatic/dam/assets/18404679/master'
px = pyaxis.parse(URL, encoding='ISO-8859-2')


# filter for 'gemeinden' and 'ständige wohnbevölkerung'

gemeinden = px['DATA'].loc[px['DATA']['Kanton (-) / Bezirk (>>) / Gemeinde (......)'].str.contains(r'[0-6][0-9][0-9][0-9]') & 
                           (px['DATA']['Bevölkerungstyp'] == 'Ständige Wohnbevölkerung')]

gemeinden = gemeinden.drop(columns=['Bevölkerungstyp'])

gemeinden = gemeinden.rename(columns={"Kanton (-) / Bezirk (>>) / Gemeinde (......)": "name_de"})


# reduce memory usage

gemeinden[['name_de', 'Staatsangehörigkeit (Kategorie)', 'Geschlecht']] = gemeinden[['name_de','Staatsangehörigkeit (Kategorie)', 
                                                                                              'Geschlecht']].astype('category')
gemeinden['DATA'] = gemeinden['DATA'].astype('int32')

gemeinden['Alter'] = gemeinden['Alter'].str.split(" ", n=1, expand=True)[0]
gemeinden.loc[gemeinden['Alter'] == 'Alter', 'Alter'] = '-1'

gemeinden[['Jahr', 'Alter']] = gemeinden[['Jahr', 'Alter']].astype('int16')

gemeinden.memory_usage().sum() / (1024**2)


# create new dataframe

df_11_11001 = pd.DataFrame(columns=["indicator_id","spatialunit_id","time_value","timeinfo_id",
                                    "value","dim1_value_id","dim2_value_id","dim3_value_id","dim4_value_id"])

# fill in dim1_value_id 

gemeinden.loc[gemeinden['Geschlecht'] == 'Geschlecht - Total', 'dim1_value_id'] = '0'
gemeinden.loc[gemeinden['Geschlecht'] == 'Mann', 'dim1_value_id'] = '1'
gemeinden.loc[gemeinden['Geschlecht'] == 'Frau', 'dim1_value_id'] = '2'

df_11_11001['dim1_value_id'] = gemeinden['dim1_value_id']

gemeinden = gemeinden.drop(columns=['Geschlecht', 'dim1_value_id'])


# fill in dim2_value_id

gemeinden.loc[gemeinden['Staatsangehörigkeit (Kategorie)'] == 'Staatsangehörigkeit (Kategorie) - Total', 'dim2_value_id'] = '0'
gemeinden.loc[gemeinden['Staatsangehörigkeit (Kategorie)'] == 'Schweiz', 'dim2_value_id'] = '1'
gemeinden.loc[gemeinden['Staatsangehörigkeit (Kategorie)'] == 'Ausland', 'dim2_value_id'] = '2'

df_11_11001['dim2_value_id'] = gemeinden['dim2_value_id']

gemeinden = gemeinden.drop(columns=['Staatsangehörigkeit (Kategorie)', 'dim2_value_id'])


# fill in dim3_value_id

df_11_11001['dim3_value_id'] = gemeinden['Alter']

gemeinden = gemeinden.drop(columns=['Alter'])



df_11_11001['value'] = gemeinden['DATA']  # fill in value

df_11_11001['indicator_id'] = 11001  # fill in indicator_id

df_11_11001['time_value'] = gemeinden['Jahr']  # fill in time_value

df_11_11001['timeinfo_id'] = 1  # fill in timeinfo_id

df_11_11001['spatialunit_id'] = gemeinden['name_de'].str.slice(6,11) # fill in spatialunit_id
 
gemeinden = gemeinden.drop(columns=['DATA', 'Jahr'])


# cast as Int64

df_11_11001[["indicator_id","spatialunit_id","time_value","timeinfo_id","value",
             "dim1_value_id","dim2_value_id","dim3_value_id","dim4_value_id"]] = df_11_11001[["indicator_id","spatialunit_id","time_value","timeinfo_id","value",
                                                                                              "dim1_value_id","dim2_value_id","dim3_value_id","dim4_value_id"]].astype('float').astype('Int64')

# export as csv

df_11_11001.to_csv("11_11001.csv", index=False, na_rep='NA')

sys.exit(0)
