#' Function to extract metadata and generate dimensions
#'
#' This function extracts metadata from a px-file and populates the dimensions-file
#'
#' @param input_df a px-object before conversion into a proper df
#'
#' @param unique_names names of the dimenstions to be exportet (in english)
#'
#' @param ignore_language if missing languages should be ignored
#'
#' @param additional_languages additional language informations as list
#'
#' @param fuzzy_column_name name of the column with mixed dimensions
#'
#' @param ignore_dimensions whether to ignore dimensions or not
#'
#' @param overwrite if an existing dimenstion file should be overwritten or not
#'
#' @export
extract_meta_and_generate_dimensions<-function(input_df, unique_names, ignore_language, additional_languages, fuzzy_column_name, ignore_dimensions, overwrite){


  # extract existing languages
  languages_in_px<- extract_languages(input_df)

  # check if all languages are present. If not, set ignore_language = TRUE do create the dimension table anyways
  missing_languages <- check_if_all_languages(languages_in_px, additional_languages, ignore_language)

  # extract the main language
  main_language <- extract_main_language(input_df)

  # extract all Value informations
  all_language_values <- input_df[grep("VALUES", names(input_df))]

  # add the language information to the main value entry
  new_value_names <- sub("^VALUES$", paste0("VALUES.", main_language,"."), names(all_language_values))

  names(all_language_values) <- new_value_names

  # get the pattern of the fuzzy column name (containing all languages)
  if(!is.na(fuzzy_column_name)){
    fuzzy_column_pattern <- get_column_name_all_languages(all_language_values, fuzzy_column_name)
  }else{
    fuzzy_column_pattern <- "not existing"
  }
  # get the column patterns of the columns to be ignored
  if(!is.na(ignore_dimensions)){

    ignore_dimensions_pattern <- lapply(ignore_dimensions, function(x) get_column_name_all_languages(all_language_values, x))

    #ignore_dimensions_pattern <-paste0("^",unlist(ignore_dimensions_pattern),"$")
    all_ignore_dimensions_pattern <- paste0(ignore_dimensions_pattern, collapse = "|")

  }else{
    all_ignore_dimensions_pattern<-NA
  }


  # extract the needed value informations
  all_language_values_needed <- lapply(all_language_values, function(x) prep_needed_values(x, ignore_dim = all_ignore_dimensions_pattern))



  # for which variables do codes exist
  existing_code_names <- names(input_df$CODES)

  # for wehich variables do we actually need codes (year and location are neclected)
  needed_code_names <- extract_needed_names(existing_code_names, ignore_dim = all_ignore_dimensions_pattern)

  # extract all list entires with the needed code information
  if(length(needed_code_names) == 0){
    needed_codes <- NULL
  }else{
    needed_codes <- extract_needed_values(input_df$CODES, needed_code_names)

  }

  # replace the code for total by -1
  if(length(needed_codes) != 0){
    needed_codes <- lapply(needed_codes, function(x) replace_total(x))
  }

  # extract all dimensions without a code set
  not_existing_codes <- setdiff(names(all_language_values_needed[[1]]), needed_code_names)


  split_values <- function(x){
    x_out <- unlist(strsplit(x, "\",\"|\", \""))
  }

  # clean up all dimenstion information (not separeated in all languages)
  all_language_values_needed_cleaned <- lapply(all_language_values_needed, function(x) lapply(x, function(y) split_values(y)))

  # if a fuzzy column pattern is given, split the column into different dimenstions
  if(any(grepl(fuzzy_column_pattern, not_existing_codes ))){
    all_language_values_needed_test <- lapply(all_language_values_needed_cleaned, function(x) split_vairable_dimension(x, fuzzy_column_pattern))
  }else{
    all_language_values_needed_test <- all_language_values_needed_cleaned
  }

  # get all dimensions without codes inclueding the newly generated dimenstions
  not_existing_codes_new <- setdiff(names(all_language_values_needed_test[[1]]), needed_code_names)

  # create the codes
  if(length(not_existing_codes) != 0){
    additional_codes <- lapply(not_existing_codes_new, function(x) create_new_codes(x, all_language_values_needed_test[[1]]))
    names(additional_codes) <- not_existing_codes_new
  }else{
    additional_codes <- NULL
  }

  # combine the already existing codes with the new ones
  needed_codes <- c(needed_codes, additional_codes)

  # rearrange the list by dimenstion and not by language anymore
  split_by_dimension <- function(position, list_entry){
    output <- lapply(list_entry, function(x) x[position])
  }

  all_language_values_needed <- lapply(c(1:length(needed_codes)), function(x) split_by_dimension(x, all_language_values_needed_test))

  # names of the dimensions
  dim_new_names <- lapply(all_language_values_needed, function(x) names(x[[1]]))

  # extract all dimension names
  dim_names_df <- extract_dim_value(all_language_values_needed, "dim")

  names(dim_names_df) <- unlist(dim_new_names)

  # extract all dimenstion values
  value_names_df <- extract_dim_value(all_language_values_needed, "value")

  names(value_names_df) <- unlist(dim_new_names)

  # if an additional language is given, integrate it into the existing values and dimenstion. otherwise the missing languages are filled with NA
  if(is.na(additional_languages)){
    if(length(missing_languages) != 0){
      add_col<- function(df, col_name){
        mutate(df, !!sym(col_name) := NA_character_)
      }

      dim_names_df_all_languages <- map(dim_names_df, ~reduce(paste0("dim_name_", missing_languages), add_col, .init = .x))
      value_names_df_all_languages <- map(value_names_df, ~reduce(paste0("value_name_", missing_languages), add_col, .init = .x))
    }else{
      dim_names_df_all_languages <- dim_names_df
      value_names_df_all_languages <- value_names_df
    }


  }else{

    additional_language_values_needed <- lapply(c(1:length(additional_languages[[1]])), function(x) split_by_dimension(x, additional_languages))

    dim_names_additional <- extract_dim_value(additional_language_values_needed, "dim")
    # for(i in 1:length(dim_names_additional))
    #   names(dim_names_additional[[i]])<-paste0("dim_name_",names(dim_names_additional[[i]]))
    #
    value_names_additional <- extract_dim_value(additional_language_values_needed, "value")
    # for(i in 1:length(value_names_additional))
    #   names(value_names_additional[[i]])<-paste0("value_name_",names(value_names_additional[[i]]))

    dim_names_df_all_languages <- map2(dim_names_df, dim_names_additional, ~cbind(.x, .y))
    value_names_df_all_languages <- map2(value_names_df, value_names_additional, ~cbind(.x, .y))

    if(length(missing_languages) != 0){
        add_col<- function(df, col_name){
          mutate(df, !!sym(col_name) := NA_character_)
        }


        dim_names_df_all_languages <- map(dim_names_df_all_languages, ~reduce(paste0("dim_name_", missing_languages), add_col, .init = .x))
        value_names_df_all_languages <- map(value_names_df_all_languages, ~reduce(paste0("value_name_", missing_languages), add_col, .init = .x))
    }

  }


  clean_dimension_names <- function(x){

    x <- x %>%
      dplyr::mutate_all(~gsub("\\s+", " ", str_trim(gsub("\\.", " ", .))))

    return(x)

  }

  dim_names_df_all_languages <- lapply(dim_names_df_all_languages, function(x) clean_dimension_names(x))

  # add a join column to the dimension names as well as to the values
  dim_values_df <- purrr::map2(value_names_df_all_languages, dim_new_names, ~ mutate(.x, join_column = .y))
  dim_names_df <- purrr::map2(dim_names_df_all_languages, dim_new_names, ~ mutate(.x, join_column = .y))




  # join all information together into one table
  dim_table <- purrr::pmap(list(dim_values_df, dim_names_df, needed_codes, unique_names), ~ left_join(..1, ..2, by = "join_column") %>% mutate(value_id = ..3, unique_name = ..4) %>% select(-join_column))

  # write the dimension table into data/dimensions
  walk(dim_table, ~create_new_dimension_file(. , allow_na_cols = T, overwrite = overwrite))

}
