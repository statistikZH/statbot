Technical Documentation

We did the following steps and decisions to create the data for the hackathon.

- Dump of some of the data sets of canton ZH "Gemeindeportraet". This consists of four files.
- Translation of the files to English - this includes names of files as well as all variables
- Script for Federal Office of Energy Data to convert and insert to rest of data
- Decision: create TYPE_ID=0 for Wohnviertel so that the data from Basel-City can be included. 
- Decision: Spatial units from Basel-City will have a SPATIALUNIT_ID that is formed by taking their internal ID and adding 1000. Like this all the spatial units have a unique ID - no matter which granularity level.

Planned:
- Add Basel-City data for already existing indicators. 

