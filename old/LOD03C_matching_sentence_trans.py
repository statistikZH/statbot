import pandas as pd
import numpy as np
from rank_bm25 import BM25Okapi
from nltk.corpus import stopwords
from sklearn.feature_extraction.text import CountVectorizer
import string
import torch as torch

from sentence_transformers import SentenceTransformer, util
model = SentenceTransformer('Sahajtomar/sts-GBERT-de')


source="statistisches-amt-kanton-zuerich"
destination="statistisches-amt-kanton-basel-stadt"

file_one=pd.read_csv("data_matching/"+source+".csv")
file_two=pd.read_csv("data_matching/"+destination+".csv")


attribution=[]


for i in range(len(file_one)):
    print(i)
    query=file_one.text[i]
   

    embeddings1 = model.encode(query, convert_to_tensor=True)
    embeddings2 = model.encode(file_two.text, convert_to_tensor=True)
    cosine_scores = util.pytorch_cos_sim(embeddings1, embeddings2)
    print(cosine_scores)
    
    
   
    max_value = torch.max(cosine_scores)
    print(max_value)
    which=torch.argmax(cosine_scores)
    print(which)
    

    
    attribution.append(str(file_two.title_slug[int(which)])+" ("+str(int(100*max_value))+")")
    

 
    
file_one['destination']=attribution
file_one=file_one.rename(columns={"destination": destination})

file_one.to_csv('data_matching/output_'+source+'.csv',index=False)
