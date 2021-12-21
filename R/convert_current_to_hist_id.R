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

  # filter in spatial_unit_table all that would be valid to that parameter
  # remark added on 21.12.21 by TK: solution by data.table might be more elegant and faster see:
  # https://stackoverflow.com/questions/37289405/dplyr-left-join-by-less-than-greater-than-condition
  spatial_unit_table$valid_from<-as.Date(spatial_unit_table$valid_from)
  spatial_unit_table$valid_until<-as.Date(spatial_unit_table$valid_until)
  reference_point<-as.Date(reference_point,format="%d.%m.%Y")
  spatial_unit_table<-spatial_unit_table[spatial_unit_table$valid_from<=reference_point&
                       spatial_unit_table$valid_until>=reference_point,]

  # now that the time-relevant are filtered, we can join among the two main variables

  df_temp<- df %>%  left_join(spatial_unit_table,by=c("spatialunit_ontology","spatialunit_current_id"))
  df_temp<-merge(df,spatial_unit_table,by=c("spatialunit_ontology","spatialunit_current_id"),all.x=T,sort=F)

  return(df_temp$spatialunit_hist_id)
}
