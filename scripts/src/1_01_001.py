#!/usr/bin/env python
# coding: utf-8

# In[1]:


import subprocess
repo_dir = subprocess.Popen(['git', 'rev-parse', '--show-toplevel'], stdout=subprocess.PIPE).communicate()[0].rstrip().decode('utf-8')


# In[2]:


import sys 
sys.path.append(repo_dir) # go to parent dir from customFunctions import *
import statbot_helpers as sbh
from pyaxis import pyaxis
import pandas as pd
import numpy as np
import os
import requests
import json


# In[3]:


# bfs_nr of dataset
BFS_NR = 'px-x-0102010000_101'

STICHTAG =  '-12-31' # -%m-%d

# get asset_nr
asset_nr = sbh.get_bfs_asset_nr(BFS_NR)
BFS_URL = "https://www.bfs.admin.ch/bfsstatic/dam/assets/" + str(asset_nr) + "/master"

file_name="bfs_1_01_001_CH.px"

# download cube
r = requests.get(BFS_URL)
open(os.path.join(repo_dir,"temp/"+file_name), 'wb').write(r.content)


# In[4]:


# load data from bfs
px = pyaxis.parse(os.path.join(repo_dir,"temp/"+file_name), encoding='ISO-8859-2')


# In[5]:


# clean df
df = px['DATA'].loc[px['DATA']['Bevölkerungstyp'] == 'Ständige Wohnbevölkerung']
df = df.drop(columns=['Bevölkerungstyp'])
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
df.loc[df['Staatsangehörigkeit (Kategorie)'] == 'Staatsangehörigkeit (Kategorie) - Total', 'Staatsangehörigkeit (Kategorie)'] = '-1'
df.loc[df['Staatsangehörigkeit (Kategorie)'] == 'Schweiz', 'Staatsangehörigkeit (Kategorie)'] = '1'
df.loc[df['Staatsangehörigkeit (Kategorie)'] == 'Ausland', 'Staatsangehörigkeit (Kategorie)'] = '2'

# convert sex
df.loc[df['Geschlecht'] == 'Geschlecht - Total', 'Geschlecht'] = '-1'
df.loc[df['Geschlecht'] == 'Mann', 'Geschlecht'] = '1'
df.loc[df['Geschlecht'] == 'Frau', 'Geschlecht'] = '2'

df['Geschlecht'] = df['Geschlecht'].astype('category') # reduce memory footprint


# convert age
df['Alter'] = df['Alter'].str.split(" ", n=1, expand=True)[0]
df.loc[df['Alter'] == 'Alter', 'Alter'] = '-1'

df['DATA'] = df['DATA'].astype('int32')
df['Alter'] = df['Alter'].astype('int16')

maximum=max(df['Jahr'])
df['Jahr'] += STICHTAG

df['period_value'] = np.NAN

df.columns = ['time_value', 'spatialunit_name', 'origin', 'sex', 'age', 
              'value', 'spatialunit_ontology', 'spatialunit_current_id', 'period_value']

df = df[['spatialunit_ontology', 'spatialunit_name', 
         'time_value', 'period_value', 'value', 'origin', 'sex', 'age', 'spatialunit_current_id']]


# In[6]:


spatial_reference=str(maximum)+"-10-18"
#spatial_reference

df_clean = sbh.convert_current_to_hist_id(df, spatial_reference, os.path.join(repo_dir,"data/spatialunits.csv"))

df_try = df_clean.copy()

#print(df_try.shape)

#print(df_try['spatialunit_hist_id'].isnull().sum())

list_ontologies = ['A.ADM2', 'A.ADM1', 'CH']

list_dimensions = ['origin', 'sex', 'age']

#df_adm2 = sbh.add_granularity_levels_up(df_try,list_ontologies, repo_dir, list_dimensions)

df_new = sbh.add_granularity_levels_up(df_try, list_ontologies, repo_dir, list_dimensions)


# In[7]:


#df_new[df_new['spatialunit_name'].isnull()]['spatialunit_hist_id'].unique()


# In[12]:


#df_new


# In[13]:


df_new.to_csv(os.path.join(repo_dir,"data/11_11001.csv"), index=False, na_rep='NA')

sys.exit(0)


# In[ ]:




