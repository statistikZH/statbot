#' Function to scrape the asset number of a specific bfs number
#'
#' This function converts current_ids in combination with ontologies to hist_ids according to spatial-unit table
#'
#' @param df a data.frame containing on the one hand an ontology vector called spatialunit_ontology,
#' and on the other hand a vector called spatialunit_current_id. The latter could be a vector of e.g. bfs-nr for commune, district or canton or any other defined current-id.
#' @param reference_point a character date-value in the format %d.%m.%Y to match the spatialunits version.
#'
#' @export
convert_current_to_hist_id <- function(df,reference_point){
  spatial_unit_table<-read.csv("data/spatialunits.csv")[,c(
    "spatialunit_ontology","spatialunit_hist_id","spatialunit_current_id","valid_from","valid_until")]

  #TODO WORKAROUND 20.12 BEFORE TK PUTS 31.12.2999
  spatial_unit_table$valid_until<- ifelse(is.na(spatial_unit_table$valid_until)||spatial_unit_table$valid_until=="","31.12.2999",spatial_unit_table$valid_until)

  # filter in spatial_unit_table all that would be valid to that parameter
  spatial_unit_table$valid_from<-as.Date(spatial_unit_table$valid_from,format="%d.%m.%Y")
  spatial_unit_table$valid_until<-as.Date(spatial_unit_table$valid_until,format="%d.%m.%Y")
  reference_point<-as.Date(reference_point,format="%d.%m.%Y")
  spatial_unit_table<-spatial_unit_table[spatial_unit_table$valid_from<=reference_point&
                       spatial_unit_table$valid_until>=reference_point,]

  # now that the time-relevant are filtered, we can join among the two main variables

  df_temp<-merge(df,spatial_unit_table,by=c("spatialunit_ontology","spatialunit_current_id"),all.x=T)

  return(df_temp$spatialunit_hist_id)
}
