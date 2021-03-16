# Possible Solution Approaches and Important Concepts
The participants are free to choose their solution approach. In the following, we present our current state of thoughts on possible solutions and on some concepts that we found that might be important. However, we would really like to emphasize that you are completely free to chose your own approach. Furthermore, we are looking forward to your feedback and ideas and to find out whether our thoughts and assumptions are going in to the right direction at all!


## Central concept: Named Entity Recognition (NER)
As a reminder, we are interested in two large components: On the one hand to understand the intent of a question, and then on the other hand to make a data query. As far as we see in the research, there is no approach that can make both components in one go. This is why we are focusing in this hackathon-challenge on the understanding of a question.

One central element that we identified for that is so-called Named Entity Recognition (NER). It is the identification of pre-defined categories such as person names, locations, organization names, time expressions, or monetary values in unstructured text. NER converts a normal text into a annotated text like in the following example:

Identifying such named entities enables us (according to our assumptions) to know, whether someone is talking about a specific data category (e.g. population), certain variables (only female population over 40 years old), in certain locations (in the city of Berne), for a certain time (the year 2019).

For the English language there are already very advanced NER with many pre-trained entities that would be relevant for us (including also categories such as cardinal numbers, ordinal numbers, time, money etc.). See for example one of the advertisements on www.wit.ai for an interesting example of advanced pre-trained entities such as order_by and limit (for copyright reasons we are not sharing the picture here).

However, for the German language the available pre-trained NER models contains no more than four entities so far. The recognition of localities such as Zurich, Wil etc. has a benefit for us (although not all of the municipalities in the Canton of Zurich are recognized). However, the remaining three entities (Organizations, Persons and "Misc") are not relevant to us.

## Central concept: Part of Speech (POS)
Part of Speech (POS) is very similar to NER in that unstructured text is converted into annotated elements. Instead of having certain pre-trained categories, POS attributes to every word a linguistic attribute like noun, adjective and verb. But POS goes further than that and provides very specific lexical items that help us understand e.g. cardinality, conjunctions, prepositions, and others. In other words, this might help us in combination with NER to extract all the relevant parts of a question, so that we can subsequently work on it. 

In German Language, there is a nicely advanced POS called the Stuttgart-Tübingen-Tagset (STTS). The python-package SPACY contains it for the German language by default. 

## Possible solution approach 1: Train NER 

Our first solution approach would be to train NERs with own entities. Custom entities such as for example dataset names, variable names, granularity (e.g. population at federal, cantonal, district or municipality level?), or even important information in the text such as "greater than", "per month", "for all municipalities in the canton of Zurich", or "from 2005 to 2008" (if they cannot be extracted partly with POS). 

We already were experimenting a little bit on this approach, and you can find here on github the code for our first experiments, which may be used as inspiration (see picture below, where we tried to train own NERs). 

![Example of two additionally trained NER for granularity and datasets](https://github.com/statistikZH/statbot/blob/main/documentation/figures/ner_third_attempt.png)

It is quite a challenge. Imagine the following German sentence "Anteil der Personen mit Einkommen über 5000CHF pro Monat" or in English "share of people with income over 5000 Swiss Francs per month"." Entities are share (a relativity commonly understood in percent),  persons (as opposed to companies, economic sectors or others that also have some sort of income), the main variable income, over 5000CHF, per month. 

Our code to train own NERs has been taken for the large part from the following link, which contains an excellent explanation on NERs and on the different steps that were required to train own NERs:
https://deepnote.com/publish/2cc2d19c-c3ac-4321-8853-0bcf2ef565b3

The description of our scripts in this github repo can be [found here](https://github.com/statistikZH/statbot/blob/main/documentation/05_Explanation_Scripts.md).
 
You might also find some interesting information and some sources with pre-trained NERs in German here: 
- https://huggingface.co/transformers/v2.2.0/examples.html#named-entity-recognition
- https://sites.google.com/site/germeval2014ner/data

To build named entity recognition models in R we recommend having a look at two packages from the [udpipe](https://cran.r-project.org/web/packages/udpipe/vignettes/udpipe-universe.html)-familiy. 

- [crfsuite](https://cran.r-project.org/web/packages/crfsuite/vignettes/crfsuite-nlp.html) 
- [nametagger](https://cran.r-project.org/web/packages/nametagger/index.html)

For an OpenCalais adaptation by Liip (Stefan Oderbolz) see also: https://github.com/metaodi/wikidata-highlight




## Possible approach 2: Seq2SQL

Another promising approach is Seq2SQL. Here, the procedure is not split into knowledge extraction and database query, but is performed in one step. The SQL command needed to retrieve the required data from the database is trained directly. Probably the most important paper (Zhong et al. 2017) on this can be found here:
https://github.com/salesforce/WikiSQL
https://arxiv.org/pdf/1709.00103.pdf

![Zhong et al. 2017 figures 1 and 2](https://github.com/statistikZH/statbot/blob/main/documentation/figures/zhong_2017_fig1and2.png)

Zhong et al. 2017 use so-called «Renifonrcement learning», to improve the algorithm continuously.  

In this case, the training data could be generated by the user, as well. One problem here, however, could be the attribution of the correct data set. At best, a combination with the above mentioned NER approach would also be possible: 1) Identify the searched data set by NER; 2) Generate the SQL query. But this is just an idea. Maybe we will add something to our github-repo about this until the challenge.

They use reinforcement learning (RL) to train a model. The execution accuracy of 59.4% and the logical form accuracy of 48.3% are still quite low even though they achieved a very large jump to previous efforts (35.9% and 23.4% respectively).

Zhong et al. argue that a SQL query consists of three components. An aggregation operator such as COUNT or SUM. The second component is SELECT to identify the columns that are to be given out. And the third component is the WHERE clause to filter. Seq2SQL also consists of three parts that correspond to these three components. 

Since the publication of their paper, there were many other papers that built on that ap-proach, and which had amazing/improved performances:
https://paperswithcode.com/paper/seq2sql-generating-structured-queries-from
In order to single out one of these examples based on T5 (Li. et al. 2000), who reach over 90% accuracy:
http://arxiv.org/abs/2011.03836
https://github.com/louis-li/SeqGenSQL

A problem by the Li et al. approach, is that T5 is currently only available in English. But we could nevertheless to try to use it without any change, or to use it with german-to-english translation. On a workshop at the EPFL on 2nd of March, it was for example tried to use both ways on another issue, and the accuracies were surprisingly high. Of course it would be better to have a German T5, but maybe we could start already with the English T5 and see how well the accuracies are. 

Interestingly in the paper of Li et al., T5 permits to make everything without an intermediate step. Further, instead of having three different models as Zhong et al., the target variable is a sql-text and thus one model. They add in their models also column headers, data types of the columns, as well as 1-3 samples of every column, and reach therewith higher accuracy. They also use several steps, among which a reverse trainer model - they train partly as having the questions as dependent variables! The model works so well that "execution guided inference"" only has a very marginal benefit. One particular element they introduce to reduce so-called "hallucination" is a "gated extraction network".

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



