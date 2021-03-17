# A Possible Solution Approach based on Named Entity Recognition (NER)
In the following, we present our current state of thoughts on possible solutions and on some concepts that we found that might be important. However, we would really like to emphasize that you are completely free to chose your own approach. Furthermore, we are looking forward to your feedback and ideas and to find out whether our thoughts and assumptions are going in to the right direction at all!

Last week we were still thinking that there might be three different solution approaches. But we think now, that two things that we called approaches require the first approach anyway in the first step. This is why we would recommend for this challenge to focus on a possible approach based mainly on Named Entity Recognition (NER).

Further, we would like to simplify this documentation for the participants of the challenge as much as possible. This is why we are going to present here only "approach A", but for those who would like to dig deeper we are [parking our thoughts about a seq2SQL and TaPas approaches here on another part of the documentation called research](https://github.com/statistikZH/statbot/blob/main/documentation/04_Research.md). We think that we will require seq2SQL later in the project - if participants are interested, they are of course also very welcome to try it!

## Central concept: Named Entity Recognition (NER)
As a reminder, we are interested in two large components: On the one hand to understand the intent of a question, and then on the other hand to make a data query. As far as we see in the research, there is no approach that can make both components in one go. This is why we are focusing in this hackathon-challenge on the understanding of a question.

One central element that we identified for that is so-called Named Entity Recognition (NER). It is the identification of pre-defined categories such as person names, locations, organization names, time expressions, or monetary values in unstructured text. NER converts a normal text into a annotated text like in the following example:
<p align="center">
<img src="https://github.com/statistikZH/statbot/blob/main/documentation/figures/ner_example.png" width="400"   />
 </p><p align="center">
Source: Wikicommons distributed under a CC-BY 2.0 license.</p>

Identifying such named entities enables us (according to our assumptions) to know, whether someone is talking about a specific data category (e.g. population), certain variables (only female population over 40 years old), in certain locations (in the city of Berne), for a certain time (the year 2019).

For the English language there are already very advanced NER with many pre-trained entities that would be relevant for us (including also categories such as cardinal numbers, ordinal numbers, time, money etc.). See for example one of the advertisements on www.wit.ai for an interesting example of advanced pre-trained entities such as order_by and limit (for copyright reasons we are not sharing the picture here).

However, for the German language the available pre-trained NER models contains no more than four entities so far. The recognition of localities such as Zurich, Wil etc. has a benefit for us (although not all of the municipalities in the Canton of Zurich are recognized). However, the remaining three entities (Organizations, Persons and "Misc") are not relevant to us.

Here are some NER-tutorials that you can find. Why not start with one that shows you [which Game of Thrones characters are the ones that are mentioned in the text-script the most](https://towardsdatascience.com/a-really-gentle-introduction-to-named-entity-recognition-and-how-to-use-it-for-data-analysis-ab25a1f39020)?

<p align="center"><a href="https://imgflip.com/i/5211ry"><img src="https://i.imgflip.com/5211ry.jpg" title="made at imgflip.com"/></a><div><a Source: imgflip.com</a></div></p>

But there are also many other NER-tutorials out there:
- https://towardsdatascience.com/named-entity-recognition-with-nltk-and-spacy-8c4a7d88e7da
- https://www.aitimejournal.com/@akshay.chavan/complete-tutorial-on-named-entity-recognition-ner-using-python-and-keras


## Central concept: Part of Speech (POS)
Part of Speech (POS) is very similar to NER in that unstructured text is converted into annotated elements. Instead of having certain pre-trained categories, POS attributes to every word a linguistic attribute like noun, adjective and verb. But POS goes further than that and provides very specific lexical items that help us understand e.g. cardinality, conjunctions, prepositions, and others. In other words, this might help us in combination with NER to extract all the relevant parts of a question, so that we can subsequently work on it. 

In German Language, there is a nicely advanced POS called the Stuttgart-Tübingen-Tagset (STTS). The python-package SPACY contains it for the German language by default. The following figure shows a German sentence splitted in POS (however, not STTS is used in the figure):

<p align="center">
<img src="https://github.com/statistikZH/statbot/blob/main/documentation/figures/pos_example.png" width="800"   />
 </p>
 
 The figure above shows additional information that is generated from POS such as the semantic interconnections/logic between the words. There are further implemented functionalities such as the automatic conversion of a sentence into so-called "noun chunks". In order to show such noun chunks with the sentence above:
 - Welche Gemeinde
 - die grösste Bevölkerung
 - welche
 - 2019
 - den höchsten Ausländeranteil  

The combination of NER and POS could thus provide a substantial amount of information to understand a question in a bot setting.


## Possible solution approach A: Train NER 

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


## Central concept: Bidirectional Encoder Representations from Transformers (BERT)
As we might use a pre-trained BERT model, it could be useful to familiarize yourself with what BERT is in case you do not know it yet. 

A good point to start, that we warmly recommend, is to check [this article explaining what transformers are](https://medium.com/inside-machine-learning/what-is-a-transformer-d07dd1fbec04). Important concepts connected to it, and which are explained in that article very well, are encoders, decoders,masking and attentions (transformers are attentions based). 

We are not going to describe it here in detail but you will find the [original paper end 2018 by Google here](https://arxiv.org/abs/1810.04805) and will find tons of tutorials such as:
- https://towardsdatascience.com/bert-for-dummies-step-by-step-tutorial-fb90890ffe03

## Further reading
For further concepts such as knowledge graphs and the two other possible approaches you can keep on reading [here if you are interested](https://github.com/statistikZH/statbot/blob/main/documentation/04_Research.md).
