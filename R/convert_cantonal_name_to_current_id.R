#' Function to convert a cantonal name to current id
#'
#' This function converts cantonal names to current_ids. Only for cantons!
#'
#' @param kanton a character vector containing the names of the cantons
#'
#' @param type either "hard" or "easy" with standard "hard". If hard, then it calculates the Levenshtein distanec.
#'  If easy it assumes that the cantons are already correctly ordered
#' @export
convert_cantonal_name_to_current_id <- function(kanton,type="hard"){
  spatial_unit_table<-read.csv("data/spatialunits.csv")[,c(
    "spatialunit_ontology","spatialunit_current_id","spatialunit_name_de")]

  if(type=="easy"){
    levels(kanton)<-1:26
  }else{

      unique_cantons<-unique(kanton)

      # right now it seems that all the cantons are correctly identified, except Vaud which is Waadt
      unique_cantons<-gsub("Vaud", "Waadt",unique_cantons)

      spatial_unit_table<-spatial_unit_table[spatial_unit_table$spatialunit_ontology=="A.ADM1",]
      spatial_unit_table$spatialunit_name_de<-gsub("Kanton ", "", spatial_unit_table$spatialunit_name_de)

      # Levenshtein distance is calculated to find the closest string
      out<-sapply(unique_cantons, function(x){
        spatial_unit_table$spatialunit_current_id[which.min(stringdist::stringdist(spatial_unit_table$spatialunit_name_de, x, method = "lv"))]
      }
      )
      out<-as.numeric(out)
      levels(kanton)<-out
  }

  return(as.numeric(kanton))
}
