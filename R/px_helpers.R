#' Extract all existing dimension names
#'
#' @param df_px px-table
#'
#' @export
extract_value_names <- function(df_px){

  list_names <- names(df_px$VALUES)


  return(list_names)
}

#' extract all existing languages
#'
#' @inheritParams extract_value_names
#'
#' @export
extract_languages <- function(df_px){

  languages <- df_px$LANGUAGES$value

  languages_cleaned <- unlist(strsplit(languages, ",") ) %>%
    str_replace_all("\"", "")

  return(languages_cleaned)
}

#' check if all languages are present
#'
#' @param languages existing languages in the file
#'
#' @param additional_languages languages added by the parameter additional_languages
#'
#' @param ignore wheter to ignore additional languages or not
#'
#' @export
check_if_all_languages <- function(languages, additional_languages, ignore){

  all_languages <- c("de", "fr", "it", "en")

  if(!is.na(additional_languages)){
    present_languages <- c(languages, names(additional_languages))
  }else{
    present_languages <- languages
  }


  missing_languages <- setdiff(all_languages, present_languages)


  if(length(missing_languages) != 0 & is.na(additional_languages)){
    if(!ignore){
      stop(glue::glue("The following language is missing: {missing_languages}. Insert the missing language into the function or set ignore = TRUE"))
    }else{
      warning(glue::glue("The following languages are ignored and have currently na-values: {missing_languages}"))

    }
  }
  return(missing_languages)
}

#' extract main language
#'
#' @inheritParams extract_value_names
#'
#' @export
extract_main_language <- function(df_px){

  main_language <- df_px$LANGUAGE$value

  return(main_language)
}

#' replace the total code by -1
#'
#' @param x character vecotr
replace_total <- function(x){

  x <- replace(x, x %in% c("999","-9999","-99999"), "-1")

  return(x)
}

#' extract the needed dimension names
#'
#' @param x list with the dimensions
#'
#' @param ignore_dim dimenstions to be ignored
#'
#' @export
extract_needed_names <- function(x, ignore_dim){
  if(is.na(ignore_dim)){
    ignore_dim <- NULL
  }

  not_needed_dimensions <- c("Jahr", "Anné", "Anno", "Year", "Gemeinde", "Commune", "Comune", "Municipality", "Kanton", "Canton", "District", ignore_dim)

  x_needed <- x[!grepl(paste0(not_needed_dimensions, collapse = "|"), x)]

  return(x_needed)
}

#' extract the list entries with a specific name
#'
#' @param x_list list with the dimension information
#'
#' @param needed_names names of list entries that need to be extracted
#'
#' @export
extract_needed_values <- function(x_list, needed_names){

  values_needed <- x_list[grep(paste0(needed_names, collapse = "|"), names(x_list))]

  return(values_needed)
}

#' create new codes for dimenstion values
#'
#' @param name name of the dimension
#'
#' @param value_list list with the dimension values
#'
#' @export
create_new_codes <- function(name, value_list){

  values <- unlist(value_list[grep(name, names(value_list))])

  if(any(grepl("0-", values))){
    codes <- as.character(c(-1, seq(0, length(values)-2, 1)))
  }else if(!any(grep("Total|totale|total", values))){
    codes <- as.character(c(seq(1, length(values), 1)))
  }else{
    if(length(values)  == 1){
      codes <- "-1"
    }else{
      codes <- as.character(c(-1, seq(1, length(values)-1, 1)))
    }

  }

  if(length(values) != length(codes)){
    stop("Values and Codes are not the same length")
  }

  return(codes)
}

#' extract the dimension names or the dimenstion values
#'
#' @param input_list px file list
#'
#' @param typ what to extract. either "dim" or "value"
#'
#' @export
extract_dim_value <- function(input_list, typ){

  if(typ == "dim"){
    y <- lapply(input_list, function(x) lapply(x, function(y) names(y)))
  }else if(typ == "value"){
    y <- lapply(input_list, function(x) lapply(x, function(y) y[[1]]))
  }


  y_df <- lapply(y, function(x) do.call(cbind.data.frame, x))

  y_renamed <- lapply(y_df, function(x) rename_all(x, ~str_replace_all(., c("VALUES\\." = paste0(typ, "_name_"), "\\." = ""))))
}

#' get needed values
#'
#' @param input_list px file list
#'
#' @param ignore_dim dimenstions to be ignored
#'
#' @export
prep_needed_values <- function(input_list, ignore_dim){
  existing_value_names <- names(input_list)

  needed_value_names <- extract_needed_names(existing_value_names, ignore_dim)

  needed_values <- extract_needed_values(input_list, needed_value_names)
}


#' create new dimenstions based on the fuzzy column
#'
#' @param needed_values list with the needed values
#'
#' @param fuzzy_column_pattern pattern containing the fuzzy column name in all existing lanugages
#'
#' @export
split_vairable_dimension <- function(needed_values, fuzzy_column_pattern){
  variable_values <- needed_values[grep(fuzzy_column_pattern, names(needed_values))]

  group_list <- strsplit(variable_values[[1]], " ")

  unique_variables <- unique(unlist(lapply(group_list, function(x) head(x,1))))

  separated_variables <- lapply(unique_variables, function(x) variable_values[[1]][grepl(x, variable_values[[1]])])

  names(separated_variables) <- unique_variables

  needed_values <- c(needed_values[!grepl(fuzzy_column_pattern, names(needed_values))], separated_variables)

}

#' get the names of the fuzzy column in all existing languages
#'
#' @param df_px list with the information
#'
#' @param column_name column name
#'
#' @export
get_column_name_all_languages <- function(df_px, column_name){

  col_names <- lapply(df_px, function(x) names(x))

  col_index <- unique(unlist(lapply(col_names, function(x) which(grepl(column_name,x)))))

  all_col_names <- unlist(lapply(df_px, function(x) names(x[col_index])))

  col_pattern <- paste0(all_col_names, collapse = "|")

  return(col_pattern)
}
