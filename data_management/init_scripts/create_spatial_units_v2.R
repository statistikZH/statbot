

create_spatial_units<-function(){


  destfile<-"temp/hist_gemeinde_verzeichnis.zip"
  download.file("https://www.bfs.admin.ch/bfsstatic/dam/assets/17884689/master",destfile=destfile)
  utils::unzip(destfile,exdir="temp/")

  files<-list.files("temp/01.1/")
  gemeinde_file<-paste0("temp/01.1/",files[grep("GDE.txt",files)])
  bezirks_file<-paste0("temp/01.1/",files[grep("BEZ.txt",files)])
  kantons_file<-paste0("temp/01.1/",files[grep("KT.txt",files)])

  if(check_changes_in_input_file(gemeinde_file)|
     check_changes_in_input_file(bezirks_file)|
     check_changes_in_input_file(kantons_file)|
     flag_force_update){

    options(scipen=500)

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


    gde$type_id<-ifelse(is.na(gde$municipalityAbolitionNumber),1,9)
    gde$type_name<-ifelse(is.na(gde$municipalityAbolitionNumber),"Gemeinde","Gemeinde alt")

    gde<-merge(gde,kt,by.x="cantonAbbreviation",by.y="V2")
    colnames(gde)[colnames(gde)=="V1"]<-"kantons_id"


    df<-gde[,c("municipalityId","municipalityLongName","type_id","type_name","districtHistId","kantons_id")]

    colnames(df)[colnames(df)=="municipalityId"]<-"spatialunit_id"
    colnames(df)[colnames(df)=="municipalityLongName"]<-"name"

    # we need to divide some of the communes linguistically
    # this duplicates the ids so we have to be careful later
    df<-df %>% mutate(name = strsplit(name, "/")) %>%
      unnest(name)





    bez<-data.table::fread(paste0(bezirks_file,"_encoded"),encoding = "UTF-8",
                           col.names = c("districtHistId",
                                         "cantonId","districtId","districtLongName","districtShortName","districtEntryMode",
                                         "districtAdmissionNumber","districtAdmissionMode","districtAdmissionDate","districtAbolitionNumber",
                                         "districtAbolitionMode","districtAbolitionDate","districtDateOfChange"))




    # only select districts that are no cantons
    bez<-bez[bez$districtEntryMode!=16,]
    bez$districtId<-bez$districtId*100
    colnames(bez)[colnames(bez)=="districtId"]<-"district_id"
    colnames(df)[colnames(df)=="districtId"]<-"district_id"


    df<-merge(df,bez[,c("district_id","districtHistId")],by="districtHistId")
    df$districtHistId<-NULL

    bez$type_id<-3
    bez$type_name<-"Bezirk"



    bez<-bez[,c("district_id","districtLongName","type_id","type_name","cantonId")]
    bez$spatialunit_id<-bez$district_id

    colnames(bez)[colnames(bez)=="districtLongName"]<-"name"
    colnames(bez)[colnames(bez)=="cantonId"]<-"kantons_id"

    kt<-data.frame(spatialunit_id=seq(010000,260000,10000),kantons_id=seq(010000,260000,10000),type_id=8,district_id=NA,type_name="Kanton",
                            name=c("Kanton Zürich","Kanton Bern","Kanton Luzern","Kanton Uri","Kanton Schwyz","Kanton Obwalden","Kanton Nidwalden","Kanton Glarus","Kanton Zug","Kanton Freiburg","Kanton Solothurn","Kanton Basel-Stadt","Kanton Basel-Landschaft","Kanton Schaffhausen","Kanton Appenzell Ausserrhoden","Kanton Appenzell Innerrhoden","Kanton St. Gallen","Kanton Graubünden","Kanton Aargau","Kanton Thurgau","Kanton Tessin","Kanton Waadt","Kanton Wallis","Kanton Neuenburg","Kanton Genf","Kanton Jura",
                            "Canton de Zurich","Canton de Berne","Canton de Lucerne","Canton d'Uri","Canton de Schwyz","Canton d'Obwald","Canton de Nidwald","Canton de Glaris","Canton de Zug","Canton de Fribourg","Canton de Soleure","Canton de Bâle-Ville","Canton de Bâle-Campagne","Canton de Schaffhouse","Canton d'Appenzell Rhodes-Extérieures","Canton d'Appenzell Rhodes-Intérieures","Canton de St. Gallen","Canton des Grisons","Canton d'Argovie","Canton de Thurgovie","Canton du Tessin","Canton de Vaud","Canton du Valais","Canton de Neuchâtel","Canton de Genève","Canton du Jura",
                            "Cantone di Zurigo","Cantone di Berna","Cantone di Lucerna","Cantone di Uri","Cantone di Svitto","Cantone di Obvaldo","Cantone di Nidvaldo","Cantone di Glarona","Cantone di Zugo","Cantone di Friburgo","Cantone di Soletta","Cantone di Basilea Città","Cantone di Basilea Campagna","Cantone di Sciaffusa","Cantone di Appenzello Esterno","Cantone di Appenzello Interno","Cantone di St. Gallen","Canton Grigioni","Canton Argovia","Canton Turgovia","Canton Ticino","Canton Vaud","Canton Vallese","Canton Neuchâtel","Canton Ginevra","Canton Giura",
                            "Canton of Zurich","Canton of Bern","Canton of Lucerne","Canton of Uri","Canton of Schwyz","Canton of Obwalden","Canton of Nidwalden","Canton of Glarus","Canton of Zug","Canton of Fribourg","Canton of Solothurn","Canton of Basel-Stadt","Canton of Basel-Landschaft","Canton of Schaffhausen","Canton of Appenzell Ausserrhoden","Canton of Appenzell Innerrhoden","Canton of St. Gallen","Canton Graubünden","Canton Aargau","Canton Thurgau","Canton Ticino","Canton Vaud","Canton Valais","Canton Neuchâtel","Canton Geneva","Canton Jura"
    ))

    df_new<-rbind(df,bez,kt)

    df<-read.csv("data/old_spatialunits.csv")



    #selection of columns
    df<-df[,1:3]

    # 15.10.2021: Temporary workaround: Take the remaining values of zh-regions and bs-wohnviertel
    df<-df[df$TYPE_ID %in% c(4,10),]



    #convert to minor letters
    colnames(df)[colnames(df)=="TYPE_ID"]<-"type_id"
    colnames(df)[colnames(df)=="SPATIALUNIT_ID"]<-"spatialunit_id"
    colnames(df)[colnames(df)=="NAME"]<-"name"


    #create variable type_name out of type_ids (Does not need an own table)
    df$type_name<-ifelse(df$type_id==1,"Gemeinde","")
    df$type_name<-ifelse(df$type_id==8,"Kanton",df$type_name)
    df$type_name<-ifelse(df$type_id==4,"Region",df$type_name)
    df$type_name<-ifelse(df$type_id==3,"Bezirk",df$type_name)
    df$type_name<-ifelse(df$type_id==9,"Gemeinde alt",df$type_name)
    df$type_name<-ifelse(df$type_id==10,"Wohnviertel",df$type_name)


    # new spatial units
    #df$spatialunit_id<-ifelse(df$type_id==1|df$type_id==9,df$bfs_nr,df$spatialunit_id)
    #df$spatialunit_id<-ifelse(df$type_id==8&df$name_de=="Kanton Zürich - ganzer Kanton",010000,df$spatialunit_id)
    #df$spatialunit_id<-ifelse(df$type_id==8&df$name_de=="Kanton Basel-Stadt",120000,df$spatialunit_id)
    #df$spatialunit_id<-ifelse(df$type_id==3|df$type_id==4,df$spatialunit_id+010000,df$spatialunit_id)
    #df$spatialunit_id<-ifelse(df$type_id==10,df$spatialunit_id+120000,df$spatialunit_id)
    df$district_id<-NA
    df$kantons_id<-NA


    df<-rbind(df,data.frame(spatialunit_id=0,type_id=0,name=c("Schweiz","Suisse","Svizzera","Switzerland"),
                            district_id=NA,kantons_id=0,type_name="Schweiz"))

    df<-rbind(df,df_new)








    #saving to the new spatialunits.csv
    write.csv(df,"data/spatialunits.csv",row.names = F)


  }


}
