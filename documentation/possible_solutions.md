WORK IN PROGRESS

# 1) Named Entity Recognition

Die folgende Lösung ist eine pre-trained NER auf Deutscher Sprache. Sie kann die Lokalitäten etc verstehen, da auf WIkipedia trainiert. Aber andere Entities (Granularität, Datasets etc.) nicht.

https://huggingface.co/transformers/v2.2.0/examples.html#named-entity-recognition

https://sites.google.com/site/germeval2014ner/data


Ebenfalls interessante Codes, um NER selber zu erstellen sind die folgenden. Aber auch da werden bereits labeled NER datasets verwendet - und das haben wir ja nicht.


https://towardsdatascience.com/complete-guide-to-building-a-chatbot-with-spacy-and-deep-learning-d18811465876

https://github.com/mtaruno/eve-bot/blob/master/3.1.%20Named%20Entity%20Recognition.ipynb

und

https://towardsdatascience.com/custom-named-entity-recognition-using-spacy-7140ebbb3718


Eine weitere Lösung auch über OpenCalais hier von liip (Stefan Oderbolz): hhttps://github.com/metaodi/wikidata-highlight

Bei den bisherigen Lösungen müsste man die eigenen ENtities selbst hinzufügen. Das ist aber auch nicht unmöglich und vielleicht gibt es auch Möglichkeiten, um dies automatisert zu machen. Beispielsweise könnte man die Germeneval2014 Daten nehmen, um eigene labels hinzuzufügen. Kantonal, Gemeinde, Bezirke... Namen der Datasets (Begriffe wie Bevölkerung, Mobilität usw.).


Eine weitere Schwierigkeit werden zusammenhängende Zahlen sein. "Anteil der Personen mit Einkommen über 5000CHF pro Monat" → Entities sind Anteil (Prozentuale Relativität, Personen (und nicht Firmen, Branchen o.ä.),Einkommen, über 5000CHF, pro Monat. 
1B) NER mit eigener Datengenerierung!

Schritt 1) Man erstellt ein eigenes gelabeltes Dataset! Es besteht aus Sätzen die selbst automatisiert erstellt werden. Dabei geht er durch alle Datasets in der Datenbank und erstellt fragen zu allen darin vorhandenen Variablen. Die Labels werden mitgeneriert. Dabei soll alles notwendige beachtet werden - auch solcher Relationsangaben und spezielle Zeitangaben etc. (Das Script müsste so geschrieben sein, dass es für jeden Teildatensatz der teilnehmenden Organisationen dynamisch durchlaufen werden kann)

Schritt 2) Wie im oben beschriebenen Beispiel von huggingface verwenden wir z.B. bert-base-multilingual-cased, um ein Modell zu trainieren.

2A) Es gibt einige gelabelte Deutsche Datensets für NER (z.B. mehrere GermanEval competitions). Nach aktuellem Kenntnissstand gibt es aber für die deutschen Datensets nur 4 entities. Location könnte interessant für uns sein aber nicht Personen/Organisationen/Others. Die englischen Modelle sind da viel besser trainiert und beinhalten auch: cardinal, time, ordinal, date, und money.

2B) Es scheint mit dem STTS in Spacy ein gutes POS (Position of Speech) zu geben. Das hilft stark, um die Sätze richtig zu verstehen. (siehe auch https://explosion.ai/blog/german-model

2C) Ein vortrainiertes Modell muss verwendet werden. Es muss nicht unbedingt BERT sein - Spacy und Scikit beinhalten scheinbar ebenfalls gute vortrainierte Modelle

Schritt 3) Wenn user das system testen oder verwenden, dann werden die Fragen gespeichert und manuell gelabeled, um einen zweiten dataset zu haben und den NER noch besser zu trainieren.


Folgende Artikel beschreibt gut, wie man zusätzliche entities generieren kann: https://deepnote.com/publish/2cc2d19c-c3ac-4321-8853-0bcf2ef565b3



# 2) Seq2SQL
Based on this paper by Zhong et al. 2017:
https://arxiv.org/pdf/1709.00103.pdf
https://github.com/salesforce/WikiSQL

There are also other github-repos trying to implement the elements in that paper. Overview here:
https://paperswithcode.com/paper/seq2sql-generating-structured-queries-from
e.g.
https://github.com/tiwarikajal/Seq2SQL--Natural-Language-sentences-to-SQL-Queries

They use reinforcement learning (RL) to train a model. However, the execution accuracy of 59.4% and the logical form accuracy of 48.3% are still quite low even though they achieved a very large jump to previous efforts (35.9% and 23.4% respectively). The following two figures are taken out of Zhong et al.'s paper on p.2:

![Zhong et al. 2017 figures 1 and 2](figures/zhong_2017_fig2and2.png)

Zhong et al. argue that a SQL query csists of three components. An aggregation operator such as COUNT or SUM. The second component is SELECT to identify the columns that are to be given out. And the thirs component is the WHERE clause to filter. Seq2SQL also consits of three parts that correpond to these three components. 


See also that we are already much further than in the original paper by Zhong et al. 2017. See for example Li et al. (2020) reaching over 90% accuracy: 
https://github.com/louis-li/SeqGenSQL



3) 
aPas ist ein interessanter Lösungsansatz, deraber einige Ecken und Kanten hat. Zunächst beruht TaPas auf Text-Tabellen Paaren. Eigentlich könnten wir das lösen, indem wir in einem ersten Schritt ein ML-Algorithmus verwenden, um den wahrscheinlichsten Datenset ausfindig zu machen (an sich keine Hexerei). Danach müsste die Tabelle nach dem Text durchsucht werden. Das Maximum von 500 Zellen ist dabei ein Hindernis. Das könnte man lösen, wenn man aus der Frage bereits gewisse Elemente extrahieren kann, wie die Lokalität. Dann könnte man den Datenset vorfiltern, damit dann weniger als 500 Zellen übrig bleiben. Erst dann könnte man TaPas anwenden und eine Antwort generieren.


Das grössere Problem bei TaPas ist aber das pre-training, welches nicht nur sehr rechenintensiv ist, sondern auch ein vorgefertigtes Deutsches Datenset benötigt (z.B. ein Paar Dataset Textsegmente und Tabellen. Dann braucht es noch das deutsche BERT (müsste OK sein) und dann das finetuning an unseren Tabellen.


Letztes Problem: Selbst beim ausführen des Modells braucht eine Antwort bei einer kleinen Tabelle sehr lang (min 1 Minute siehe Beispiel auf huggingface - muss es aber nochmals testen). Kleinere Modelle sind weniger genau.



https://github.com/google-research/tapas

https://ai.googleblog.com/2020/04/using-neural-networks-to-find-answers.html

https://www.aclweb.org/anthology/2020.acl-main.398.pdf

Aber dafür müsste dies auf Deutsch umgewandelt werden. pre-trained mit Wikipedia German tables? Finetuned mit uenseren Daten? Aber der gleiche Datensatz wie auf Englisch (Wikipedia Tables) gibt es nicht auf Deutsch.


Auch Facebook hat ein paper in diese Richtung: TaBERT

https://arxiv.org/pdf/2005.08314v1.pdf


Auch von Google Research zu TaPas:

https://www.aclweb.org/anthology/2020.findings-emnlp.27.pdf


Schritte:

TaPas hat keinen Code für das scraping von Wikipedia geteilt, da es auf einen internen dump beruht. Folgender Code könnte aber helfen, um Textsegment-Tabellen-Paare zu erstellen: https://github.com/wenhuchen/WikiTables-WithLinks/blob/master/preprocessing/pipeline.py



4) Easy solution

Vordefinierte Listen. Keine fortgeschrittene NLP. Beispiel:

https://github.com/metaodi/schlaumeier

Das könnte man mit Lemming und Stemming rein vom Input etwas verbessern. Es bleiben aber verschiedenste Probleme wie mit den zusammenhängenden Zahlen usw.



4) Knowledge Graphs
One right now not very likely solution is to use knowledge graphs used through semantic parsing (e.g. Zelle and Mooney 1996; Wong and Mooney 2007). 

Ich hatte einige gute Links, die ich noch nachreichen werde.

FOlgenden Link habe ich noch nicht gelesen:

https://www.analyticsvidhya.com/blog/2019/10/how-to-build-knowledge-graph-text-using-spacy/


5) Zero-Shot Q&A

Mit einem vortrainierten Model (BERT) kann man TExt füttern und ein Zero-shot Q&A machen. Das würde aber bedeuten, dass wir alle Antworten als Text vortrainieren müssten. Aber das macht ja keinen Sinn für statistische Applikationen, die z.B. aus einer DB doer API zunächst berechnet werden müssen (eben Beispiel "Anteil der Personen mit Einkommen über 5000CHF pro Monat" ist vielleicht)




