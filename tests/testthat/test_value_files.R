# 13.08.2022



# test_that("Values: Checking columns", {
#   print(get_dataset_ids())
#
#   test_value_columns<-function(dataset_id){
#     file_path<-paste0("data/values/",dataset_id,".csv")
#     out_file_exists<-file.exists(file_path)
#     if(!out_file_exists) return(list(out_file_exists=out_file_exists))
#     tdf<-data.table::fread(file_path,nrows=100)
#     names_tdf<-names(tdf)
#     out_col_match<-all(names_tdf[1:6] == GLOBAL_TOTAL_LIST)
#     out_length_match<-all(length(names_tdf[1:6])==length(GLOBAL_TOTAL_LIST))
#
#     return(list(out_file_exists=out_file_exists,out_col_match=out_col_match,out_length_match=out_length_match))
#
#     # TODO: check whether the remaining dimensions fit with the "classes.csv" or equivalent solution
#   }
#
#   dataset_ids_to_download <- get_dataset_ids()
#
#
#   for(dataset_id in  "bla")
#   expect_true(1==2)
#
#   expect_length(get_dataset_ids(),5)
#
#   for(i in 1:5) expect_true(1==1)
#
#
#
#
#
# })


#check whether values are not NA in dimensions else something went wrong

library(validate)

test_that("NAs: ",{
  file_path<-paste0("data/values/","1_01_009_CH",".csv")
  tdf<-data.table::fread(file_path,nrows=100)
  names_tdf<-names(tdf)
  if(length(names_tdf>6)){

  }

  #or is_complete
  rules<-validator(!any(is.na(marital_status_wife)))
  out<-confront(tdf,rules)
  summary(out)
  expect_true()

})


#check whether the groupings are correct - is one grouping missing?
# careful then for the exceptions where historic data is available but without grouping.
# I don't think it would be contains_at_least

#maybe we can check whether -1 is larger than the other groups, therewith representing the total
#(at least of counts)

#hierarchy(dat$volume, dat$nace, nace_rev2[3:4])
# hierarchy(value, region, hierarchy=ref$codelist, by=list(period, measure))
#  part_whole_relation


#checken on Luecken bestehen
# is_linear_sequence(c("2020Q4","2020Q2","2020Q3","2020Q1"))

