# STATBOT.CH
Version 0.0.1b - 27.02.2021 - Pre-liminary trials

### History
Version 0.0.1 - 21.02.2021 - 27.02.2021 - Pre-liminary trials

### Intro
The entire documentation is under the folder documentation. 
Start with [this](documentation/01_intro_challenge_data.md). There are also descriptions of the scripts in it. 


### How to install the repo
There are some folders included in the .gitignore. By running the first script, the data in the data-folder is generated.

In order to replicate the code you will also need to download deu_news_2015_3M into a subfolder called external:
https://www.kaggle.com/rtatman/3-million-german-sentences

We use version 3.0 of Spacy
pip install spacy

And you will need the following german model (large):
python -m spacy download de_core_news_lg

Also install the packages in requirements.txt (might be out to date - tell me).

