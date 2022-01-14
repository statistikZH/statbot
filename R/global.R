
constants<-jsonlite::read_json("constants/constants.json")
GLOBAL_TOTAL_LIST<-unlist(constants$GLOBAL_TOTAL_LIST,use.names=F)
