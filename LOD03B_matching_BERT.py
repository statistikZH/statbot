import pandas as pd
import numpy as np
from rank_bm25 import BM25Okapi
from nltk.corpus import stopwords
from sklearn.feature_extraction.text import CountVectorizer
import string

from tqdm import tqdm
from transformers import AutoTokenizer, AutoModel
from itertools import zip_longest
import torch


def grouper(iterable, n, fillvalue=None):
    """Taken from: https://docs.python.org/3/library/itertools.html#itertools-recipes"""
    args = [iter(iterable)] * n
    return zip_longest(*args, fillvalue=fillvalue)


def mean_pooling(model_output, attention_mask):
    """
    Mean pooling to get sentence embeddings. See:
    https://huggingface.co/sentence-transformers/paraphrase-distilroberta-base-v1
    """
    token_embeddings = model_output[0]
    input_mask_expanded = attention_mask.unsqueeze(-1).expand(token_embeddings.size()).float()
    sum_embeddings = torch.sum(token_embeddings * input_mask_expanded, 1) # Sum columns
    sum_mask = torch.clamp(input_mask_expanded.sum(1), min=1e-9)
    return sum_embeddings / sum_mask

model_name = 'sentence-transformers/stsb-roberta-large'
model = AutoModel.from_pretrained(model_name)
tokenizer = AutoTokenizer.from_pretrained(model_name)

sentence_embeddings = []
token_embeddings = []

# Embed 8 sentences at a time
for sentences in tqdm(grouper(df.question.tolist(), 8, None)):
    
    # Ignore sentences with None
    valid_sentences = [s for s in sentences if s]

    # Tokenize input
    encoded_input = tokenizer(valid_sentences, padding=True, truncation=True, max_length=512, return_tensors="pt")    

    # Create word embeddings
    model_output = model(**encoded_input)

    # For each sentence, store a list of token embeddings; i.e. a 1024-dimensional vector for each token
    for i, sentence in enumerate(valid_sentences):
        tokens = tokenizer.convert_ids_to_tokens(encoded_input['input_ids'][i])
        embeddings = model_output[0][i]
        token_embeddings.append(
            [{"token": token, "embedding": embedding.detach().numpy()} for token, embedding in zip(tokens, embeddings)]
        )    

    # Pool to get sentence embeddings; i.e. generate one 1024 vector for the entire sentence
    sentence_embeddings.append(
        mean_pooling(model_output, encoded_input['attention_mask']).detach().numpy()
    )
    
# Concatenate all of the embeddings into one numpy array of shape (n_sentences, 1024)
sentence_embeddings = np.concatenate(sentence_embeddings)



exit()

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
score=[]


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
    

    
    attribution.append(str(tokenized_corpus[which]))
    score.append(max_value)
    #attribution.append(file_two.title_slug[which]+" ("+str(max_value)+")")

 
    
file_one['destination']=attribution
file_one['score']=score
file_one=file_one.rename(columns={"destination": destination})

file_one.to_csv('data_matching/output_'+source+'.csv',index=False)
