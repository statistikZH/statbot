import pandas as pd
import json
from urllib.request import urlopen
import csv
import wget
import os
import io

#import json
url="https://www.web.statistik.zh.ch/data/zhweb.json"
json_url = urlopen(url)
data = json.load(json_url)
list_data=[]
for i,entry in enumerate(data['dataset']):
    urlname=entry['distribution'][0]['downloadUrl']
    if urlname is not None:
        if urlname[-4:]==".csv":
            filename='data/'+str(i)+'.csv'
            if os.path.exists(filename):
                os.remove(filename) # if exist, remove it directly
            try:
                wget.download(urlname,filename )
            except:
                print(i,"Download failed")
            mydelimiter=None

            with io.open(filename, 'r', encoding="latin-1") as csvfile:
                dialect = csv.Sniffer().sniff(csvfile.readline(), [',',';'])
                csvfile.seek(0)
                mydelimiter=dialect.delimiter
            try:
                file_in=pd.read_csv(filename,dialect.delimiter)
                for (columnName, columnData) in file_in.iteritems():
                    if columnData.nunique()>1:
                        list_data.append([i, entry['title'], entry['description'],columnName,columnData.nunique(),columnData.dtype.name])
            except:
                print(i,"file could not be loaded")

    print(i)


df = pd.DataFrame(list_data, columns=['index', 'dataset_title', 'description','var','nunique','dtype'])
df.to_csv('data/datasets_overview.csv',index=False)
print("FINISHED")
