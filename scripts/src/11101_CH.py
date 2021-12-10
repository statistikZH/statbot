#!/usr/bin/python
# -*- coding: utf-8 -*-

from pyaxis import pyaxis
import pandas as pd
import sys


# load data from bfs

URL = 'https://www.bfs.admin.ch/bfsstatic/dam/assets/17664382/master'

px = pyaxis.parse(URL, encoding='ISO-8859-2')

geburten = px['DATA']

# rename 'Kanton (-) / Bezirk (>>) / Gemeinde (......)' to 'name_de'

geburten = geburten.rename(columns={'Kanton (-) / Bezirk (>>) / Gemeinde (......)': 'name_de'})

# filter for gemeinden

geburten = geburten.loc[geburten['name_de'].str.contains(r'[0-6][0-9][0-9][0-9]')]

# convert values 'name_de' to id

geburten['name_de'] = geburten['name_de'].str.slice(6, 11)

# rename 'Total' values

geburten.loc[geburten['Geschlecht des Kindes'].str.contains('Total',
             na=False), 'Geschlecht des Kindes'] = 'Total'
geburten.loc[geburten['Staatsangehörigkeit (Kategorie) des Kindes'
             ].str.contains('Total', na=False),
             'Staatsangehörigkeit (Kategorie) des Kindes'] = 'Total'
geburten.loc[geburten['Altersklasse der Mutter'].str.contains('Total',
             na=False), 'Altersklasse der Mutter'] = 'Total'

# convert values 'Geschlecht des Kindes' to id

geburten.loc[geburten['Geschlecht des Kindes'].str.contains('Total',
             na=False), 'Geschlecht des Kindes'] = 0
geburten.loc[geburten['Geschlecht des Kindes'].str.contains('Knabe',
             na=False), 'Geschlecht des Kindes'] = 1
geburten.loc[geburten['Geschlecht des Kindes'].str.contains('Mädchen',
             na=False), 'Geschlecht des Kindes'] = 2


# convert values 'Staatsangehörigkeit (Kategorie) des Kindes' to id

geburten.loc[geburten['Staatsangehörigkeit (Kategorie) des Kindes'
             ].str.contains('Total', na=False),
             'Staatsangehörigkeit (Kategorie) des Kindes'] = 0
geburten.loc[geburten['Staatsangehörigkeit (Kategorie) des Kindes'
             ].str.contains('Schweiz', na=False),
             'Staatsangehörigkeit (Kategorie) des Kindes'] = 1
geburten.loc[geburten['Staatsangehörigkeit (Kategorie) des Kindes'
             ].str.contains('Ausland', na=False),
             'Staatsangehörigkeit (Kategorie) des Kindes'] = 2

# convert values 'Altersklasse der Mutter' to id

geburten.loc[geburten['Altersklasse der Mutter'].str.contains('Total',
             na=False), 'Altersklasse der Mutter'] = 0
geburten.loc[geburten['Altersklasse der Mutter'].str.contains('Unter',
             na=False), 'Altersklasse der Mutter'] = 1
geburten.loc[geburten['Altersklasse der Mutter'].str.contains('29',
             na=False), 'Altersklasse der Mutter'] = 2
geburten.loc[geburten['Altersklasse der Mutter'].str.contains('34',
             na=False), 'Altersklasse der Mutter'] = 3
geburten.loc[geburten['Altersklasse der Mutter'].str.contains('39',
             na=False), 'Altersklasse der Mutter'] = 4
geburten.loc[geburten['Altersklasse der Mutter'].str.contains('40',
             na=False), 'Altersklasse der Mutter'] = 5

geburten = geburten.astype('int')


# create new dataframe

df_11_11101 = pd.DataFrame(columns=[
    'indicator_id',
    'spatialunit_id',
    'time_value',
    'timeinfo_id',
    'value',
    'dim1_value_id',
    'dim2_value_id',
    'dim3_value_id',
    'dim4_value_id',
    ])

# fill in values

df_11_11101['spatialunit_id'] = geburten['name_de']
df_11_11101['time_value'] = geburten['Jahr']
df_11_11101['timeinfo_id'] = 1
df_11_11101['value'] = geburten['DATA']
df_11_11101['dim1_value_id'] = geburten['Geschlecht des Kindes']
df_11_11101['dim2_value_id'] = geburten['Staatsangehörigkeit (Kategorie) des Kindes']
df_11_11101['dim3_value_id'] = geburten['Altersklasse der Mutter']
df_11_11101['indicator_id'] = 11101

# export as csv

df_11_11101.to_csv('11101_CH.csv', index=False, na_rep='NA')

sys.exit(0)
