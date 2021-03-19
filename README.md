# STATBOT.CH
Version 0.0.1b - 27.02.2021 - Preliminary trials

### History
Version 0.0.1 - 21.02.2021 - 27.02.2021 - Preliminary trials

### Intro
The entire documentation of this project can be found in the folder 'documentation'. There are also descriptions of the scripts in there.
See [here](documentation/01_intro_challenge_data.md).  

### How to work on this project

There are two possible ways to work on this challenge: using Google Colab or working locally on your computer.

#### a) Work with Google Colab

Google Colab allows you to work online in your Google Drive. All it requires is a Google account. There is no need for any jupyter notebooks or dependencies to be locally installed on your computer.  

After reading the documentation, just open the following file, follow the instructions, and start coding: 

https://colab.research.google.com/drive/1jyA0aZxjIBL9_gOgswHIIJBj7ZU-RxkE?usp=sharing


### b) Work locally

To work locally on your computer:
- Clone the repository from https://github.com/statistikZH/statbot
- in your command line / terminal, create a virtual environment xxxx
- execute requirements.txt
- connect each notebook to the virtual environment: xxxx  

We use version 3.0 of Spacy  
pip install spacy   

In order to run the code, you will also need to download deu_news_2015_3M into a subfolder called 'external':  
https://www.kaggle.com/rtatman/3-million-german-sentences

You will also need the following German model (large):  
python -m spacy download de_core_news_lg

Also install the packages in requirements.txt (might be outdated - let us know if that's the case).  

Happy coding!
