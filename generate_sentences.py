from __future__ import print_function, unicode_literals
import pandas as pd
import numpy as np
import spacy
from random import sample
import io, csv
import re
import random
import warnings
from spacy.util import minibatch, compounding
#import de_core_news_lg



nlp = spacy.load('de_core_news_lg')

df=pd.read_csv("data/datasets_overview.csv")

#one more prepatation
df['question_type'] = df['dataset_title'].str.extract(r"\[(.*?)\]", expand=False)
df['question_type'] = np.where(df['question_type']== '%', "percent", "cardinal")
df['dataset_title'] = df['dataset_title'].str.replace(r"\[(.*?)\]", "")
#structurize relevant informations such as variables
#load content of datasets

#generate sentences

sentences=pd.read_csv("input/question_generator.csv")
#locations=pd.read_csv("data/1.csv",usecols = ['GEBIET_NAME'])#using this right now for every variable
out_sentences=[]

for i in df['index'].unique():
    filename="data/"+str(i)+".csv"
    with io.open(filename, 'r', encoding="latin-1") as csvfile:
        dialect = csv.Sniffer().sniff(csvfile.readline(), [',',';'])
        csvfile.seek(0)
        mydelimiter=dialect.delimiter
    this_data=pd.read_csv(filename,delimiter=dialect.delimiter)
    vars=df['var'].loc[df['index'] == i]
    dataset_title=df['dataset_title'].loc[df['index']==i].any()
    question_type=df['question_type'].loc[df['index']==i].any()
    if vars.str.contains("INDIKATOR_VALUE").sum():
        main=dataset_title
        filter_vars=vars
        #print(filter_vars)
    else:
        continue #temporary so that all variables look alike
        print("ATTRIBUTING MAIN VARIABLE TO: ",dataset_title)
        length_title_string=len(dataset_title.split())
        highest_similarity=0
        which=None
        for var in vars:
            temp_string=dataset_title+" "+var
            #print(temp_string)
            doc = nlp(temp_string)
            assert len(doc.vector) == len(doc[0].vector)
            calc_similarity=doc[:length_title_string].similarity(doc[length_title_string:])
            if  calc_similarity> highest_similarity:
                highest_similarity=calc_similarity
                which=var

        print("Highest similarity:",var,highest_similarity)
        main=var
        vars=vars.tolist()
        print(vars)
        print(main)
        filter_vars=vars.remove(main)
    #the following temporary because it is standardized
    filter_vars=list(filter_vars)
    filter_vars.append("")
    try:
        filter_vars.remove("INDIKATOR_JAHR")
        filter_vars.remove("GEBIET_NAME")
        filter_vars.remove("BFS_NR")
        filter_vars.remove("INDIKATOR_VALUE")
    except:
        print("variable removing empty")

    for sentence in sentences['question'].loc[sentences['main_type'] == question_type]:
        out_entities = []
        sentence=sentence.replace("{main}",main)
        sentence=sentence.replace("{localitylevel}","")#at the moment empty
        #TODO either one locality, one level, or several localities
        random_value=sample(["one locality","one level","several localities"],1)[0]
        if random_value=="one locality":
            locality_insert="in "+sample(list(this_data['GEBIET_NAME']),1)[0]
        if random_value=="one level":
            locality_insert=sample(["für den gesamten Kanton","im Kanton Zürich","auf Bezirksebene",
            "für alle Bezirke","pro Bezirk","auf Gemeindeebene","für alle Gemeinden","pro Gemeinde","auf Kreisebene","für jeden Kreis","pro Kreis"],1)[0]
        if random_value=="several localities":
            locality_insert=""
            local_loop=sample([1,2,3],1)[0]
            for local in range(0,local_loop):
                if local!=0 and local!=(local_loop-1):
                    locality_insert+=", "
                if local!=0 and local==(local_loop-1):
                    locality_insert+=" und "
                locality_insert+=sample(list(this_data['GEBIET_NAME']),1)[0]
        sentence=sentence.replace("{locality}",locality_insert)
        sentence=sentence.replace("{yeartime}","")#TODO no,aktuellste,neuste, value from list, from to year
        sentence=sentence.replace("{filter}",sample(list(filter_vars),1)[0])

        for mat in re.findall(r'.*?\[(.*)].*', sentence):
            which_part=sample([1,2],1)

            if which_part==1:
                sentence=sentence.replace("["+mat+"]",mat.partition("|")[0])
                #sentence=re.sub("["+mat+"]",mat.partition("|")[0],sentence)
            else:
                sentence=sentence.replace("["+mat+"]",mat.partition("|")[2])
                #sentence=re.sub("["+mat+"]",mat.partition("|")[2],sentence)


        match_span = re.search(locality_insert, sentence)
        if match_span is not None:
            match_span=match_span.span()
            out_entities.append((match_span[0], match_span[1], "LOCALITY"))

        #out_entities.append((match_span[0], match_span[1], "LOCALITY"))


        #out_sentences.append(sentence)
        #print(sentence)
        out_sentences.append((sentence, {"entities": out_entities}))

print(out_sentences[:10])
pd.DataFrame(out_sentences).to_csv("input/generated_sentences.csv",index=False)

npr_df = pd.read_csv("external/deu_news_2015_3M-sentences.txt", delimiter = "\t")
npr_df=npr_df.sample(frac=1)
npr_df.head()

revision_texts = []

# convert the articles to spacy objects to better identify the sentences. Disabled unneeded components. # takes ~ 4 minutes
for doc in nlp.pipe(npr_df.iloc[:6000,1], batch_size=30, disable=["tagger", "ner"]):
    for sentence in doc.sents:
        if  40 < len(sentence.text) < 80:
            # some of the sentences had excessive whitespace in between words, so we're trimming that
            revision_texts.append(" ".join(re.split("\s+", sentence.text, flags=re.UNICODE)))


revisions = []

# Use the existing spaCy model to predict the entities, then append them to revision
for doc in nlp.pipe(revision_texts, batch_size=50, disable=["tagger", "parser"]):

    # don't append sentences that have no entities
    if len(doc.ents) > 0:
        revisions.append((doc.text, {"entities": [(e.start_char, e.end_char, e.label_) for e in doc.ents]}))

# create arrays to store the revision data
TRAIN_REVISION_DATA = []
TEST_REVISION_DATA = []

# create dictionaries to keep count of the different entities
TRAIN_ENTITY_COUNTER = {}
TEST_ENTITY_COUNTER = {}

# This will help distribute the entities (i.e. we don't want 1000 PERSON entities, but only 80 ORG entities)
REVISION_SENTENCE_SOFT_LIMIT = 100

# helper function for incrementing the revision counters
def increment_revision_counters(entity_counter, entities):
    for entity in entities:
        label = entity[2]
        if label in entity_counter:
            entity_counter[label] += 1
        else:
            entity_counter[label] = 1

random.shuffle(revisions)
for revision in revisions:
    # get the entities from the revision sentence
    entities = revision[1]["entities"]

    # simple hack to make sure spaCy entities don't get too one-sided
    should_append_to_train_counter = 0
    for _, _, label in entities:
        if label in TRAIN_ENTITY_COUNTER and TRAIN_ENTITY_COUNTER[label] > REVISION_SENTENCE_SOFT_LIMIT:
            should_append_to_train_counter -= 1
        else:
            should_append_to_train_counter += 1

    # simple switch for deciding whether to append to train data or test data
    if should_append_to_train_counter >= 0:
        TRAIN_REVISION_DATA.append(revision)
        increment_revision_counters(TRAIN_ENTITY_COUNTER, entities)
    else:
        TEST_REVISION_DATA.append(revision)
        increment_revision_counters(TEST_ENTITY_COUNTER, entities)

random.shuffle(out_sentences)
TRAIN_STAT_DATA=out_sentences[:len(out_sentences)//2]
TEST_STAT_DATA=out_sentences[len(out_sentences)//2:]

print(len(out_sentences))
print(len(TRAIN_STAT_DATA))
print(len(TEST_STAT_DATA))
print("REVISION", len(TRAIN_REVISION_DATA))
TRAIN_DATA = TRAIN_REVISION_DATA + TRAIN_STAT_DATA
print("COMBINED", len(TRAIN_DATA))

# add NER to the pipeline and the new label
import de_core_news_lg
nlp = spacy.load('de_core_news_lg')
ner = nlp.get_pipe("ner")
ner.add_label("LOCALITY")
from spacy.training import Example
from spacy.tokens import Doc


# get the names of the components we want to disable during training
pipe_exceptions = ["ner", "trf_wordpiecer", "trf_tok2vec"]
other_pipes = [pipe for pipe in nlp.pipe_names if pipe not in pipe_exceptions]

# start the training loop, only training NER
epochs = 30
#optimizer = nlp.resume_training()
optimizer = nlp.initialize()
with nlp.disable_pipes(*other_pipes), warnings.catch_warnings():
    warnings.filterwarnings("once", category=UserWarning, module='spacy')
    sizes = compounding(1.0, 4.0, 1.001)

    # batch up the examples using spaCy's minibatc
    for epoch in range(epochs):
        #examples = TRAIN_DATA
        random.shuffle(TRAIN_DATA)
        #examples = []
        #for text, annots in TRAIN_DATA:
        #    examples.append(Example.from_dict(nlp.make_doc(text), annots))
        #nlp.initialize(lambda: examples)

        #example = Example.from_dict(dictionary)
        #example = Example(doc, annotations)
        losses = {}

        for batch in minibatch(TRAIN_DATA, size=8):
            for text, annotations in batch:
                doc = nlp(text)
                example = Example.from_dict(doc, annotations)
            #    print(example)
                nlp.update([example])#, drop=0.35, sgd=optimizer, losses=losses)

        #nlp.update([example], sgd=optimizer, drop=0.35, losses=losses)

        print("Losses ({}/{})".format(epoch + 1, epochs), losses)
