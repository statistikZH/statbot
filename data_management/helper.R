check_changes_in_input_file<-function(file_name){
  hash<-tools::md5sum(file_name)
  if(is.na(hash)) stop("Error: Could not build a md5sum")
  hash_file<-read.csv("data/hashes.csv")
  selected_hash<-hash_file$hash[hash_file$file_name==file_name]
  if(!is.character(selected_hash)) selected_hash<-"NO"
  if(length(selected_hash)==0) selected_hash<-"NO"
  if(selected_hash==hash){
    #no change
    return(FALSE)
  }else{
    #change occured
    new_line<-data.frame(file_name=file_name,hash=hash)
    hash_file<-rbind(hash_file,new_line)
    write.csv(hash_file,"data/hashes.csv",row.names = F)
    return(TRUE)
  }
}
