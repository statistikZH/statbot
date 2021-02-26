from __future__ import print_function, unicode_literals
import spacy

nlp = spacy.load('de_core_news_sm')
doc = nlp(u'Welche Gemeinde hat die grösste Bevölkerung?')

# show universal pos tags
print(' '.join('{word}/{tag}'.format(word=t.orth_, tag=t.pos_) for t in doc))
# output: Ich/PRON bin/AUX ein/DET Berliner/NOUN ./PUNCT

# show German specific pos tags (STTS)
print(' '.join('{word}/{tag}'.format(word=t.orth_, tag=t.tag_) for t in doc))
# output: Ich/PPER bin/VAFIN ein/ART Berliner/NN ./$.

# show dependency arcs
print('\n'.join('{child:<8} <{label:-^7} {head}'.format(child=t.orth_, label=t.dep_, head=t.head.orth_) for t in doc))
# output: (sb: subject, nk: noun kernel, pd: predicate)

#named entities
print("Named Entity Recognition:")
for ent in doc.ents:
    print(ent.text)

for chunk in doc.noun_chunks:
    print(chunk.text)
