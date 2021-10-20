# Explanation of Scripts in the github repo so far

## The following scripts are all for solution approach A linked to training own NERs

### Script A01 

All publicly available data (Open Government Data – OGD) of the Statistical Office of the Canton of Zurich are extracted from the central JSON-file. By downloading and opening up every file, additional data can be extracted such as variable names that are not described in the metadata. Extracted is thus a combination between metadata and some information in the dataset. 

This could later be improved to save the data in a mysql-db.

### Script A02

The second script generates the training dataset with questions and adds the desired new tags (such as granularity and datasets) in the Spacy-format so that it can be used for the training. 

It loads a csv-file with pre-written questions that contain brackets to insert elements such as {dataset} or {year} or {granularity} etc. The csv-file can be added with additional questions. For every dataset that we have, several questions are being generated randomly. 

A lot can be improved in this script. Maybe the script could be combined with the generation of training-data for the second approach that is described further below (seq2SQL).

At the moment, the script only generates data for the so-called "Gemeindeportraet" of the Statistics Office of the Canton of Zurich. The reason is that the data-variables are all in the same format with the same variable names. We want of course to get away from that structure to be able to use all kind of statistical OGD.

### Script A03

Training is being done based on a pre-trained bert-base-multilingual-cased by using transfer learning. At the end of the script, there is also some sort of evaluation showing the previously four included NER tags (because transfer learning can change their accuracy), and the new NER tags.


Info: Right now there is no link yet with POS (Position of Speech).
