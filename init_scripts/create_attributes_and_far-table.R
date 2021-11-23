# V.2 - 17.11.2021

library(dplyr)
library(tidyr)

#some helper elements first
attr_value_id<-1
#function to automatically fill up the attr_value_id
fill_id<-function(n){
  out<-seq(attr_value_id,attr_value_id+n-1)
  attr_value_id<<-attr_value_id+n
  return(out)
  }



# Geschlecht nach eCH-0011 V8.1 und eCH-0044 V4.1
# Abweichung vom eCH: 0 als Total
# 3 wäre unebstimmt laut eCH

statbot_attr_geschlecht<-data.frame(  attr_id=1,
                 attr_name_de="Geschlecht",
                 attr_name_fr="Geschlecht",
                 attr_name_it="Geschlecht",
                 attr_name_en="Geschlecht")
statbot_value_geschlecht<- data.frame(attr_value_id=fill_id(3),attr_id=rep(1,3),
                 attr_value_name_de=c("Männer","Frauen","Total"),
                 attr_value_name_fr=c("Männer","Frauen","Total"),
                 attr_value_name_it=c("Männer","Frauen","Total"),
                 attr_value_name_en=c("Männer","Frauen","Total")
)

# Herkunft wie intern verwendet. Keine eCH gefunden

statbot_attr_herkunft<-data.frame(  attr_id=2,
                         attr_name_de="Herkunft",
                         attr_name_fr="Herkunft",
                         attr_name_it="Herkunft",
                         attr_name_en="Herkunft")
statbot_value_herkunft<- data.frame(attr_value_id=fill_id(3),attr_id=rep(2,3),
                         attr_value_name_de=c("Schweiz","Ausland","Total"),
                         attr_value_name_fr=c("Schweiz","Ausland","Total"),
                         attr_value_name_it=c("Schweiz","Ausland","Total"),
                         attr_value_name_en=c("Schweiz","Ausland","Total")
)

# Alter nach BFS Bevölkerungsschema
# keine eCH gefunden

statbot_attr_alter<-data.frame(  attr_id=3,
                       attr_name_de="Alter",
                       attr_name_fr="Alter",
                       attr_name_it="Alter",
                       attr_name_en="Alter")
statbot_value_alter<- data.frame(attr_value_id=fill_id(101),attr_id=rep(3,101),
                       attr_value_name_de=c("Alter Total",paste0(seq(1,99),"-jährig"),"100 Jahre und mehr"),
                       attr_value_name_fr=c("Alter Total",paste0(seq(1,99),"-jährig"),"100 Jahre und mehr"),
                       attr_value_name_it=c("Alter Total",paste0(seq(1,99),"-jährig"),"100 Jahre und mehr"),
                       attr_value_name_en=c("Alter Total",paste0(seq(1,99),"-jährig"),"100 Jahre und mehr")
)

statbot_attr_altersklasse_mutter<-data.frame(  attr_id=4,
                                attr_name_de="Altersklasse der Mutter",
                                attr_name_fr="Altersklasse der Mutter",
                                attr_name_it="Altersklasse der Mutter",
                                attr_name_en="Altersklasse der Mutter")
statbot_value_4altersklasse<- data.frame(attr_value_id=fill_id(6),attr_id=rep(4,6),
                                attr_value_name_de=c("Total","Unter 25 Jahren","25-29 Jahre","30-34 Jahre","35-39 Jahre","40 Jahre und mehr"),
                                attr_value_name_fr=c("Total","Unter 25 Jahren","25-29 Jahre","30-34 Jahre","35-39 Jahre","40 Jahre und mehr"),
                                attr_value_name_it=c("Total","Unter 25 Jahren","25-29 Jahre","30-34 Jahre","35-39 Jahre","40 Jahre und mehr"),
                                attr_value_name_en=c("Total","Unter 25 Jahren","25-29 Jahre","30-34 Jahre","35-39 Jahre","40 Jahre und mehr")
)

statbot_attr_wirtschaftssektor<-data.frame(  attr_id=5,
                                              attr_name_de="Wirtschaftssektor",
                                              attr_name_fr="Wirtschaftssektor",
                                              attr_name_it="Wirtschaftssektor",
                                              attr_name_en="Wirtschaftssektor")
statbot_value_wirtschaftssektor<- data.frame(attr_value_id=fill_id(4),attr_id=rep(5,4),
                                              attr_value_name_de=c("Total","Primärsektor","Sekundärer Sektor","Tertiärer Sektor"),
                                              attr_value_name_fr=c("Total","Primärsektor","Sekundärer Sektor","Tertiärer Sektor"),
                                              attr_value_name_it=c("Total","Primärsektor","Sekundärer Sektor","Tertiärer Sektor"),
                                              attr_value_name_en=c("Total","Primärsektor","Sekundärer Sektor","Tertiärer Sektor")
)

# merge all the variables starting with statbot_attr_ together
out<-NULL
for(i in ls(pat="statbot_attr_")){
  out<-rbind(out,eval(as.name(i)))
}

# output
write.csv(out[order(out$attr_id),],"data/attributes.csv",row.names = F)

# merge all the variables starting with statbot_value_ together
out<-NULL
for(i in ls(pat="statbot_value_")){
  out<-rbind(out,eval(as.name(i)))
}

# output
write.csv(out[order(out$attr_value_id),],"data/attr_values.csv",row.names = F)

#jetzt muss noch die fact_attr_table erstellt werden
far_id<-1

generate_combinations<-function(list_attr){
  vectors_list<-list()
  j<-1
  for(i in list_attr){
    vectors_list[[j]]<-out$attr_value_id[out$attr_id==i]
    j<-j+1
  }

  possible_combinations<-expand.grid(vectors_list)

  possible_combinations$far_id<-seq(far_id,far_id+nrow(possible_combinations)-1)
  far_id<<-far_id+nrow(possible_combinations)

  possible_combinations<-pivot_longer(possible_combinations,starts_with("Var"),values_to="attr_value_id")

  possible_combinations$name<-NULL

  return(possible_combinations)

}


fact_attr_11001<-generate_combinations(c(1,2,3))

fact_attr_11101<-generate_combinations(c(1,2,4))

fact_attr_23001<-generate_combinations(c(5))

fact_attr_12001_12101<-generate_combinations(c(1,5))

#32001: no combinations

# merge all the variables starting with fact_attr_ together
out<-NULL
for(i in ls(pat="fact_attr_")){
  out<-rbind(out,eval(as.name(i)))
}

# output
write.csv(out[order(out$far_id,out$attr_value_id),],"data/far_table.csv",row.names = F)

