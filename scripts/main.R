
# Main-Script - see also readme

# V3.0.2c - 20.12.2021 - adaptations to the V3 DB scheme

# preparation of some global constants
devtools::load_all(".")


src_folder<-"scripts/src"
log_folder<-"log/"
datetime<-format(Sys.time(), "%Y-%m-%d_%H-%M")
flag_force_update<-TRUE

# temporary work_around - PLEASE CHECK IF THEY FIXED THE FUNCTION AT SOME POINT
# https://github.com/cjgb/pxR
#source("statbot_read_px.R")

# check if log-folder exists or create
if(!dir.exists(log_folder)) dir.create(log_folder)





# get the name of all the files in the src-folder
logger("STARTING STATBOT DATA MANAGEMENT...")
logger("LOADING PYTHON SRC FILES...")
python.sources<-paste0(src_folder,"/",list.files(src_folder)) #changed on 20.12.2021 - no sorting anymore

logger("INSTALL/UPDATE PYTHON PACKAGES...")
system("pip install -r requirements.txt")


logger("INIT: CREATE SPATIAL UNITS...")
source("scripts/init_scripts/create_spatial_units.R")
create_spatial_units()

logger("INIT: CREATE CLASSES...")
source("scripts/init_scripts/create_classes.R")
create_classes()

logger("INIT: CREATE DIMENSIONS...")
source("scripts/init_scripts/create_dimensions.R")
create_dimensions()

# 20.12.2021 waiting for Jorins modifications
#logger("INIT: RUNNING BASE CLASSES SUCH AS POPULATION AND AREA...")
#system("python scripts/init_scripts/population.py")


# R-loop: execute all sourced functions statbot_src_XXX
logger("RUNNING R-SCRIPTS...")
dataset_ids_to_download <- get_dataset_ids()

purrr::walk(dataset_ids_to_download, ~download_dataset(., flag_force_update = TRUE))



# python-loop: execute all sourced python files directly
logger("RUNNING PYTHON-SCRIPTS...")
for(i in python.sources){
  start_time<-Sys.time()
  print(paste0("Executing script... ",i))
  return_value<-tryCatch(system(paste0("python ",i)),
                         error=function(c) paste0("error loading python-script: ",c),
                         warning=function(c) paste0("warning loading python-script: ",c),
                         message=function(c) paste0("message loading python-script: ",c))

  return_value<-ifelse(return_value==0,"UPDATE OK","ERROR")
  end_time<-Sys.time()
  logger(paste0(
    substr(i,as.integer(gregexpr(pattern ='/',i)[[1]])+1,nchar(i)-3),
    ": ",
    return_value,
    paste0(" FINISHED IN: ",round(as.numeric (end_time - start_time, units = "secs"),1), " SECONDS")
  ))
}

logger("FINISHED MAIN-SCRIPT.")



