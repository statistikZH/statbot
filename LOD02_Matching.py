





import pandas as pd
import json
from urllib.request import urlopen
import csv
import wget
import os
import io
import re

#import the central json file
#orga="statistisches-amt-kanton-zuerich"
orga="statistisches-amt-kanton-basel-stadt"
url="https://ckan.opendata.swiss/api/3/action/package_search?fq=organization:"+orga+"&rows=1000"
json_url = urlopen(url)
data = json.load(json_url)

complex_simple="complex"

titles=[]
publishers=[]
texts=[]

def pasteme(input1,input2):
    return str(input1)+" "+str(input2)


for i,entry in enumerate(data['result']['results']):
    output=""
    print(i,":",entry['identifier']," ",entry['title_for_slug'])
    output=pasteme(output,entry['title']['de'])
    
    
    if complex_simple=="complex":
        output=pasteme(output,entry['description']['de'])
    
    
        for j,obj in enumerate(entry['resources']):
            output=pasteme(output,obj['display_name']['de'])
            output=pasteme(output,obj['title']['de'])
            output=pasteme(output,obj['description']['de'])
            output=pasteme(output,obj['name']['de'])




        for j,obj in enumerate(entry['keywords']['de']):
            output=pasteme(output,obj)

        for j,obj in enumerate(entry['relations']):
            output=pasteme(output,obj['label'])

        for j,obj in enumerate(entry['tags']):
            output=pasteme(output,obj['display_name'])

        for j,obj in enumerate(entry['groups']):
            output=pasteme(output,obj['display_name']['de'])
    
    print(output)
    titles.append(str(entry['title_for_slug']))
    publishers.append(str(entry['publishers'][0]['label']))
    texts.append(output)
    
  
   
df = pd.DataFrame(zip(titles,publishers,texts), columns=['title_slug', 'publisher','text'])
df.to_csv('data_matching/'+orga+'.csv',index=False)
