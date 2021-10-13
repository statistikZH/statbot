
### Version 0.0.1 - 13.10.2021

### History
# Version 0.0.1 - 13.10.2021 - First Version loading R and Python scripts

### Authors Christian Ruiz
# Because even federal IT-departments have to quote sometimes :-)

# preparation of some global constants

src_folder<-"src/"
log_folder<-"log/"
datetime<-format(Sys.time(), "%Y-%m-%d_%H-%M")

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

# source all the R-files
sapply(r.sources, source)

# R-loop: execute all sourced functions statbot_src_XXX
logger("STARTING R-LOOP...")
for(i in lsf.str()){
  if(substr(i,1,12)=="statbot_src_"){
    print(paste0("Executing script... ",i))
    return_value<-tryCatch(do.call(i,args=list()),
                           error=function(c) paste0("error loading r-script: ",c),
                           warning=function(c) paste0("warning loading r-script: ",c),
                           message=function(c) paste0("message loading r-script: ",c))

    logger(paste0(
      substr(i,13,nchar(i)),
      ": ",
      return_value
    ))
  }
}

# python-loop: execute all sourced python files directly
logger("STARTING PYTHON-LOOP...")
for(i in python.sources){
  print(paste0("Executing script... ",i))
  return_value<-tryCatch(system(paste0("python ",i)),
                         error=function(c) paste0("error loading python-script: ",c),
                         warning=function(c) paste0("warning loading python-script: ",c),
                         message=function(c) paste0("message loading python-script: ",c))
  return_value<-ifelse(return_value==0,"OK","ERROR")
  logger(paste0(
    substr(i,as.integer(gregexpr(pattern ='/',i)[[1]])+1,nchar(i)-3),
    ": ",
    return_value
  ))
}

logger("FINISHED MAIN-SCRIPT.")


