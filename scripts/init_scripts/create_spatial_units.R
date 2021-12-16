# V3.0.2 - 15.12.2021 - 16.12.2021 - Adaptation to V3-scheme
# CAREFUL - WORK IN PROGRESS!

library(dplyr)


create_spatial_units<-function(){


  destfile<-"temp/hist_gemeinde_verzeichnis.zip"
  download.file("https://www.bfs.admin.ch/bfsstatic/dam/assets/17884689/master",destfile=destfile)
  utils::unzip(destfile,exdir="temp/")

  files<-list.files("temp/01.1/")
  gemeinde_file<-paste0("temp/01.1/",files[grep("GDE.txt",files)][1])
  bezirks_file<-paste0("temp/01.1/",files[grep("BEZ.txt",files)][1])
  kantons_file<-paste0("temp/01.1/",files[grep("KT.txt",files)][1])

  if(check_changes_in_input_file(gemeinde_file)|
     check_changes_in_input_file(bezirks_file)|
     check_changes_in_input_file(kantons_file)|
     flag_force_update){

    options(scipen=500)

    # a format encoding is necessary due to input files

    system(paste0('iconv -f "iso-8859-1" -t "UTF-8" ',gemeinde_file,' > ',gemeinde_file,'_encoded'))
    system(paste0('iconv -f "iso-8859-1" -t "UTF-8" ',bezirks_file,' > ',bezirks_file,'_encoded'))
    system(paste0('iconv -f "iso-8859-1" -t "UTF-8" ',kantons_file,' > ',kantons_file,'_encoded'))


    kt<-data.table::fread(paste0(kantons_file,"_encoded"),encoding = "UTF-8")
    kt<-kt[,c(1,2)]

    gde<-data.table::fread(paste0(gemeinde_file,"_encoded"),encoding = "UTF-8",
                          col.names = c("historyMunicipalityId",
                                        "districtHistId","cantonAbbreviation","municipalityId","municipalityLongName","municipalityShortName",
                                        "municipalityEntryMode","municipalityStatus","municipalityAdmissionNumber","municipalityAdmissionMode",
                                        "municipalityAdmissionDate","municipalityAbolitionNumber","municipalityAbolitionMode",
                                        "municipalityAbolitionDate","municipalityDateOfChange"))



    gde$spatialunit_ontology<-"A.ADM3"
    gde<-gde %>% rename(spatialunit_hist_id=historyMunicipalityId,
                        spatialunit_current_id=municipalityId,spatialunit_name_de=municipalityLongName,
                        valid_from=municipalityAdmissionDate,valid_until=municipalityAbolitionDate,
                        district_hist_id=districtHistId
                        )

    # canton_hist_id mapping to numbers

    gde<-merge(gde,kt,by.x="cantonAbbreviation",by.y="V2")
    colnames(gde)[colnames(gde)=="V1"]<-"canton_hist_id"

    # 16.12.2021: for the moment all the languages are the same on communal level
    gde$spatialunit_name_fr<-gde$spatialunit_name_de
    gde$spatialunit_name_it<-gde$spatialunit_name_de
    gde$spatialunit_name_en<-gde$spatialunit_name_de

    # prepare for final df

    gde<-gde[,c("spatialunit_ontology","spatialunit_hist_id","spatialunit_current_id","spatialunit_name_de",
               "spatialunit_name_fr","spatialunit_name_it","spatialunit_name_en",
    "valid_from","valid_until","canton_hist_id","district_hist_id")]


    # we need to divide some of the communes linguistically
    # this duplicates the ids so we have to be careful later
    # update 16.12.2021: This is for the moment deactivated
    # See also discussion on slack
    #df<-df %>% mutate(name = strsplit(name, "/")) %>%
    #  unnest(name)





    bez<-data.table::fread(paste0(bezirks_file,"_encoded"),encoding = "UTF-8",
                           col.names = c("districtHistId",
                                         "cantonId","districtId","districtLongName","districtShortName","districtEntryMode",
                                         "districtAdmissionNumber","districtAdmissionMode","districtAdmissionDate","districtAbolitionNumber",
                                         "districtAbolitionMode","districtAbolitionDate","districtDateOfChange"))




    # only select districts that are no cantons
    bez<-bez[bez$districtEntryMode!=16,]

    bez$spatialunit_ontology<-"A.ADM2"

    bez<-bez %>% rename(spatialunit_hist_id=districtHistId,
                        spatialunit_current_id=districtId,spatialunit_name_de=districtLongName,
                        valid_from=districtAdmissionDate,valid_until=districtAbolitionDate,
                        canton_hist_id=cantonId
    )

    # on district-level those are just the same - no actual functional use behind that
    bez$district_hist_id<-bez$spatialunit_hist_id

    # 16.12.2021: for the moment all the languages are the same on communal level
    bez$spatialunit_name_fr<-bez$spatialunit_name_de
    bez$spatialunit_name_it<-bez$spatialunit_name_de
    bez$spatialunit_name_en<-bez$spatialunit_name_de


    # Reorder and prepare for merging to df

    bez<-bez[,c("spatialunit_ontology","spatialunit_hist_id","spatialunit_current_id","spatialunit_name_de",
                "spatialunit_name_fr","spatialunit_name_it","spatialunit_name_en",
               "valid_from","valid_until","canton_hist_id","district_hist_id")]



    kt<-data.frame(spatialunit_ontology="A.ADM1",
      spatialunit_hist_id=seq(01,26),spatialunit_current_id=seq(01,26),
      spatialunit_name_de=c("Kanton Zürich","Kanton Bern","Kanton Luzern","Kanton Uri","Kanton Schwyz","Kanton Obwalden","Kanton Nidwalden","Kanton Glarus","Kanton Zug","Kanton Freiburg","Kanton Solothurn","Kanton Basel-Stadt","Kanton Basel-Landschaft","Kanton Schaffhausen","Kanton Appenzell Ausserrhoden","Kanton Appenzell Innerrhoden","Kanton St. Gallen","Kanton Graubünden","Kanton Aargau","Kanton Thurgau","Kanton Tessin","Kanton Waadt","Kanton Wallis","Kanton Neuenburg","Kanton Genf","Kanton Jura"),
      spatialunit_name_fr=c("Canton de Zurich","Canton de Berne","Canton de Lucerne","Canton d'Uri","Canton de Schwyz","Canton d'Obwald","Canton de Nidwald","Canton de Glaris","Canton de Zug","Canton de Fribourg","Canton de Soleure","Canton de Bâle-Ville","Canton de Bâle-Campagne","Canton de Schaffhouse","Canton d'Appenzell Rhodes-Extérieures","Canton d'Appenzell Rhodes-Intérieures","Canton de St. Gallen","Canton des Grisons","Canton d'Argovie","Canton de Thurgovie","Canton du Tessin","Canton de Vaud","Canton du Valais","Canton de Neuchâtel","Canton de Genève","Canton du Jura"),
      spatialunit_name_it=c("Cantone di Zurigo","Cantone di Berna","Cantone di Lucerna","Cantone di Uri","Cantone di Svitto","Cantone di Obvaldo","Cantone di Nidvaldo","Cantone di Glarona","Cantone di Zugo","Cantone di Friburgo","Cantone di Soletta","Cantone di Basilea Città","Cantone di Basilea Campagna","Cantone di Sciaffusa","Cantone di Appenzello Esterno","Cantone di Appenzello Interno","Cantone di St. Gallen","Canton Grigioni","Canton Argovia","Canton Turgovia","Canton Ticino","Canton Vaud","Canton Vallese","Canton Neuchâtel","Canton Ginevra","Canton Giura"),
      spatialunit_name_en=c("Canton of Zurich","Canton of Bern","Canton of Lucerne","Canton of Uri","Canton of Schwyz","Canton of Obwalden","Canton of Nidwalden","Canton of Glarus","Canton of Zug","Canton of Fribourg","Canton of Solothurn","Canton of Basel-Stadt","Canton of Basel-Landschaft","Canton of Schaffhausen","Canton of Appenzell Ausserrhoden","Canton of Appenzell Innerrhoden","Canton of St. Gallen","Canton Graubünden","Canton Aargau","Canton Thurgau","Canton Ticino","Canton Vaud","Canton Valais","Canton Neuchâtel","Canton Geneva","Canton Jura"),
      valid_from=c(1848,1979,rep(1848,23),1979),# Bern and Jura... of course there can be improvements in the data for that...
      valid_until=NA,
      canton_hist_id=seq(01,26),
      district_hist_id=NA
    )

    # let us also add Switzerland
    ch<-data.frame(spatialunit_ontology="CH",
                   spatialunit_hist_id=0,spatialunit_current_id=0,
                   spatialunit_name_de="Schweiz",spatialunit_name_fr="Suisse",
                   spatialunit_name_it="Svizzera",spatialunit_name_en="Switzerland",
                   valid_from=1848,valid_until=NA,
                   canton_hist_id=NA,district_hist_id=NA)


    # this is the final data for CH
    df_new<-rbind(gde,bez,kt,ch)

    ### ZH-Regions and BS-Wohnviertel
    # 15.10.2021 and 16.12.2021: Temporary workaround: Take the remaining values of zh-regions and bs-wohnviertel

    df<-read.csv("data/old_spatialunits.csv")

    #selection of columns
    df<-df[,1:3]


    # select ZH-regions (4) and BS-Wohnviertel (10)
    df<-df[df$TYPE_ID %in% c(4,10),]


    # create spatialunit_ontology of type_ids
    df$spatialunit_ontology<-ifelse(df$TYPE_ID==4,"A.ADM2H","")
    df$spatialunit_ontology<-ifelse(df$TYPE_ID==10,"A.ADM4",df$spatialunit_ontology)

    # attribute other variables
    df$spatialunit_hist_id<-df$SPATIALUNIT_ID
    df$spatialunit_current_id<-df$SPATIALUNIT_ID
    df$spatialunit_name_de<-df$NAME
    df$spatialunit_name_fr<-df$NAME
    df$spatialunit_name_it<-df$NAME
    df$spatialunit_name_en<-df$NAME
    df$valid_from<-1948 # can be improved of course
    df$valid_until<-NA # can be improved of course

    # for the following it is of course only between ZH/01 (if regions) and BS/12 (if wohnviertel)
    df$canton_hist_id<-ifelse(df$TYPE_ID==4,1,12)

    df$district_hist_id<-NA

    df<-df[,c("spatialunit_ontology","spatialunit_hist_id","spatialunit_current_id","spatialunit_name_de",
                "spatialunit_name_fr","spatialunit_name_it","spatialunit_name_en",
                "valid_from","valid_until","canton_hist_id","district_hist_id")]


    df<-rbind(df_new,df)



    #saving to the new spatialunits.csv
    write.csv(df,"data/spatialunits.csv",row.names = F)


  }


}
