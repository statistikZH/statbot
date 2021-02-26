# add NER to the pipeline and the new label
import spacy
#import de_core_news_lg
nlp = spacy.load('de_core_news_lg')
nlp.initialize()
