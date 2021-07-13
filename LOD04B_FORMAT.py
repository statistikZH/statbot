### Description of script
#All publicly available data (Open Government Data – OGD) of the Statistical Office of the Canton of Zurich
#are extracted from the central JSON-file. By downloading and opening up every file, additional data can be
#extracted such as variable names that are not described in the metadata. Extracted is thus a combination
#between metadata and some information in the dataset.

# thoughts for improvement
# - much more metadata could be extracted
# - This could later be improved to save the data in a mysql-db.



import pandas as pd
import json
from urllib.request import urlopen
import csv
import wget
import os
import io

#import the central json file
url="https://www.web.statistik.zh.ch/data/zhweb.json"
json_url = urlopen(url)
data = json.load(json_url)
list_data=[]
for i,entry in enumerate(data['dataset']):
    #get for every dataset the urlname that is written in the respective node
    for distros in entry['distribution']:
        list_data.append([i, entry['identifier'],entry['title'],distros['format']])
   

    print(i)
    

#and the file with all the relevant metadata is saved here
df = pd.DataFrame(list_data, columns=['index', 'identifier','dataset_title', 'format'])
df.to_csv('data/formats_overview.csv',index=False)
print(df.format.value_counts())
print("FINISHED")
