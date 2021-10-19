
# Main-Script - see also readme

# preparation of some global constants



src_folder<-"src/"
log_folder<-"log/"
datetime<-format(Sys.time(), "%Y-%m-%d_%H-%M")
flag_force_update<-TRUE



# function to quicker log some output
logger<-function(log_string){
  cat(log_string,sep = "\n",file=paste0(log_folder,"main_",datetime,".log"),append=TRUE)
}


# get the name of all the files in the src-folder
logger("STARTING STATBOT DATA MANAGEMENT...")
logger("LOADING SRC FILES...")
files.sources<-paste0(src_folder,list.files(src_folder))

# separate R and python scripts
logger("SEPARATING SRC FILES...")
r.sources<-NULL
python.sources<-NULL
for(i in files.sources){
  if(substr(i,nchar(i)-1,nchar(i))==".R"){
    r.sources<-c(r.sources,i)
  }else{
    if(substr(i,nchar(i)-2,nchar(i))==".py"){
    python.sources<-c(python.sources,i)}
    else{
      logger("Error: Some Files are neither .R nor .py")
      stop("Stopping the execution")
    }
  }
}

# Cleaning/Removing all the previous R-functions starting with statbot_src_ in case that they are still in memory
rm(list=ls(pat="statbot_src_"))


# source all the R-files
sapply(r.sources, source)


source("data/create_spatial_units_v2.R")
create_spatial_units()





# R-loop: execute all sourced functions statbot_src_XXX
logger("STARTING R-LOOP...")
for(i in lsf.str()){
  start_time<-Sys.time()
  if(substr(i,1,12)=="statbot_src_"){
    print(paste0("Executing script... ",i))
    return_value<-tryCatch(do.call(i,args=list(flag_force_update=flag_force_update)),
                           error=function(c) paste0("error loading r-script: ",c),
                           warning=function(c) paste0("warning loading r-script: ",c),
                           message=function(c) paste0("message loading r-script: ",c))
    end_time<-Sys.time()
    logger(paste0(
      substr(i,13,nchar(i)),
      ": ",
      return_value,
      paste0(" FINISHED IN: ",round(as.numeric (end_time - start_time, units = "secs"),1), " SECONDS")
    ))
  }
}

# python-loop: execute all sourced python files directly
logger("STARTING PYTHON-LOOP...")
for(i in python.sources){
  start_time<-Sys.time()
  print(paste0("Executing script... ",i))
  return_value<-tryCatch(system(paste0("python ",i)),
                         error=function(c) paste0("error loading python-script: ",c),
                         warning=function(c) paste0("warning loading python-script: ",c),
                         message=function(c) paste0("message loading python-script: ",c))
  #TODO: THE PYTHON PART STILL NEEDS A UP-TO-DATE CODE AND HASH-TEST
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


