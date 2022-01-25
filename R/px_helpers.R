# Extract all existing dimension names
extract_value_names <- function(df_px){

  list_names <- names(df_px)

  value_list_names <- list_names[grepl("VALUES", list_names)]

  return(value_list_names)
}

# extract all existing languages
extract_languages <- function(df_px){

  languages <- df_px$LANGUAGES$value

  languages_cleaned <- unlist(strsplit(languages, ",") ) %>%
    str_replace_all("\"", "")

  return(languages_cleaned)
}

# check if all languages are present
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

# extract main language
extract_main_language <- function(df_px){

  main_language <- df_px$LANGUAGE$value

  return(main_language)
}

# replace the total code by -1
replace_total <- function(x){

  x <- replace(x, x==c("999", "-9999"), "-1")

  return(x)
}

# extract the needed dimension names
extract_needed_names <- function(x, ignore_dim){


  not_needed_dimensions <- c("Jahr", "Anné", "Anno", "Year", "Gemeinde", "Commune", "Comune", "Municipality", "Kanton", "Canton", "District")

  x_needed <- x[!grepl(paste0(not_needed_dimensions, collapse = "|"), x)]

  return(x_needed)
}

# extract the list entries with a specific name
extract_needed_values <- function(x_list, needed_names){

  values_needed <- x_list[grep(paste0(needed_names, collapse = "|"), names(x_list))]

  return(values_needed)
}

# create new codes for dimenstion values
create_new_codes <- function(name, value_list){

  values <- unlist(value_list[grep(name, names(value_list))])

  if(any(grepl("0-", values))){
    codes <- as.character(c(-1, seq(0, length(values)-2, 1)))
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

# extract the dimension names or the dimenstion values
extract_dim_value <- function(input_list, typ){

  if(typ == "dim"){
    y <- lapply(input_list, function(x) lapply(x, function(y) names(y)))
  }else if(typ == "value"){
    y <- lapply(input_list, function(x) lapply(x, function(y) y[[1]]))
  }


  y_df <- lapply(y, function(x) do.call(cbind.data.frame, x))

  y_renamed <- lapply(y_df, function(x) rename_all(x, ~str_replace_all(., c("VALUES\\." = paste0(typ, "_name_"), "\\." = ""))))
}

# get needed values
prep_needed_values <- function(input_list){
  existing_value_names <- names(input_list)

  needed_value_names <- extract_needed_names(existing_value_names)

  needed_values <- extract_needed_values(input_list, needed_value_names)
}


# create new dimenstions based on the fuzzy column
split_vairable_dimension <- function(needed_values, fuzzy_column_pattern){
  variable_values <- needed_values[grep(fuzzy_column_pattern, names(needed_values))]

  group_list <- strsplit(variable_values[[1]], " ")

  unique_variables <- unique(unlist(lapply(group_list, function(x) head(x,1))))

  separated_variables <- lapply(unique_variables, function(x) variable_values[[1]][grepl(x, variable_values[[1]])])

  names(separated_variables) <- unique_variables

  needed_values <- c(needed_values[!grepl(fuzzy_column_pattern, names(needed_values))], separated_variables)

}

# get the names of the fuzzy column in all existing languages
get_all_fuzzy_column_languages <- function(df_px, fuzzy_column_name){

  col_names <- lapply(df_px, function(x) names(x))

  fuzzy_col_index <- unique(unlist(lapply(col_names, function(x) which(grepl(fuzzy_column_name,x)))))

  all_col_names <- unlist(lapply(df_px, function(x) names(x[fuzzy_col_index])))

  fuzzy_col_pattern <- paste0(all_col_names, collapse = "|")

  return(fuzzy_col_pattern)
}
