# V3.1.0 - 21.12.2021 - totals set to -1 instead of 0
# History
# V3.0.2c - 20.12.2021 - change to V3

# Comment on unique_name: It looks similar than dim_name_en but is meant to be for variable name
# while dim_name_en is human-readable name

create_dimensions<-function(){
  # Geschlecht nach eCH-0011 V8.1 und eCH-0044 V4.1
  # Abweichung vom eCH: 0 als Total
  # 3 wäre unebstimmt laut eCH

  statbot_dim_geschlecht<-data.frame(  dim_id=1,
                                       unique_name="gender",
                                       dim_name_de="Geschlecht",
                                       dim_name_fr="Geschlecht",
                                       dim_name_it="Geschlecht",
                                       dim_name_en="Gender",
                                       value_id=c(1,2,-1),
                                       value_name_de=c("Männer","Frauen","Total"),
                                       value_name_fr=c("Männer","Frauen","Total"),
                                       value_name_it=c("Männer","Frauen","Total"),
                                       value_name_en=c("Male","Female","Total")
  )

  # Herkunft wie intern verwendet. Keine eCH gefunden

  statbot_dim_herkunft<-data.frame(  dim_id=2,
                                     unique_name="origin",
                                     dim_name_de="Herkunft",
                                     dim_name_fr="Herkunft",
                                     dim_name_it="Herkunft",
                                     dim_name_en="Origin",
                                     value_id=c(1,2,-1),
                                     value_name_de=c("Schweiz","Ausland","Total"),
                                     value_name_fr=c("Schweiz","Ausland","Total"),
                                     value_name_it=c("Schweiz","Ausland","Total"),
                                     value_name_en=c("Switzerland","Abroad","Total")
  )

  # Alter nach BFS Bevölkerungsschema
  # keine eCH gefunden

  statbot_dim_alter<-data.frame(  dim_id=3,
                                  unique_name="age",
                                  dim_name_de="Alter",
                                  dim_name_fr="Alter",
                                  dim_name_it="Alter",
                                  dim_name_en="Age",
                                  value_id=seq(-1,100),
                                  value_name_de=c("Alter Total",paste0(seq(0,99),"-jährig"),"100 Jahre und mehr"),
                                  value_name_fr=c("Alter Total",paste0(seq(0,99),"-jährig"),"100 Jahre und mehr"),
                                  value_name_it=c("Alter Total",paste0(seq(0,99),"-jährig"),"100 Jahre und mehr"),
                                  value_name_en=c("Age Total",paste0(seq(0,99),"-years old"),"100 Years and more")
  )

  statbot_dim_altersklasse_mutter<-data.frame(  dim_id=4,
                                                unique_name="age_classes_of_mother",
                                                dim_name_de="Altersklasse der Mutter",
                                                dim_name_fr="Altersklasse der Mutter",
                                                dim_name_it="Altersklasse der Mutter",
                                                dim_name_en="Age classes of mother",
                                                value_id=c(-1,seq(1,5)),
                                                value_name_de=c("Total","Unter 25 Jahren","25-29 Jahre","30-34 Jahre","35-39 Jahre","40 Jahre und mehr"),
                                                value_name_fr=c("Total","Unter 25 Jahren","25-29 Jahre","30-34 Jahre","35-39 Jahre","40 Jahre und mehr"),
                                                value_name_it=c("Total","Unter 25 Jahren","25-29 Jahre","30-34 Jahre","35-39 Jahre","40 Jahre und mehr"),
                                                value_name_en=c("Total","Unter 25 Jahren","25-29 Jahre","30-34 Jahre","35-39 Jahre","40 Jahre und mehr")
  )

  statbot_dim_wirtschaftssektor<-data.frame(  dim_id=5,
                                              unique_name="economic_sector",
                                              dim_name_de="Wirtschaftssektor",
                                              dim_name_fr="Wirtschaftssektor",
                                              dim_name_it="Wirtschaftssektor",
                                              dim_name_en="Economic Sector",
                                              value_id=c(-1,seq(1,3)),
                                              value_name_de=c("Total","Primärsektor","Sekundärer Sektor","Tertiärer Sektor"),
                                              value_name_fr=c("Total","Primärsektor","Sekundärer Sektor","Tertiärer Sektor"),
                                              value_name_it=c("Total","Primärsektor","Sekundärer Sektor","Tertiärer Sektor"),
                                              value_name_en=c("Total","Primary Sector","Secondary Sector","Tertiary Sector")
  )

  statbot_dim_rooms<-data.frame(  dim_id=6,
                                              unique_name="rooms",
                                              dim_name_de="Zimmer",
                                              dim_name_fr="Zimmer",
                                              dim_name_it="Zimmer",
                                              dim_name_en="Rooms",
                                              value_id=c(-1,seq(1,6)),
                                              value_name_de=c("Total","1 Zimmer","2 Zimmer","3 Zimmer","4 Zimmer","5 Zimmer","6+ Zimmer"),
                                              value_name_fr=c("Total","1 Zimmer","2 Zimmer","3 Zimmer","4 Zimmer","5 Zimmer","6+ Zimmer"),
                                              value_name_it=c("Total","1 Zimmer","2 Zimmer","3 Zimmer","4 Zimmer","5 Zimmer","6+ Zimmer"),
                                              value_name_en=c("Total","1 room","2 rooms","3 rooms","4 rooms","5 rooms","6+ rooms"),
  )

  statbot_dim_construction_period<-data.frame(  dim_id=7,
                                  unique_name="construction_period",
                                  dim_name_de="Bauperiode",
                                  dim_name_fr="Bauperiode",
                                  dim_name_it="Bauperiode",
                                  dim_name_en="Construction period",
                                  value_id=c(-1,seq(1,9)),
                                  value_name_de=c("Total","Vor 1919","1919-1945","1946-1960","1961-1970",
                                                  "1971-1980","1981-1990","1991-2000","2001-2005","2006-2020"),
                                  value_name_fr=c("Total","Vor 1919","1919-1945","1946-1960","1961-1970",
                                                  "1971-1980","1981-1990","1991-2000","2001-2005","2006-2020"),
                                  value_name_it=c("Total","Vor 1919","1919-1945","1946-1960","1961-1970",
                                                  "1971-1980","1981-1990","1991-2000","2001-2005","2006-2020"),
                                  value_name_en=c("Total","Vor 1919","1919-1945","1946-1960","1961-1970",
                                                  "1971-1980","1981-1990","1991-2000","2001-2005","2006-2020")
  )

  # 8 is Staatsangehörigkeit Kategorie des Ehemannes
  # 9 is Staatsangehörigkeit Kategorie der Ehefrau


  # merge all the variables starting with statbot_dim_ together
  out<-NULL
  for(i in ls(pat="statbot_dim_")){
    out<-rbind(out,eval(as.name(i)))
  }

  # output
  write.csv(out,"data/dimensions.csv",row.names = F)
}
