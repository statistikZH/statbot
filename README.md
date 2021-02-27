# STATBOT.CH
Version 0.0.1 - 26.02.2021 - Pre-liminary trials

### History
Version 0.0.1 - 21.02.2021 - 26.02.2021 - Pre-liminary trials

### How to install Spacy (3.0)
pip install spacy
python -m spacy download de_core_news_lg

In order to replicate the code you need also to download deu_news_2015_3M into a subfolder called external:
https://www.kaggle.com/rtatman/3-million-german-sentences

### Drawing of Logic
01: Get Datasets
02: Generate and tag Sentences
03: Train and Evaluation
04: Flask app using model

### Weitere aktuelle Überlegungen
- Momentan nur datasets von Gemeindeporträt
- Es gibt datensets ohne main variable (Temperatur und Luftfeuchte). Metadaten sollten den Typ und die main variables und die Filtervariablen enthalten.
- Datasets sollten Beschreibungen für jede Variable enthalten
- Datasets sollen alle Levels enthalten
