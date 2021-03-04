# Solution approaches
The participants are free to choose their solution approach. In the following, we present three possible solutions that we have researched and are currently considering. Howev-er, you are completely free to do so. We are looking forward to your feedback and ide-as!


## Possible approach 1: Train NER 

Named Entity Recognition (NER) allows identifying relevant entities in texts. For the English language exist very advanced NER with many relevant entities that would be relevant for us (cardinal, ordinal, time, money etc.). See for example www.wit.ai for an example of entities such as order_by and limit.

However, for the German language there is only NER with four entities so far. The recognition of localities such as Zurich, Will etc. has a benefit for us. Whereby some of the localities relevant for us (like certain municipalities in the canton of Zurich) are only inadequately identified. The remaining three entities Organizations, Persons and "Misc" are not relevant to us. Perhaps the Part of Speech (POS) elements could also be useful - a first look at the Stuttgart-Tübingen-Tagset (STTS) showed us some interesting ele-ments, but we have not looked at this in detail yet.
Custom entities such as dataset names, variable names, granularity (e.g. population at federal, cantonal, district or municipality level?), and even important information in the text such as "greater than", "per month", "for all municipalities in the canton of Zurich", or "from 2005 to 2008" (as can also be seen in the wit.ai figure above, for example) are more interesting. On Github you find the data bases and the code for our first experi-ments, which may be used as inspiration (see picture). 

![Example of two additionally trained NER for granularity and datasets](https://github.com/statistikZH/statbot/blob/main/documentation/figures/ner_third_attempt.png)

Imagine the following sentence "Anteil der Personen mit Einkommen über 5000CHF pro Monat" or in English "share of people with income over 5000 Swiss Francs per month"." Entities are share (a relativity commonly understood in percent),  persons (as opposed to companies, economic sectors or others that also have some sort of income), the main variable income, over 5000CHF, per month. 

Our code to train own NERs has been taken for the large part from here:
https://deepnote.com/publish/2cc2d19c-c3ac-4321-8853-0bcf2ef565b3
 
Other sources with pre-trained NERs in German can be found here: 
https://huggingface.co/transformers/v2.2.0/examples.html#named-entity-recognition
https://sites.google.com/site/germeval2014ner/data

For an OpenCalais adaptation by Liip (Stefan Oderbolz) see also: https://github.com/metaodi/wikidata-highlight

In our code you will find the following:

### Script A01 

All publicly available data (Open Government Data – OGD) of the Statistical Office of the Canton of Zurich are extracted from the central JSON-file. By downloading and opening up every file, additional data can be extracted such as variable names that are not described in the metadata. Extracted is thus a combination between metadata and some information in the dataset. 

This could later be improved to save the data in a mysql-db.

### Script A02

The second script generates the training dataset with questions and adds the desired new tags (such as granularity and datasets) in the Spacy-format so that it can be used for the training. 

It loads a csv-file with pre-written questions that contain brackets to insert elements such as {dataset} or {year} or {granularity} etc. The csv-file can be added with additional questions. For every dataset that we have, several questions are being generated randomly. 

A lot can be improved in this script. Maybe the script could be combined with the generation of training-data for the second approach that is described further below (seq2SQL).

At the moment, the script only generates data for the so-called "Gemeindeportraet" of the Statistics Office of the Canton of Zurich. The reason is that the data-variables are all in the same format with the same variable names. We want of course to get away from that structure to be able to use all kind of statistical OGD.

### Script A03

Training is being done based on a pre-trained bert-base-multilingual-cased by using transfer learning. At the end of the script, there is also some sort of evaluation showing the previously four included NER tags (because transfer learning can change their accuracy), and the new NER tags.

Right now there is now link yet with POS (Position of Speech)

## Possible approach 2: Seq2SQL

Another promising approach is Seq2SQL. Here, the procedure is not split into knowledge extraction and database query, but is performed in one step. The SQL command needed to retrieve the required data from the database is trained directly. Probably the most important paper (Zhong et al. 2017) on this can be found here:
https://github.com/salesforce/WikiSQL
https://arxiv.org/pdf/1709.00103.pdf

![Zhong et al. 2017 figures 1 and 2](https://github.com/statistikZH/statbot/blob/main/documentation/figures/zhong_2017_fig1and2.png)

Zhong et al. 2017 use so-called «Renifonrcement learning», to improve the algorithm continuously.  

Since the publication of their paper, there were many other papers that built on that ap-proach, and which had amazing/improved performances:
https://paperswithcode.com/paper/seq2sql-generating-structured-queries-from
In order to single out one of these examples based on T5 (Li. Et al. 2000):
http://arxiv.org/abs/2011.03836
https://github.com/louis-li/SeqGenSQL

In this case, the training data could be generated by the user, as well. One problem here, however, could be the attribution of the correct data set. At best, a combination with the above mentioned NER approach would also be possible: 1) Identify the searched data set by NER; 2) Generate the SQL query. But this is just an idea. Maybe we will add something to our github-repo about this until the challenge.

They use reinforcement learning (RL) to train a model. The execution accuracy of 59.4% and the logical form accuracy of 48.3% are still quite low even though they achieved a very large jump to previous efforts (35.9% and 23.4% respectively).

Zhong et al. argue that a SQL query consists of three components. An aggregation operator such as COUNT or SUM. The second component is SELECT to identify the columns that are to be given out. And the third component is the WHERE clause to filter. Seq2SQL also consists of three parts that correspond to these three components. 

In the meanwhile the state of art is already much further than in the original paper by Zhong et al. 2017. See for example Li et al. (2020) who reach over 90% accuracy: 
https://github.com/louis-li/SeqGenSQL

Thus maybe it is a key to start there and not at the original code by seq2SQL.

## Possible approach 3: TaPas

A very cool approach is TaPas (Weakly Supervised Table Parsing via Pre-training) by Google: 
https://arxiv.org/abs/2004.02349
https://github.com/google-research/tapas
https://ai.googleblog.com/2020/04/using-neural-networks-to-find-answers.html
https://www.aclweb.org/anthology/2020.acl-main.398.pdf

TaPas is an interesting solution approach, but it has some edges. First, TaPas relies on text-table pairs. Actually, as with approaches 1 and 2, we could solve this by using a different algorithm in a first step to locate the most likely data set. After that, the table would have to be searched for the text. The maximum of 500 cells in the set of TaPas is an obstacle. This could be solved if you can already extract certain elements from the question, like the locality. Then one could pre-filter the data set, so that less than 500 cells remain. Only after that, one could apply TaPas and generate an answer. 
Nevertheless, the bigger problem with TaPas is the pre-training, which is not only very computationally expensive, but also requires a prebuilt German dataset (e.g. a pair of dataset text segments and tables). Then it needs the German BERT (should be OK) and then the finetuning on our tables. See also the following that might help generating it:
https://github.com/wenhuchen/WikiTables-WithLinks/blob/master/preprocessing/pipeline.py

There are already papers that have developed the TaPas approach further, like TABERT from Facebook: https://arxiv.org/pdf/2005.08314v1.pdf

Google also published the following afterwards:
https://www.aclweb.org/anthology/2020.findings-emnlp.27.pdf


## Other solution approaches
Another approach could be based on Knowledge Graphs (Zelle and Mooney 1996 and Wong and Mooney 2007). After a first reading, it seems to us that this could be a strong approach in terms of semantic understanding, but it might quickly become too complex and inoperable (especially in the modular appending of further datasets).

Zero-shot solutions have also crossed our minds (maybe even with T5 instead of BERT?). But since the answers are in the form of structured data and of aggregation functions of this data (Sum, Count etc.), we don't see how we could train the text input. 
In any case, you are completely open in your choice of approach. Maybe we are wrong here and you see a good alternative way to do it!

A simple solution of a statistical bot, without any NLP, can also be seen here:
https://github.com/metaodi/schlaumeier



