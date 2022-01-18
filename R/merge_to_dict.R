#' Function to merge the values to a dictionary
#'
#' This function corrects the values of a column with the supposed data values
#' in a dictionary.
#'
#' @param df a df where the values are included
#' @param var_name the name of the variable to be replaced
#' @param dict a df with the value_ids to merge
#'
#' @export df is the same df but with the replaced variable
merge_to_dict<-function(df,var_name,dict){
  df[,var_name]<-gsub(".*Total","Total",df[,var_name],ignore.case = T)
  df<-merge(df,dict[,c("value_id","value_name_de")],by.x=var_name,by.y="value_name_de")
  df[,var_name]<-df$value_id
  df$value_id<-NULL
  return(df)
}
