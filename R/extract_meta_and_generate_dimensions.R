#' Function to extract metadata and generate dimensions
#'
#' This function extracts metadata from a px-file and populates the dimensions-file
#'
#' @param input_df a px-object before conversion into a proper df
#' @param label German label for the variable with first letter capital e.g. "Wirtschaftssektor"
#' @param dim_id the unique id in the dimensions table
#' @param ... dim_name_xx or value_name_xx with corresponding languages. Careful when giving in Labels
#' they have to be as they would appear with appropriate capital letters e.g. "Economic Sector". The English
#' one is particular and will be then be automatically converted to e.g. "economic_sector"
#' @export
extract_meta_and_generate_dimensions<-function(input_df,label,dim_id,...){
  # TO THINK ABOUT:
  # - actually the dim_id could be attributed automatically?

  # get the ellipsis arguments and their names
  arguments <- list(...)
  arg_names<-attr(arguments,which = "names")

  # just outputing available languages as info
  languages<-c()
  if(!is.null(df$VALUES)) languages<-c(languages,"de")
  if(!is.null(df$VALUES.fr.)) languages<-c(languages,"fr")
  if(!is.null(df$VALUES.it.)) languages<-c(languages,"it")
  if(!is.null(df$VALUES.en.)) languages<-c(languages,"en")
  print(paste0("Languages found in meta: ",toString(languages)))

  # checking languages given in
  found<-c()
  if(any(endsWith(arg_names, '_de'))) found<-c(found,"de")
  if(any(endsWith(arg_names, '_fr'))) found<-c(found,"fr")
  if(any(endsWith(arg_names, '_it'))) found<-c(found,"it")
  if(any(endsWith(arg_names, '_en'))) found<-c(found,"en")
  print(paste0("Languages found in function input: ",toString(found)))

  # Providing error if something not OK
  total_languages<-c("de","fr","it","en")
  merge_langauges<-c(languages,found)
  if(length(merge_langauges)>length(total_languages)) warning("Language(s) inserted unnecessary")
  if(length(merge_langauges)<length(total_languages)) stop("Language(s) missing")


  #the position is necessary because the variables of the values are already coded in different languages
  position<-which(attr(df$CODES,which = "names")==label)

  #lets assume the codes as we want. Only 999 is our -1 for the totals
  codes<-df$CODES[[position]]
  value_id<-ifelse(codes=="999","-1",codes)

  #some of the px-meta is damaged. Cleaning seems to help to bring back clean char vectors
  cleaning<-function(input){
    input<-unlist(strsplit(input,'\"'))
    input<-input[input!=","]
    input<-input[input!=", "]
  }

  #
  values<-df$VALUES[[position]]
  value_name_de<-cleaning(gsub(".*Total","Total",values,ignore.case = T))
  if("value_name_fr" %in% arg_names){
    value_name_fr=arguments[['value_name_fr']]
    }else{
    values<-df$VALUES.fr.[[position]]
    value_name_fr<-cleaning(gsub(".*Total","Total",values,ignore.case = T))
    }
  if("value_name_it" %in% arg_names){
    value_name_it=arguments[['value_name_it']]
  }else{
    values<-df$VALUES.it.[[position]]
    value_name_it<-cleaning(gsub(".*Totale","Totale",values,ignore.case = T))
  }
  if("value_name_en" %in% arg_names){
    value_name_en=arguments[['value_name_en']]
  }else{
    values<-df$VALUES.en.[[position]]
    value_name_en<-cleaning(gsub(".*Total","Total",values,ignore.case = T))
  }

  dim_name_de<-label # must be equal to label
  if("dim_name_fr" %in% arg_names){
    dim_name_fr=arguments[['dim_name_fr']]
  }else{
    dim_name_fr<-str_replace_all(names(df$VALUES.fr.)[position],"[.]"," ")
  }
  if("dim_name_it" %in% arg_names){
    dim_name_it=arguments[['dim_name_it']]
  }else{
    dim_name_it<-str_replace_all(names(df$VALUES.it.)[position],"[.]"," ")
  }
  if("dim_name_en" %in% arg_names){
    dim_name_en=arguments[['dim_name_en']]
  }else{
    dim_name_en<-str_replace_all(names(df$VALUES.en.)[position],"[.]"," ")
  }

  unique_name<-tolower(unique_name)%>% janitor::make_clean_names() #lower and underscores

  output_df<-data.frame(  dim_id=dim_id,
                                              unique_name=unique_name,
                                              dim_name_de=dim_name_de,
                                              dim_name_fr=dim_name_fr,
                                              dim_name_it=dim_name_it,
                                              dim_name_en=dim_name_en,
                                              value_id=value_id,
                                              value_name_de=value_name_de,
                                              value_name_fr=value_name_fr,
                                              value_name_it=value_name_it,
                                              value_name_en=value_name_en)
  print(output_df)
  # TODO: Get dimensions CSV, glue it to the dimensions if not existing yet. What if conflicts?
}
