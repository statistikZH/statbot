import pandas as pd
import numpy as np
from rank_bm25 import BM25Okapi
from nltk.corpus import stopwords
from sklearn.feature_extraction.text import CountVectorizer
import string
from fuzzywuzzy import fuzz

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
print(file_two.text[0])
#tokenized_corpus = [w for w in tokenized_corpus if not w in german_stop_words]
tokenized_corpus=file_two.text.apply(stop_word_removal)
#tokenized_corpus = list(filter(str.strip, tokenized_corpus))
print(tokenized_corpus[0])

bm25 = BM25Okapi(tokenized_corpus)
attribution=[]


for i in range(len(file_one)):
    
    query=file_one.text[i]
    #query="Schülerprognose"
    tokenized_query = query.split(" ")

    tokenized_query  = stop_word_removal(query)
    print(tokenized_query)
    
    #results=bm25.get_scores(tokenized_query)


    
    results=tokenized_corpus.apply(get_fuzzy_ratio)
    max_value = max(results)
    print(results)
    print("MAX VALUE:",max_value)
    which=np.argmax(results)
    print("WHICH:",which)
    

    
    attribution.append(str(tokenized_corpus[which])+" ("+str(max_value)+")")
    #attribution.append(file_two.title_slug[which]+" ("+str(max_value)+")")

 
    
file_one['destination']=attribution
file_one=file_one.rename(columns={"destination": destination})

file_one.to_csv('data_matching/output_'+source+'.csv',index=False)
