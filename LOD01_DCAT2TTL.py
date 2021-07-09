





import pandas as pd
import json
from urllib.request import urlopen
import csv
import wget
import os
import io
import re

#import the central json file
url="https://ckan.opendata.swiss/api/3/action/package_search?fq=organization:statistisches-amt-kanton-zuerich&rows=1000"
json_url = urlopen(url)
data = json.load(json_url)


measures=[]




for i,entry in enumerate(data['result']['results']):

    urlname=entry['resources'][0]['download_url']
    title_for_slug=entry['title_for_slug']
    identifier=entry['identifier']
    organization=entry['publishers'][0]['label']
    organization=organization.replace("ü","ue")
    print(i,":",identifier," ",title_for_slug)
    if urlname is not None:
        #select only the csv files, as there are also other kind of files
        if urlname[-4:]==".csv":
            filename='data2/'+identifier+'.csv'
            ttlfile='data_ttl/'+identifier+'.ttl'
            if os.path.exists(filename):
                os.remove(filename) # if exist, remove it directly
            if os.path.exists(ttlfile):
                os.remove(ttlfile) # if exist, remove it directly
            try:
                wget.download(urlname,filename )
            except:
                print(i,identifier," CSV-Download failed")
                continue
            try:
                wget.download("https://opendata.swiss/de/dataset/"+title_for_slug+".ttl",ttlfile )
            except:
                print(" TTL-Download failed")
                continue
            
                
            with open(ttlfile) as f:
                lines = f.readlines()

            lines=[w.replace("https://ckan.opendata.swiss/perma","http://datashop.westeurope.cloudapp.azure.com/statistics") for w in lines]
            lines=[w.replace("a dcat:Dataset ;","a cube:Cube, dcat:Dataset ;") for w in lines]
            index = [x for x in range(len(lines)) if 'dcat:Distribution' in lines[x]]
            print(int(index[0]))
            lines=lines[0:int(index[0])]
            
            lines.insert(0,"@prefix cube: <https://cube.link/> .\n")
            
            index = [x for x in range(len(lines)) if 'dct:description' in lines[x]]
            lines[index[0]]=lines[index[0]].replace("<","")
            lines[index[0]]=lines[index[0]].replace(">","")
            lines=[w.replace("ö","oe") for w in lines]
            lines=[w.replace("Ö","Oe") for w in lines]
            lines=[w.replace("ü","ue") for w in lines]
            lines=[w.replace("Ü","Ue") for w in lines]
            lines=[w.replace("ä","ae") for w in lines]
            lines=[w.replace("Ä","Ae") for w in lines]
           
            
            lines.append("<http://datashop.westeurope.cloudapp.azure.com/statistics/"+identifier+"> cube:observationSet <http://datashop.westeurope.cloudapp.azure.com/statistics/"+identifier+"/observation/> .\n")
            lines.append("<http://datashop.westeurope.cloudapp.azure.com/statistics/"+identifier+"> cube:observationConstraint <http://datashop.westeurope.cloudapp.azure.com/statistics/"+identifier+"/shape/> .\n")
            
            
             #there was an issue with the encoding of the files, this is why latin-1 is used
            with io.open(filename, 'r', encoding="latin-1") as csvfile:
                #also we need an own csv-sniffer to well observe whether the file is ,-delimited or ;-delimited - both are currently used
                dialect = csv.Sniffer().sniff(csvfile.readline(), [',',';'])
                csvfile.seek(0)
                mydelimiter=dialect.delimiter
            try:
                file_in=pd.read_csv(filename,delimiter=dialect.delimiter)
            except:
                print("csv-file could not be loaded")
                
            #check if INDIKATOR_ID exists as column
            if 'INDIKATOR_ID' not in file_in.columns:
                print("this is not a gp file")
                os.remove(ttlfile) 
                continue
            l_observationset=["<http://datashop.westeurope.cloudapp.azure.com/statistics/"+identifier+"/observation/> a cube:ObservationSet ;",
"cube:observation"]
            l_observations=[]
            
            measure=re.sub('[^A-Za-z0-9]+', '', file_in.EINHEIT_KURZ.iloc[0])
            print("MEASURE: ",measure)
            if measure not in measures:
                measures.append(measure)
                lines.append("<http://datashop.westeurope.cloudapp.azure.com/statistics/measure/"+measure+"> a <http://www.w3.org/1999/02/22-rdf-syntax-ns#Property> ;")
                lines.append('<http://schema.org/name> "'+str(file_in.EINHEIT_LANG.iloc[0])+'" ;')
                lines.append('<http://schema.org/description> "'+str(file_in.EINHEIT_LANG.iloc[0])+'" ;')
                lines.append('<http://schema.org/identifier> "'+measure+'" .')
               #<http://qudt.org/vocab/unit#unit> <https://ld.stadt-zuerich.ch/statistics/unit/chf> .
                
            #temp_index=measures.index(measure)
            
            
            for index, row in file_in.iterrows():
                R="R"+str(row['BFS_NR']).zfill(4)
                Z="Z3112"+str(row['INDIKATOR_JAHR'])
                temp_string="<http://datashop.westeurope.cloudapp.azure.com/statistics/"+identifier+"/observation/"+R+"-"+Z+">"
                if index==file_in.shape[0]-1:
                    temp_string+="."
                else:
                    temp_string+=","
                    
                
                
                    
                l_observationset.append(temp_string)
                l_observations.append("<http://datashop.westeurope.cloudapp.azure.com/statistics/"+identifier+"/observation/"+R+"-"+Z+"> a cube:Observation ;")
                l_observations.append("<https://ld.stadt-zuerich.ch/statistics/property/ZEIT> <https://ld.stadt-zuerich.ch/statistics/code/"+Z+"> ;")
                l_observations.append("<https://ld.stadt-zuerich.ch/statistics/property/RAUM> <https://ld.stadt-zuerich.ch/statistics/code/"+R+"> ;")
                l_observations.append("<http://datashop.westeurope.cloudapp.azure.com/statistics/measure/"+measure+"> "+str(row['INDIKATOR_VALUE'])+" ;")
                l_observations.append('<http://schema.org/identifier> "'+R+'-'+Z+'" ;')
                l_observations.append('<https://cube.link/observedBy> "'+organization+'" ;')
                l_observations.append('<https://ld.stadt-zuerich.ch/statistics/property/TIME> "'+str(row['INDIKATOR_JAHR'])+'-12-31"^^<http://www.w3.org/2001/XMLSchema#date> .')
                                      
                


            lines=lines+l_observationset+l_observations
           
            
            
            with open(ttlfile,'w') as f:
                f.write(''.join(lines))
                
            
   
                
        
    break
   