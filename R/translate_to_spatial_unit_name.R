#' Function to translate to names of spatial units
#'
#' This function translates hist-ids with ontologies to name of spatial units
#'
#' @param df a data.frame containing on the one hand an ontology vector called spatialunit_ontology,
#' and on the other hand a vector called spatialunit_hist_id. Please mind, that it is not spatialunit_current_id.
#' @param language a character vector specifiying the language (de,fr,it,en)
#'
#' @export
translate_to_spatial_unit_name <- function(df,language){
  if(!(language %in% c("de","fr","it","en"))) stop("not a correct language selected")

  spatial_unit_table<-read.csv("data/spatialunits.csv")[,c(
    "spatialunit_ontology","spatialunit_hist_id",paste0("spatialunit_name_",language))]

  df_temp<-merge(df,spatial_unit_table,by=c("spatialunit_ontology","spatialunit_hist_id"),all.x=T,sort=F)


  return(df_temp[,paste0("spatialunit_name_",language)])
}
