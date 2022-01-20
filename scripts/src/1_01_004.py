#!/usr/bin/env python
# coding: utf-8


import subprocess
repo_dir = subprocess.Popen(['git', 'rev-parse', '--show-toplevel'], stdout=subprocess.PIPE).communicate()[0].rstrip().decode('utf-8')

import sys 
sys.path.append(repo_dir) # go to parent dir from customFunctions import *
import statbot_helpers as sbh
from pyaxis import pyaxis
import pandas as pd
import numpy as np
import os
import requests
import json

# bfs_nr of dataset
BFS_NR = 'px-x-0102020204_102'

STICHTAG =  '-12-31' # -%m-%d

# get asset_nr
asset_nr = sbh.get_bfs_asset_nr(BFS_NR)
BFS_URL = "https://www.bfs.admin.ch/bfsstatic/dam/assets/" + str(asset_nr) + "/master"

file_name="bfs_1_01_001_CH.px"

# download cube
r = requests.get(BFS_URL)
open(os.path.join(repo_dir,"temp/"+file_name), 'wb').write(r.content)

# load data from bfs
px = pyaxis.parse(os.path.join(repo_dir,"temp/"+file_name), encoding='ISO-8859-2')

# clean df
df = px['DATA']#.loc[px['DATA']
df = df.rename(columns={"Kanton (-) / Bezirk (>>) / Gemeinde (......)": "name"})

# add column with spatialunit_ontology
df.loc[df['name'].str.startswith("......"), "spatialunit_ontology"] = "A.ADM3"
#df.loc[df['name'].str.startswith(">>"), "spatialunit_ontology"] = "A.ADM2"
#df.loc[df['name'].str.startswith("-"), "spatialunit_ontology"] = "A.ADM1"
#df.loc[df['name'].str.startswith("Schweiz"), "spatialunit_ontology"] = "CH"

df = df.dropna(subset=['spatialunit_ontology'])

df['spatialunit_ontology'] = df['spatialunit_ontology'].astype('category') # reduce memory footprint

# extract bfs_nr and name for gemeinde
df.loc[df['spatialunit_ontology'] == 'A.ADM3', 'bfs_nr'] = df['name'].str.slice(6,11)
df.loc[df['spatialunit_ontology'] == 'A.ADM3', 'name'] = df['name'].str.slice(11)

df['bfs_nr'] = df['bfs_nr'].astype('int16')     
                    
# extract name for bezirk
#df.loc[df['spatialunit_ontology'] == 'A.ADM2', 'name'] = df['name'].str.slice(3)

# extract name for kanton
#df.loc[df['spatialunit_ontology'] == 'A.ADM1', 'name'] = df['name'].str.slice(2)

# convert origin
df.loc[df['Staatsangehörigkeit (Kategorie) des Kindes'] == 'Staatsangehörigkeit des Kindes - Total', 'Staatsangehörigkeit (Kategorie) des Kindes'] = '-1'
df.loc[df['Staatsangehörigkeit (Kategorie) des Kindes'] == 'Schweiz', 'Staatsangehörigkeit (Kategorie) des Kindes'] = '1'
df.loc[df['Staatsangehörigkeit (Kategorie) des Kindes'] == 'Ausland', 'Staatsangehörigkeit (Kategorie) des Kindes'] = '2'

# convert sex
df.loc[df['Geschlecht des Kindes'] == 'Geschlecht des Kindes - Total', 'Geschlecht des Kindes'] = '-1'
df.loc[df['Geschlecht des Kindes'] == 'Knabe', 'Geschlecht des Kindes'] = '1'
df.loc[df['Geschlecht des Kindes'] == 'Mädchen', 'Geschlecht des Kindes'] = '2'

df['Geschlecht des Kindes'] = df['Geschlecht des Kindes'].astype('category') # reduce memory footprint


# convert age   
df['Altersklasse der Mutter'] = df['Altersklasse der Mutter'].str.split(" ", n=1, expand=True)[0]                    
df.loc[df['Altersklasse der Mutter'] == 'Altersklasse', 'Altersklasse der Mutter'] = '-1'
df.loc[df['Altersklasse der Mutter'] == 'Unter', 'Altersklasse der Mutter'] = '1'
df.loc[df['Altersklasse der Mutter'] == '25-29', 'Altersklasse der Mutter'] = '2'
df.loc[df['Altersklasse der Mutter'] == '30-34', 'Altersklasse der Mutter'] = '3'
df.loc[df['Altersklasse der Mutter'] == '35-39', 'Altersklasse der Mutter'] = '4'
df.loc[df['Altersklasse der Mutter'] == '40', 'Altersklasse der Mutter'] = '5'


df['DATA'] = df['DATA'].astype('int32')
df['Altersklasse der Mutter'] = df['Altersklasse der Mutter'].astype('int32')

maximum=max(df['Jahr'])
df['Jahr'] += STICHTAG

df['period_value'] = np.NAN


df.columns = ['time_value', 'spatialunit_name', 'gender', 'origin', 'age_classes_of_mother', 
              'value', 'spatialunit_ontology', 'spatialunit_current_id', 'period_value']

df = df[['spatialunit_ontology', 'spatialunit_name', 
         'time_value', 'period_value', 'value', 'origin', 'gender', 'age_classes_of_mother', 'spatialunit_current_id']]


spatial_reference=str(maximum)+"-10-18"

df_clean = sbh.convert_current_to_hist_id(df, spatial_reference, os.path.join(repo_dir,"data/spatialunits.csv"))

list_ontologies = ['A.ADM2', 'A.ADM1', 'CH']
list_dimensions = ['origin', 'gender', 'age_classes_of_mother']

df_new = sbh.add_granularity_levels_up(df_clean, list_ontologies, repo_dir, list_dimensions)

# checks
#df_new['age_classes_of_mother'].isnull().sum()
#df_new[df_new['spatialunit_name'].isnull()]['spatialunit_hist_id'].unique()

# export csv
df_new.to_csv(os.path.join(repo_dir,"data/11_11004.csv"), index=False, na_rep='NA')

sys.exit(0)


# In[ ]:




