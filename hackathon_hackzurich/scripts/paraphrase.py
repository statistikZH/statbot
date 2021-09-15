# Script for creating paraphrases and thus expanding the q&a pairs generated through the first script
# At the time of writing it generates from 90 initial q&a pairs, around 

# ML-Model taken from https://github.com/Vamsi995/Paraphrase-Generator
# https://huggingface.co/Vamsi/T5_Paraphrase_Paws

# Version 0.1.1 - 15.09.2021
# Christian Ruiz - Statistisches Amt Kanton Zürich
# CC0



from transformers import AutoTokenizer, AutoModelForSeq2SeqLM
import pandas as pd


tokenizer = AutoTokenizer.from_pretrained("Vamsi/T5_Paraphrase_Paws")  
model = AutoModelForSeq2SeqLM.from_pretrained("Vamsi/T5_Paraphrase_Paws")


df=pd.read_csv("../questions_queries.csv",encoding='latin1')


output_df=df

for i in range(0,df.shape[0]):
    sentence=df['question'].iloc[i]
    print(i," ",sentence)



    text =  "paraphrase: " + sentence + " </s>"

    encoding = tokenizer.encode_plus(text,pad_to_max_length=True, return_tensors="pt")
    input_ids, attention_masks = encoding["input_ids"], encoding["attention_mask"]


    outputs = model.generate(
        input_ids=input_ids, attention_mask=attention_masks,
        max_length=256,
        do_sample=True,
        top_k=120,
        top_p=0.95,
        early_stopping=True,
        num_return_sequences=7
    )

    for output in outputs:
        line = tokenizer.decode(output, skip_special_tokens=True,clean_up_tokenization_spaces=True)
        output_df=output_df.append({'question': line, 'sql': df['sql'].iloc[i]},ignore_index=True)

output_df=output_df[['question','sql']]
output_df['question']=output_df['question'].str.lower()
output_df=output_df.drop_duplicates()

        
output_df.to_csv("../questions_queries_paraphrases.csv",index=False)