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
    urlname=entry['distribution'][0]['downloadUrl']
    if urlname is not None:
        #select only the csv files, as there are also other kind of files
        if urlname[-4:]==".csv":
            filename='data/'+str(i)+'.csv'
            if os.path.exists(filename):
                os.remove(filename) # if exist, remove it directly
            try:
                wget.download(urlname,filename )
            except:
                print(i,"Download failed")
            mydelimiter=None

            #there was an issue with the encoding of the files, this is why latin-1 is used
            with io.open(filename, 'r', encoding="latin-1") as csvfile:
                #also we need an own csv-sniffer to well observe whether the file is ,-delimited or ;-delimited - both are currently used
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

#and the file with all the relevant metadata is saved here
df = pd.DataFrame(list_data, columns=['index', 'dataset_title', 'description','var','nunique','dtype'])
df.to_csv('data/datasets_overview.csv',index=False)
print("FINISHED")
