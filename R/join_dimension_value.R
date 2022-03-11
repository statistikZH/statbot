#' Function to merge the values to a dictionary
#'
#' This function corrects the values of a column with the supposed data values
#' in a dictionary.
#'
#' @param df a df where the values are included
#' @param dim_name the name of the dimension to be replaced
#' @param dict a df with the value_ids to merge
#' @param var_name if divergent from the dim_name: the name of the variable to be replaced. Default would be NULL equivalent to dim_name
#'
#' @export
join_dimension_value<-function(df,dimension_name,dimension_table, main_language="de",var_name=NULL){

  dimension_value_language <- paste0("value_name_", main_language)

  dimension_name_sym <- sym(dimension_name)

  dimension <- dplyr::filter(dimension_table, unique_name == dimension_name) %>%
    dplyr::select(value_id, !!dimension_name_sym := !!sym(dimension_value_language))

  if(!is.null(var_name)) {
    var_name_sym<-sym(var_name)
    df<- df %>% rename(!!dimension_name_sym := !!var_name_sym)
  }

  #df[,var_name]<-gsub(".*Total","Total",df[,var_name],ignore.case = T)
  df<-dplyr::left_join(df, dimension, by = dplyr::quo_name(dimension_name)) %>%
    dplyr::select(-!!dimension_name_sym) %>%
    dplyr::rename(!!dimension_name_sym := value_id)

  if(!is.null(var_name)) df<- df %>% rename(!!var_name_sym := !!dimension_name_sym)

  return(df)

  gc()
}
