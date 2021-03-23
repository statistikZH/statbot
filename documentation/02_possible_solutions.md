# A Potential Solution: Approach based on Named Entity Recognition (NER)
In the following, we present our current approach and some concepts that we thought could be relevant. However, we would really like to emphasize that you are completely free to choose your own, different approach. We are looking forward to your ideas and to hearing whether our thoughts and assumptions are going in the right direction.

We believe that the most suitable approach to tackle the challenge is the Named-Entity Recognition (NER) approach, because the other approaches that we identified would probably also require a NER in the first step (of course we might be wrong in this assumption). We therefore suggest that in this challenge, we focus on this approach. Below is a brief introduction into the main concepts. However, there are also other approaches that might be well-suited to tackle the challenge, for example a seq2SQL and a TaPas approach. If you would like to dig deeper and learn more about our thoughts on these two approaches, please see [here](https://github.com/statistikZH/statbot/blob/main/documentation/04_Research.md).  We think that we will require seq2SQL later in the project -- so if you are interested, you are of course very welcome to try it!

## Central concept: Named Entity Recognition (NER)
As a reminder, in this challenge, we would like to focus on the problem that the statbot should be able to "understand" the question and "decide" which dataset to use to answer a given question (see introduction).

One central method that we think might be suitable to solve this problem is Named Entity Recognition (NER). NER refers to the identification of pre-defined categories such as names, locations, time expressions, or monetary values in unstructured text. NER converts a normal text into annotated elements just like in the following example:
<p align="center">
<img src="https://github.com/statistikZH/statbot/blob/main/documentation/figures/ner_example.png" width="400"   />
 </p><p align="center">
Source: Wikicommons distributed under a CC-BY 2.0 license.</p>

We think that identifying useful named entities should help us extract whether a posed question speaks to a specific data category (e.g., population), certain variables (e.g., only female population over 40 years old), certain locations (e.g., in the city of Berne), or certain period of time (e.g., the year 2019).

For the English language, there are already very advanced NER models with many pre-trained entities that would be relevant for us (including also categories such as cardinal numbers, ordinal numbers, time, money etc.). See for example one of the advertisements on www.wit.ai for an interesting example of advanced pre-trained entities such as order_by and limit (for copyright reasons, we do not share the picture here). However, for the German language, the available pre-trained NER models generally contain only very few entities. They only recognize certain places locations such as Zurich but not all municipalities of the Canton of Zurich. We will therefore need to train our own entities.

Below are some freely available NER tutorials.  

- Why not start with one that shows you [which Game of Thrones characters are mentioned the most in the text-script](https://towardsdatascience.com/a-really-gentle-introduction-to-named-entity-recognition-and-how-to-use-it-for-data-analysis-ab25a1f39020)?  

<p align="center"><a href="https://imgflip.com/i/5211ry"><img src="https://i.imgflip.com/5211ry.jpg" title="made at imgflip.com"/></a><div><a Source: imgflip.com</a></div></p>

Other NER tutorials:
- https://towardsdatascience.com/named-entity-recognition-with-nltk-and-spacy-8c4a7d88e7da
- https://www.aitimejournal.com/@akshay.chavan/complete-tutorial-on-named-entity-recognition-ner-using-python-and-keras


## Central concept: Part of Speech (POS)
Another concept that might help us (in combination with NER) to extract all the relevant parts of a given question is the method "Part of Speech" (POS). POS is very similar to NER in that unstructured text is split up and annotated elements are added. POS adds a linguistic attribute such as "noun", "adjective" or "verb" to each word. Furthermore, POS can also indicate whether a word is a conjunction, preposition, etc.  

For the German language, there is a pretty advanced POS called the Stuttgart-Tübingen-Tagset (STTS). It is the default for the German language in the python library spaCy.  
The following figure shows a German sentence that has been split using POS (however, here STTS was not used):

<p align="center">
<img src="https://github.com/statistikZH/statbot/blob/main/documentation/figures/pos_example.png" width="800"   />
 </p>
 
 The figure above shows additional information that is generated using POS such as the semantic interconnections/logic between the words. There are also other implemented functionalities such as the automatic conversion of a sentence into so-called "noun chunks". An example for such noun chunks is the following split-up sentence:
 - Welche Gemeinde
 - die grösste Bevölkerung
 - welche
 - 2019
 - den höchsten Ausländeranteil  

## Possible approach: Train NER 

To implement an NER approach, we need to create our own entities. Potentially useful, customised entities could be, for example, dataset names, variable names, granularity (e.g., population at federal, cantonal, district or municipality level?), or textual information such as "greater than", "per month", "for all municipalities in the canton of Zurich", or "from 2005 to 2008" (if they cannot already be extracted with POS). 

We have already experimented a bit with this approach. Our code is on github, and you can use it as a starting point or inspiration (see the picture below, where we tried to train own NERs). 

![Example of two additionally trained NER for granularity and datasets](https://github.com/statistikZH/statbot/blob/main/documentation/figures/ner_third_attempt.png)

To illustrate the principle of naming entities: imagine the following German sentence "Anteil der Personen mit Einkommen über 5000CHF pro Monat" or in English "share of people with income over 5000 Swiss Francs per month"." Entities could be share (a relativity commonly understood in percent), people (as opposed to companies, economic sectors or others that also have some sort of income), the main variable income, over 5000CHF, per month. 

Our code to train our own NERs has been mostly taken from the following source. It also contains an excellent explanation of NERs and the different steps required to train NERs:
https://deepnote.com/publish/2cc2d19c-c3ac-4321-8853-0bcf2ef565b3

The description of our scripts can be found [here](https://github.com/statistikZH/statbot/blob/main/documentation/05_Explanation_Scripts.md).
 
You might also find some interesting information and some sources with pre-trained NERs in German here: 
- https://huggingface.co/transformers/v2.2.0/examples.html#named-entity-recognition
- https://sites.google.com/site/germeval2014ner/data

To build named entity recognition models in R, we recommend having a look at two packages from the [udpipe](https://cran.r-project.org/web/packages/udpipe/vignettes/udpipe-universe.html)-familiy. 

- [crfsuite](https://cran.r-project.org/web/packages/crfsuite/vignettes/crfsuite-nlp.html) 
- [nametagger](https://cran.r-project.org/web/packages/nametagger/index.html)

For an OpenCalais adaptation by Liip (Stefan Oderbolz) see also: https://github.com/metaodi/wikidata-highlight


## Central concept: Bidirectional Encoder Representations from Transformers (BERT)
As we might use a pre-trained BERT model, it could be useful to familiarize yourself with what BERT is in case you do not know it yet. 

A good start pointing is [this article which explains what transformers are](https://medium.com/inside-machine-learning/what-is-a-transformer-d07dd1fbec04). Important concepts connected to it, and which are very well explained in this article are encoders, decoders, masking and attentions (transformers are attentions based). 

We are not going to describe those concepts here but you can find the [original paper end 2018 by Google here](https://arxiv.org/abs/1810.04805). Furthermore, there are many different tutorials such as:
- https://towardsdatascience.com/bert-for-dummies-step-by-step-tutorial-fb90890ffe03

## Further reading
For further concepts such as knowledge graphs and two other possible approaches we have considered you can have a look [here if you are interested](https://github.com/statistikZH/statbot/blob/main/documentation/04_Research.md).

## Caveat
What if the NER-step is unnecessary? What if the question could directly be linked with identifying the right dataset and that the rest is not necessary? We would be glad to hear your expert feedback on that.
