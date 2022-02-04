# V3.1.0 - 21.12.2021 - totals set to -1 instead of 0
# History
# V3.0.2c - 20.12.2021 - change to V3

# Comment on unique_name: It looks similar than dim_name_en but is meant to be for variable name
# while dim_name_en is human-readable name

create_dimensions<-function(){
  # Geschlecht nach eCH-0011 V8.1 und eCH-0044 V4.1
  # Abweichung vom eCH: 0 als Total
  # 3 wäre unebstimmt laut eCH

  out_dir <- "data/dimensions"

  dir.create(out_dir, showWarnings = F)

  statbot_dim_geschlecht<-data.frame(  dim_id=1,
                                       unique_name="gender",
                                       dim_name_de="Geschlecht",
                                       dim_name_fr="Geschlecht",
                                       dim_name_it="Geschlecht",
                                       dim_name_en="Gender",
                                       value_id=c(1,2,-1),
                                       value_name_de=c("Männer","Frauen","Total"),
                                       value_name_fr=c("Männer","Frauen","Total"),
                                       value_name_it=c("Männer","Frauen","Total"),
                                       value_name_en=c("Male","Female","Total")
  )
  write.csv(statbot_dim_geschlecht,paste0(out_dir, "/dimension_gender.csv"),row.names = F)

  # Herkunft wie intern verwendet. Keine eCH gefunden

  statbot_dim_herkunft<-data.frame(  dim_id=2,
                                     unique_name="origin",
                                     dim_name_de="Herkunft",
                                     dim_name_fr="Herkunft",
                                     dim_name_it="Herkunft",
                                     dim_name_en="Origin",
                                     value_id=c(1,2,-1),
                                     value_name_de=c("Schweiz","Ausland","Total"),
                                     value_name_fr=c("Schweiz","Ausland","Total"),
                                     value_name_it=c("Schweiz","Ausland","Total"),
                                     value_name_en=c("Switzerland","Abroad","Total")
  )
  write.csv(statbot_dim_herkunft,paste0(out_dir, "/dimension_origin.csv"),row.names = F)

  # Alter nach BFS Bevölkerungsschema
  # keine eCH gefunden

  statbot_dim_alter<-data.frame(  dim_id=3,
                                  unique_name="age",
                                  dim_name_de="Alter",
                                  dim_name_fr="Alter",
                                  dim_name_it="Alter",
                                  dim_name_en="Age",
                                  value_id=seq(-1,100),
                                  value_name_de=c("Alter Total",paste0(seq(0,99),"-jährig"),"100 Jahre und mehr"),
                                  value_name_fr=c("Alter Total",paste0(seq(0,99),"-jährig"),"100 Jahre und mehr"),
                                  value_name_it=c("Alter Total",paste0(seq(0,99),"-jährig"),"100 Jahre und mehr"),
                                  value_name_en=c("Age Total",paste0(seq(0,99),"-years old"),"100 Years and more")
  )
  write.csv(statbot_dim_alter,paste0(out_dir, "/dimension_age.csv"),row.names = F)

  statbot_dim_altersklasse_mutter<-data.frame(  dim_id=4,
                                                unique_name="age_classes_of_mother",
                                                dim_name_de="Altersklasse der Mutter",
                                                dim_name_fr="Altersklasse der Mutter",
                                                dim_name_it="Altersklasse der Mutter",
                                                dim_name_en="Age classes of mother",
                                                value_id=c(-1,seq(1,5)),
                                                value_name_de=c("Total","Unter 25 Jahren","25-29 Jahre","30-34 Jahre","35-39 Jahre","40 Jahre und mehr"),
                                                value_name_fr=c("Total","Unter 25 Jahren","25-29 Jahre","30-34 Jahre","35-39 Jahre","40 Jahre und mehr"),
                                                value_name_it=c("Total","Unter 25 Jahren","25-29 Jahre","30-34 Jahre","35-39 Jahre","40 Jahre und mehr"),
                                                value_name_en=c("Total","Unter 25 Jahren","25-29 Jahre","30-34 Jahre","35-39 Jahre","40 Jahre und mehr")
  )
  write.csv(statbot_dim_altersklasse_mutter,paste0(out_dir, "/dimension_age_mother.csv"),row.names = F)

  statbot_dim_wirtschaftssektor<-data.frame(  dim_id=5,
                                              unique_name="economic_sector",
                                              dim_name_de="Wirtschaftssektor",
                                              dim_name_fr="Wirtschaftssektor",
                                              dim_name_it="Wirtschaftssektor",
                                              dim_name_en="Economic Sector",
                                              value_id=c(-1,seq(1,3)),
                                              value_name_de=c("Total","Primärsektor","Sekundärer Sektor","Tertiärer Sektor"),
                                              value_name_fr=c("Total","Primärsektor","Sekundärer Sektor","Tertiärer Sektor"),
                                              value_name_it=c("Total","Primärsektor","Sekundärer Sektor","Tertiärer Sektor"),
                                              value_name_en=c("Total","Primary Sector","Secondary Sector","Tertiary Sector")
  )
  write.csv(statbot_dim_wirtschaftssektor,paste0(out_dir, "/dimension_economy_sectors.csv"),row.names = F)

  statbot_dim_rooms<-data.frame(  dim_id=6,
                                              unique_name="rooms",
                                              dim_name_de="Zimmer",
                                              dim_name_fr="Zimmer",
                                              dim_name_it="Zimmer",
                                              dim_name_en="Rooms",
                                              value_id=c(-1,seq(1,6)),
                                              value_name_de=c("Total","1 Zimmer","2 Zimmer","3 Zimmer","4 Zimmer","5 Zimmer","6+ Zimmer"),
                                              value_name_fr=c("Total","1 Zimmer","2 Zimmer","3 Zimmer","4 Zimmer","5 Zimmer","6+ Zimmer"),
                                              value_name_it=c("Total","1 Zimmer","2 Zimmer","3 Zimmer","4 Zimmer","5 Zimmer","6+ Zimmer"),
                                              value_name_en=c("Total","1 room","2 rooms","3 rooms","4 rooms","5 rooms","6+ rooms")
  )
  write.csv(statbot_dim_rooms,paste0(out_dir, "/dimension_rooms.csv"),row.names = F)

  statbot_dim_construction_period<-data.frame(  dim_id=7,
                                  unique_name="construction_period",
                                  dim_name_de="Bauperiode",
                                  dim_name_fr="Bauperiode",
                                  dim_name_it="Bauperiode",
                                  dim_name_en="Construction period",
                                  value_id=c(-1,seq(1,9)),
                                  value_name_de=c("Total","Vor 1919","1919-1945","1946-1960","1961-1970",
                                                  "1971-1980","1981-1990","1991-2000","2001-2005","2006-2020"),
                                  value_name_fr=c("Total","Vor 1919","1919-1945","1946-1960","1961-1970",
                                                  "1971-1980","1981-1990","1991-2000","2001-2005","2006-2020"),
                                  value_name_it=c("Total","Vor 1919","1919-1945","1946-1960","1961-1970",
                                                  "1971-1980","1981-1990","1991-2000","2001-2005","2006-2020"),
                                  value_name_en=c("Total","Vor 1919","1919-1945","1946-1960","1961-1970",
                                                  "1971-1980","1981-1990","1991-2000","2001-2005","2006-2020")
  )
  write.csv(statbot_dim_construction_period,paste0(out_dir, "/dimension_construction_period.csv"),row.names = F)

  # 8 is Staatsangehörigkeit Kategorie des Ehemannes
  # 9 is Staatsangehörigkeit Kategorie der Ehefrau
  # 10 Ehedauer
  # 11 Staatsangehörigkeit Kategorie
  # 12 Zivilstand
  # 13 Altersklasse


  # merge all the variables starting with statbot_dim_ together
  # out<-NULL
  # for(i in ls(pat="statbot_dim_")){
  #   out<-rbind(out,eval(as.name(i)))
  # }
  #
  # # output
  # write.csv(out,"data/dimensions.csv",row.names = F)
}

#' Function that returns a full dimension table
#'
#' @export
create_full_dimension_table <- function(){
  # list of all existing dim files
  dimension_files <- list.files("data/dimensions", full.names = T)

  # read in all dimension files
  if(length(dimension_files)!=0){
    file_list <- purrr::map_df(dimension_files, read.csv)

    # check if a dimension name is duplicated
    if(any(duplicated(unique(file_list$unique_name)))){
      warning("There are duplicated dimension names")
    }
    # return the full dimension table
    return(file_list)
  }else{
    return(NULL)
  }



}

#' Function that checks and creats a dimension file
#'
#' @param data dimension data
#'
#' @param overwrite Whether an existing dimension file should be overwritten or not, default = F
#'
#' @param allow_na_cols Whether na-cols are allowed or not (certain columns must have values anyways), default = F
#'
#' @export
create_new_dimension_file <- function(data, overwrite = F, allow_na_cols = F){

  # names of the columns containing NA
  na_cols <- names(data[apply(data, 2, function(x) any(is.na(x)))])
  # clumns that must have a value
  must_have_value_cols <- c("unique_name", "dim_name_de", "value_id", "value_name_de")

  # stop if must-have-value-columns have NA values
  # if non-must-have-value-columns have NA, it is stopped as well,unless the param: allow_na_cols is set to TRUE
  if(any(must_have_value_cols %in% na_cols)){
    stop(paste0("One of the must have value columns: ", paste0(must_have_value_cols, collapse = ", "), ", contain NA-values. Make sure that all these columns have values."))
  }else if(!allow_na_cols){
    if(length(na_cols) != 0){
      stop(paste0("The columns: ", paste0(na_cols, collapse = ", "), ", contain NA-values, set allow_na_cols = T to write the file anyways."))
    }
  }

  # extract the dimension name
  dimension_name <- unique(data$unique_name)

  # create output file path
  new_dimension_file_path <- paste0("data/dimensions/dimension_", dimension_name, ".csv")

  # check if file already exists. if yes, and the overwrite = F, the function is stopped.
  # if the file exists and the overwrite is set to TRUE, the existing file is overwritten
  if(file.exists(new_dimension_file_path)){
    if(!overwrite){
      stop(paste0("This dimension file: ", basename(new_dimension_file_path),", already exists"))
    }
  }

  # check if all the columns are present
  data_col_names <- names(data)


  dimension_col_names <- dimension_table_col_names()

  only_in_data <- setdiff(data_col_names, dimension_col_names)
  only_in_dimension <- setdiff(dimension_col_names, data_col_names)

  if(length(only_in_data) != 0){
    stop(paste0("The data contains columns that are not needed for the dimension table: ", paste0(only_in_data, collapse = ", ")))
  }
  if(length(only_in_dimension) != 0){
    stop(paste0("The data does not columns that should be in the dimension table: ", paste0(only_in_dimension, collapse = ", ")))
  }

  # Get the dim_id
  # If a file should be overwritten, the dim_id of the existing file is taken
  # If it is a new dimension, the max(dim_id) + 1 is taken as new dim_id

  if(overwrite){
    new_dim_id <- read.csv(new_dimension_file_path) %>%
      pull(dim_id) %>%
      unique()
  }else{
    full_dimension_table <- create_full_dimension_table()

    if(is.null(full_dimension_table)){
      max_dim_id <- 0
    }else{
      max_dim_id <- full_dimension_table %>%
        filter(dim_id == max(dim_id)) %>%
        pull(dim_id) %>%
        unique()
    }


    new_dim_id <- max_dim_id + 1
  }

  # add the new dim_id
  data <- data %>%
    mutate(dim_id = new_dim_id) %>%
    select(
      dim_id,
      !!!syms(dimension_col_names)
    )

  # write the file
  write.csv(data, new_dimension_file_path, row.names = F)

}

#' Function to list all existing dimensions
#'
#' @export
get_existing_dimensions <- function(){
  dimension_table <- create_full_dimension_table()

  dimension_table %>%
    distinct(dim_id, unique_name)
}

#' Function to check if a dimension already exists
#'
#' @param unique_dimension_name Dimension name to test for existance
#'
#' @export
does_dimension_exist <- function(uniqe_dimension_name){
  dimension_table <- create_full_dimension_table()

  dimension_names <- unique(dimension_table$unique_name)

  if(unique_dimension_name %in% dimension_names){
    print("TRUE")
  }else{
    print("FALSE")
  }
}



#' function containing all the columns in the right order
#'
#' @export
dimension_table_col_names <- function(){
  c("unique_name","dim_name_de",
    "dim_name_fr","dim_name_it","dim_name_en",
    "value_id","value_name_de","value_name_fr",
    "value_name_it","value_name_en")
}

