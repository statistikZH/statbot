# How to contribute to the collection of data

Hello, and thank you for joining the STATBOT-team! This documentation shows what steps have to be done to contribute to the collection of data. It also serves as a documentation for the different functions. This readme is work-in-progress: please help us by indicating which informations would be the most useful to you.  


## Setup

You can start right away with R or python. The "main-script"" is written in R but executes all R and python source files in a cronjob-like manner.

### R

You can just open the R-project file statbot.Rproj. Then you have to initialize renv with renv::init(). Then you should be set-up and have the necessary packages. 
You can load `devtools::load_all(".")` to have all the scripts in your environment for easier working. 

### Python

For python there is a virtual environment under statbot_env that can be activated with `source stabot_env/bin/activate`. However it usually not works like this. At the moment we activate it and then still have to pip install all the packages: `pip install -r requirements.txt`


## Data Collection

First of all, you can find a dataset that nobody is working on yet. You can find an [overview here](https://github.com/statistikZH/statbot/projects/2). There you can see on the kanban-board several columns. Just grab a dataset that is on the left side "to do" and move it to the second column "in progress". Open the tasks and put your initials in brackets like [CR] so that we know who is working on that dataset.

![Github projects](/readme_folder/img/github_projects.PNG).


At the moment of writing, the [best overview of the datasets is still on google sheets]( https://docs.google.com/spreadsheets/d/1LtExe4Kj0OVE8aGsfqLJnWiGtW6nqN1etqBBzpEDLoA/edit#gid=1224865549). This is particularly important for the dataset-id ("class_id") that has to be used in the code. 


in R there is a function to initialize a template-script in the right folder "R". Use the following command:
`download_dataset_init(dataset_id,author)`. The dataset_id you got from the above mentioned spread sheet and you just fill out your name as author.

Then the templates consists of several standard elements. Every dataset is named like the following:
`statbot_src_3_02_001_CH`. It thus starts with statbot_src_ and then contains the dataset_id and ends with "CH" if the script is for the scope of Switzerland, or for example "ZH" if it is only for data from Zurich. 

Every function has a parameter flag_force_update that if TRUE forces the function to execute. If it is FALSE there is the helper-function `check_changes_in_input_file(destfile)` that is executed (destfile being the file downloaded for this dataset). The helper-function makes a MD5-hash of the file to see whether there is a new file or whether this particular file has already been extracted. If new, then it includes the new hash as being more up-to-date into a hash-table under data/hashes.csv. 

Then you can start with the data cleaning of that dataset. The aim is to get a "fact table" that contains the following variables (according to version 3 of our DB-schema):

![Fact Table](/readme_folder/img/fact_table.PNG)

## Metadata

You should not forget to include the metadata for your dataset! The following to steps have to be made:

### Inserting a new class in the classes overview

The following script programmatically generates the file data/classes.csv that contains all the metadata about the datasets: R/create_classes.R . In this script you will see blocks of code like the following:

![Create Classes](/readme_folder/img/create_classes.PNG).

Just copy one and change the data.frame-name and the class_id to your new id that ouve'got from the spread sheet menioned previously. Adapt all the other information to your dataset. You might find your ID also in comments like here: 
 ` #'population_density': '1_01_002',`
Here it shows the class_name as well, which is the second parameter. This class_name is configurated in english and is a variable value that is not human-readable. All the other Names and Descriptions are meant to be human-readable elements. If you have questions come to us.

Then there is a file that generates the dimensions.csv file: R/create_dimensions.R

Every dimension like sex, age, origin has an own dim_id and contains some meta-data about the dimension itself as well as about the values that are used. Please check first whether the dimension you want to use is already there. The dimension_id is then necessary to fill in for the classes created in the script mentioned before. The unique_name is a variable_name in English to be used in your fact-table. We were advised to use human-readable column names this is why we do not use dim_ids anymore (since V3 of the DB-schema). 

![Create Dimensions](/readme_folder/img/create_dimensions.PNG).


## Continuing with the data cleaning. 

The current_id is on Swiss federal level the "BFS-NR" used for communes, districts and cantons. If you are working on regional data, you would have here your own ids. But they have to be converted to hist_ids with the function `convert_current_to_hist_id(df, reference_point)`. The FSO itself has for communes and districts a hist-id, which we generated in the create_spatial_units.R file that is explained here. It creates a csv-table spatialunits.csv that contains current_id, hist_id, ontologies and dates of validity.

In order to run that function you need three elements (two parameters). You need to have defined a dataframe already that consists a column spatialunit_current_id with the above mentioned id. And you need a colum with the spatialunit_ontology e.g. "A.ADM3" for communes (see please the documentation here for a list of ontologies used). These two elements are just given into the function as a dataframe. The last element needed is the day of validity for the spatial data in that dataset ("reference_point"). The parameter is given in the character-format like "1.12.2021" (day.month.year). The function that is going to filter all elements that were valid that day (imagine two communes merging: if they merges on 1.6.2021 then they are not the same anymore than on 1.12.2021...). The output of this function is a column with the hist_ids. You should check how many NAs were generated, in order to see if important bugfixging is necessary. Without a hist_id there would be an important unique_id missing for those elements. 

After writing the file out in the data/values folder (in the same logic with your class-id as name) you can execute the function `update_last_updated(class_id)` so that the classes.csv has a value correctly set for the last update on that class. 

## Converting per capita, per area
For this the function `convert_and_write_per_unit()` can be used. More to come on that. 

The function ends with returning "UPDATE OK" if everything went well. 






