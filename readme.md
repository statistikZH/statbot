# STATBOT

### Version 1.0.1 - 20.10.2021

In this folder are the main cronjob-like scripts that run all the different R and python scripts in order to generate the newest data for statbot. It is supposed to be built as some form of cronjob to be executed once a day. All the statistical offices can contribute here with scripts. Or they can contribute by adding additional data-values-files and we will find a way to grab those files and insert the values.

- src: include here all the R- and python scripts of your office (see also templates)
- temp: files are downloaded here temporarily
- data/hash.csv: contains all the MD5sum hashes of the files - so we can check whether files are up-to-date
- data/: contains all the main DB-structural csv-files concerning temporal and spatial dimensions, the IDs and description of all the indicators and so on. 
- init_scripts/: contains all the files to create the above DB-structural files. 
- log/folder will be created if you run the main.R script.

- presentations: contain slides about project STATBOT
- old: contains all the files and folders from STATBOT V.0.x.x


Temporary-Notice: The pxR-package has a bug. Use the script here in statbot_read_px.R to read large px-files until the authors fix that package.

### History

- Version 1.0.1 - 13.10.2021 - 20.10.2021 - Complete new version with a new data management logic
- Version 0.x.x - 02.2021-09.2021 - Old versions used in two different hackathons

### Authors contributing to Version 1.x.x
- Christian Ruiz (Statistisches Amt Kanton Zürich)
- Thomas Lo Russo (Statistisches Amt Kanton Zürich)
- Jorin Steiger (Statistisches Amt Kanton Zürich)
- Pauline Maury Laribière (Federal Statistical Office)

Because even federal IT-departments have to cite sometimes :-)


## TODO

#### High Prio:

- Bug: Districs and Cantons in px files?
- ZH: Ein Aggregationsscript von Gemeinden zu Bezirke und Regionen wäre hilfreich
- CH: Ein Aggregationsscript zu Kantone wäre hilfreich
- Script zur Umwandlung in pro 1000 Einwohner

#### Medium Prio:

#### Low prio: 

- Raumplanungsregionen gibt es auch
