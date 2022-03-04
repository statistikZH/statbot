#' Function do download the dataset with the id: 1_01_001_BS
#'
#' Created by: Hester Pieters
#' Created at: 2022-02-28
#'
#' @param flag_force_update To force an update of the Dataset. Default: FALSE
#'
#' @export
statbot_src_1_01_001_BS <- function(flag_force_update=FALSE){
  destfile<-"temp/1_01_001_BS.csv"
  # change to download only columns we need, what is the best way to download whole file at once?
  download.file("https://data.bs.ch/explore/dataset/100128/download/?format=csv&disjunctive.wohnviertel_id=true&refine.jahr=2020&refine.person_alter=20&timezone=Europe/Berlin&lang=en&use_labels_for_header=true&csv_separator=%3B",destfile=destfile)

  if(check_changes_in_input_file(destfile)|flag_force_update){
    if(flag_force_update) print("flag_force_update") else print("Changes found")
    df <- read.csv(destfile, sep=";")

    # add spatialunit columns
    spatial_unit_table<-read.csv("data/spatialunits.csv")[,c(
      "spatialunit_ontology","spatialunit_hist_id","spatialunit_name_de")]

    df<-merge(df,spatial_unit_table,by.x="Wohnviertel",by.y="spatialunit_name_de",all.x=T,sort=F)

    write.csv(df,"temp/test3.csv", row.names = FALSE)

    # dimensions: dimension_citizenship_category.csv, dimension_age_group_1.csv, dimension_gender.csv
    # note: in 1_01_001_CH also "citizenship_category = Total" and "gender=Total" are listed, do we harmonize?
    # examples of the dimensions we need:
    #"dim_id","unique_name","dim_name_de","dim_name_fr","dim_name_it","dim_name_en","value_id","value_name_de","value_name_fr","value_name_it","value_name_en"
    #38,"age_group_1","Alter","Age","Età","Age","-1","Alter - Total","Age - total","Età - totale","Age - total"
    #38,"age_group_1","Alter","Age","Età","Age","0","0 Jahre","0 an","0 anni","0 years"
    #"dim_id","unique_name","dim_name_de","dim_name_fr","dim_name_it","dim_name_en","value_id","value_name_de","value_name_fr","value_name_it","value_name_en"
    #36,"citizenship_category","Staatsangehörigkeit Kategorie","Nationalité catégorie","Nazionalità categoria","Citizenship category","-1","Staatsangehörigkeit (Kategorie) - Total","Nationalité (catégorie) - total","Nazionalità (categoria) - totale","Citizenship (category) - total"
    #36,"citizenship_category","Staatsangehörigkeit Kategorie","Nationalité catégorie","Nazionalità categoria","Citizenship category","1","Schweiz","Suisse","Svizzera","Switzerland"
    #36,"citizenship_category","Staatsangehörigkeit Kategorie","Nationalité catégorie","Nazionalità categoria","Citizenship category","2","Ausland","Etranger","Straniera","Foreign country"
    #"dim_id","unique_name","dim_name_de","dim_name_fr","dim_name_it","dim_name_en","value_id","value_name_de","value_name_fr","value_name_it","value_name_en"
    #37,"gender","Geschlecht","Sexe","Sesso","Sex","-1","Geschlecht - Total","Sexe - total","Sesso - totale","Sex - total"
    #37,"gender","Geschlecht","Sexe","Sesso","Sex","1","Mann","Homme","Uomo","Male"
    #37,"gender","Geschlecht","Sexe","Sesso","Sex","2","Frau","Femme","Donna","Female"



    return("UPDATE OK")
   }else{
       return("UP-TO-DATE")
   }
}
