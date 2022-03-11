# Script to create a dimension table for the dataset:  1_01_026_CH
#
# Created by: J.Steiger
# Created at: 2022-03-09
#
# This script helps to create a dimension table for a px-table.
#
# It already has some functions, that help to explore the dataset in order
# to complete the missing pieces.
#
# The pieces that nead to be figured out are:
#   - what dimensions are present in this dataset?
#   - do some dimensions already exist?
#   - is there a column that might contain a mix of dimensions?
#   - give each dimension a unique dimension name in english (if not yet existing)
#   - are all languages present?
#   - if not, fill in the additional languages
#
# Per default the location as well as the time information is ignored for the dimension
# since we have specific tables for that
#
#
# For adding additional languages, use the language abbreviations: de, fr, it, en
devtools::load_all(".")

destfile<-"temp/1_01_026_CH.px"

if(!file.exists(destfile)){
  download.file(paste0("https://www.bfs.admin.ch/bfsstatic/dam/assets/",get_bfs_asset_nr("px-x-0105090000_102"),"/master"),destfile=destfile)
}

df_px <- statbot_read.px(destfile)

existing_languages <- extract_languages(df_px)

main_language <- extract_main_language(df_px)

dimensions <- extract_value_names(df_px)

existing_dimensions <- get_existing_dimensions()


#clean german names

df_px$VALUES$Wohnsitzstaat <- str_replace(df_px$VALUES$Wohnsitzstaat, regex(">> [0-9][0-9][0-9][0-9] "), "")
df_px$VALUES$Wohnsitzstaat <- str_replace(df_px$VALUES$Wohnsitzstaat, regex("- "), "")
df_px$VALUES$Wohnsitzstaat <- str_replace(df_px$VALUES$Wohnsitzstaat, regex("\\* "), "")

#clean french names

df_px$VALUES.fr.$Pays.de.résidence <- unlist(str_split(df_px$VALUES.fr.$Pays.de.résidence, regex("\",\"|\", \"")))
df_px$VALUES.fr.$Pays.de.résidence <- str_replace(df_px$VALUES.fr.$Pays.de.résidence, regex(">> [0-9][0-9][0-9][0-9] "), "")
df_px$VALUES.fr.$Pays.de.résidence <- str_replace(df_px$VALUES.fr.$Pays.de.résidence, regex("- "), "")
df_px$VALUES.fr.$Pays.de.résidence <- str_replace(df_px$VALUES.fr.$Pays.de.résidence, regex("\\* "), "")




# ignore the missing languages or not
ignore_languages <- T


# example for adding the english names, if you do not want to add additional languages, set
# additional_languages to NA
additional_languages <- NA

#
#
#   list(
#
#   en = list(
#     citizenship_status= c("Swiss - Total","Only Swiss Citizen","Multiple Nationality")
#   ),
#   en = list(
#     age_group_minor_adults_senior= c("Total","0-17 Years","18-64 Years", "65+ Years")
#   ))


# is there a column that contains multiple dimensions?
# if there is one, already think about the dimension names since you have to add them in the
# unique dimension names
fuzzy_column_name <- NA

# add all unique dimension names
unique_dimension_names <- c( "state_of_residence", "citizenship_status","age_group_minor_adults_senior")

# should any dimension be ignored? the reason could be, that it already exists
ignore_dimensions <- c("Jahr", "Geschlecht")


# create the dimension table
extract_meta_and_generate_dimensions(
  input_df = df_px,
  unique_names = unique_dimension_names,
  ignore_language = ignore_languages,
  additional_languages = additional_languages,
  fuzzy_column_name = fuzzy_column_name,
  ignore_dimensions = ignore_dimensions,
  overwrite = F)




