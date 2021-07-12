import pandas as pd
import numpy as np
from rank_bm25 import BM25Okapi
from nltk.corpus import stopwords
from sklearn.feature_extraction.text import CountVectorizer
import string
import torch as torch

from sentence_transformers import SentenceTransformer, util
model = SentenceTransformer('Sahajtomar/sts-GBERT-de')

#Stop words in German
german_stop_words = stopwords.words('german')
vect = CountVectorizer(stop_words = german_stop_words) 


source="statistisches-amt-kanton-zuerich"
destination="statistisches-amt-kanton-basel-stadt"

file_one=pd.read_csv("data_matching/"+source+".csv")
file_two=pd.read_csv("data_matching/"+destination+".csv")

def stop_word_removal(token):
    token=token.translate(str.maketrans('', '', string.punctuation))
    token = token.split(" ")
    
    token=' '.join([w for w in token if not w in german_stop_words])
    token = token.split(" ")
    return(token)

def get_fuzzy_ratio(listvalues):
    
    
    return fuzz.token_set_ratio(tokenized_query, listvalues)


#tokenized_corpus = [doc.split(" ") for doc in file_two.text]
#print(file_two.text[0])
#tokenized_corpus = [w for w in tokenized_corpus if not w in german_stop_words]
#tokenized_corpus=file_two.text.apply(stop_word_removal)
#tokenized_corpus = list(filter(str.strip, tokenized_corpus))
#print(tokenized_corpus[0])


#bm25 = BM25Okapi(tokenized_corpus)
attribution=[]


for i in range(len(file_one)):
    print(i)
    query=file_one.text[i]
   

    embeddings1 = model.encode(query, convert_to_tensor=True)
    embeddings2 = model.encode(file_two.text, convert_to_tensor=True)
    cosine_scores = util.pytorch_cos_sim(embeddings1, embeddings2)
    print(cosine_scores)
    
    
    #results=tokenized_corpus.apply(get_fuzzy_ratio)
    max_value = torch.max(cosine_scores)
    print(max_value)
    which=torch.argmax(cosine_scores)
    print(which)
    

    
    attribution.append(str(file_two.title_slug[int(which)])+" ("+str(int(100*max_value))+")")
    #attribution.append(file_two.title_slug[which]+" ("+str(max_value)+")")

 
    
file_one['destination']=attribution
file_one=file_one.rename(columns={"destination": destination})

file_one.to_csv('data_matching/output_'+source+'.csv',index=False)
