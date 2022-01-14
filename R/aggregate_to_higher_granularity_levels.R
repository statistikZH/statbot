create_all_aggregations_per_indicator <- function(df, indicator_col, indicator_name, indicator_number){
  df_indicator <- df %>%
    filter(!!sym(indicator_col)== indicator_name) %>%
    select(-!!sym(indicator_col))

  total_vars <- setdiff(names(df_indicator), GLOBAL_TOTAL_LIST)

  df_all_granularity_levels <- add_granularity_levels_up(df_indicator,list_ontologies=c("A.ADM2","A.ADM1","CH"),list_dimensions=total_vars)

  df_indicator_with_totals <- add_totals(df_all_granularity_levels, total_vars)

  write.csv(df_indicator_with_totals,paste0("data/values/1_07_",str_pad(indicator_number,3,pad="0"),"_CH.csv"),row.names = F)
  update_last_updated(paste0("1_07_",str_pad(indicator_number,3,pad="0")))


}







add_totals <- function(df, total_vars){

  total_vars_list <- c(total_vars, list(total_vars))
  grouping_vars_list <- lapply(total_vars, function(x) setdiff(total_vars, x))

  list_element <- length(total_vars_list)

  grouping_vars_list[list_element] <- list(NULL)

  df <- df %>% select(GLOBAL_TOTAL_LIST, !!!syms(total_vars))

  totals <- map2_df(grouping_vars_list, total_vars_list, ~aggregate_for_totals(df,..1,..2))

  df_total <- bind_rows(df, totals)

}


aggregate_for_totals <- function(df, grouping_var, total_vars){

  select_vars <- c(grouping_var, total_vars)

  all_grouping_vars <- c(head(GLOBAL_TOTAL_LIST, -1), grouping_var)

  total_df<-df %>%
    group_by(!!!syms(all_grouping_vars)) %>%
    summarize(value=sum(value),across(c(!!!syms(total_vars)), ~-1)) %>%
    ungroup() %>%
    select(GLOBAL_TOTAL_LIST, !!!syms(select_vars))

}
