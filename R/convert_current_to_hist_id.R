#' Function to scrape the asset number of a specific bfs number
#'
#' This function converts current_ids in combination with ontologies to hist_ids according to spatial-unit table
#'
#' @param df a data.frame containing on the one hand an ontology vector called spatialunit_ontology,
#' and on the other hand a vector called spatialunit_current_id. The latter could be a vector of e.g. bfs-nr for commune, district or canton or any other defined current-id.
#' @param valid_until a date-value in the format TODO to match the spatialunits version.
#'
#' @export
convert_current_to_hist_id <- function(df,valid_until){
  spatial_unit_table<-read.csv("data/spatialunits.csv")[,c(
    "spatialunit_ontology","spatialunit_hist_id","spatialunit_current_id","valid_until")]
  df$valid_until<-valid_until

  df_temp<-merge(df,spatial_unit_table,by=c("spatialunit_ontology","spatialunit_current_id","valid_until"),all.x=T)

  return(df_temp$spatialunit_hist_id)
}
