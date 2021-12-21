# STATBOT

### Version 3.1.0 - 21.12.2021

In this folder are the main data warehouse scripts that run all the different R and python scripts in order to generate the newest data for statbot. It is supposed to be built as some form of cronjob to be executed once a day. All the statistical offices can contribute here with scripts. Or they can contribute by adding additional data-values-files and we will find a way to grab those files and insert the values.

For those who would like to participate, we prepared ['under this link a documentation'](readme_folder/data_collection.md) that can be followed step by step.

Important for this project is a DB-schema, in which all the data are collected. Right now the following schema is used:

![DB-Scheme V3.0.2](/readme_folder/img/db_scheme_v302.png).

There are several elements to it. The fact-table is the central element, where the actual data of the datasets are saved. Thus, every dataset is saved in this format and only differs according to certain dimensions (as of V3).

Next to the fact-table, there is a class-table that contains all the datasets (called classes) and their meta-data. It contains a table, where all the spatial units are saved. ['For a detailed explanation on the spatial units table click here'](readme_folder/spatialunits.md). And it contains a dimensions-table where all the dimensions such as gender, age and origin and their corresponding values are saved. 


TODO: THE FOLLOWING HAS TO BE REWRITTEN FOR V3 - ORIENTATION OF THE FILE STRUCTURE

- src: include here all the R- and python scripts of your office (see also templates)
- temp: files are downloaded here temporarily
- data/hash.csv: contains all the MD5sum hashes of the files - so we can check whether files are up-to-date
- data/: contains all the main DB-structural csv-files concerning temporal and spatial dimensions, the IDs and description of all the indicators and so on. 
- init_scripts/: contains all the files to create the above DB-structural files. 
- log/folder will be created if you run the main.R script.

- presentations: contain slides about project STATBOT
- old: contains all the files and folders from STATBOT V.0.x.x


Important Temporary-Notice: The pxR-package to read px-files within R has a bug. Use the script here in statbot_read_px.R to read large px-files until the authors fix that package (PR is there pending for a while).

### Authors contributing from Version 1.x.x upwards (alphabetically)
- Knecht, Thomas (Statistisches Amt Kanton Zürich)
- Lo Russo, Thomas (Statistisches Amt Kanton Zürich)
- Maury Laribière, Pauline (Federal Statistical Office)
- Pieters, Hester (Statistisches Amt Kanton Basel-Stadt)
- Ruiz, Christian (Statistisches Amt Kanton Zürich)
- Steiger, Jorin (Statistisches Amt Kanton Zürich)

![Team photo - picture seems to be CC](https://user-images.githubusercontent.com/12788884/146254759-60c53e6e-7378-45ca-9fcf-0b3944b9c92e.png)



### History
- Version 3.1.0 - 21.12.2021 - Totals are all set to -1 instead of 0
- Version 3.0.2 - 16.12.2021 - 21.12.2021 New spatial units elements implemented, many V3 updates
- Version 3.0.0 - 12.2021 - back to "more simple" DB-scheme aiming for a first MVP next summer.  
- Version 2.x.x - 11.2021 - "complex" DB-Scheme that was aiming to integrate all possibilities of linked data
- Version 1.0.2 - 21.10.2021 - 21.10.2021 - Dimensions changed to 6, inserted code to fill dimensions with NAs
- Version 1.0.1 - 13.10.2021 - 20.10.2021 - Complete new version with a new data management logic
- Version 0.x.x - 02.2021-09.2021 - Old versions used in two different hackathons



