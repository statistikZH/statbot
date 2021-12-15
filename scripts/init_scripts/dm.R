


attr_table <- read.csv("data/attributes.csv")
attr_value_table <- read.csv("data/attr_values.csv")
far_table <- read.csv("data/far_table.csv")
spatial_unit_table <- read.csv("data/spatialunits.csv")
time_unit_table <- read.csv("data/temporal_dimensions.csv")


attr_table_bev <- attr_table %>%
  filter(attr_id %in% c(1,2,3))

attr_value_table_bev <- attr_value_table %>%
  filter(attr_id %in% c(1,2,3)) %>%
  select(attr_value_id, attr_id, attr_value_name_de) %>%
  mutate_all(as.factor)

destfile<-"temp/bfs_11001.px"
#download.file('https://www.bfs.admin.ch/bfsstatic/dam/assets/18404679/master',destfile=destfile)

df<-statbot_read.px(destfile)


df_staendig <- df %>%
  as_tibble() %>%
  dplyr::rename(Herkunft = `Staatsangehörigkeit..Kategorie.`,
                spatial_unit_name = `Kanton.......Bezirk........Gemeinde.........`,
                class_id = `Bevölkerungstyp`,
                time_unit_id = Jahr) %>%
  filter(class_id == "Ständige Wohnbevölkerung") %>%
  mutate(Alter = recode_factor(Alter, `Alter - Total` = "Total")) %>%
  mutate(Geschlecht = recode_factor(Geschlecht, `Geschlecht - Total` = "Total")) %>%
  mutate(Herkunft = recode_factor(Herkunft, `Staatsangehörigkeit (Kategorie) - Total` = "Total")) %>%
  mutate(class_id = 11001)



test <- df_staendig %>%
  mutate(record_id = 1:nrow(df_staendig)) %>%
  pivot_longer(cols = c("Alter", "Geschlecht", "Herkunft"), names_to = "attr", values_to = "attr_value")

test <- test %>%
  mutate(attr = as.factor(attr)) %>%
  mutate(attr = recode_factor(attr, Geschlecht = "1", Herkunft = "2", Alter = "3"))  %>%
  left_join(attr_value_table_bev, by = c("attr" = "attr_id", "attr_value" = "attr_value_name_de"))

test1 <- test %>%
  select(record_id, attr_value_id) %>%
  mutate_if(is.factor, as.character) %>%
  mutate_if(is.character, as.numeric)

test2 <- by(test1, test1$record_id, identity)

test1 <- test %>%
  select(-attr, -attr_value) %>%
  nest(data = attr_value_id)

test2 <- test1 %>%
  group_split(record_id)

test2 <- test1 %>%
  mutate(data = purrr::map(data, ~match_id(., far_table)))


match_id <- function(id_set, far_table){
  far_table_nested <- far_table %>%
    nest(data = attr_value_id)


  far_table_nested %>%
    filter(purrr::map_lgl(data, ~ all(as.character(id_set$attr_value_id) %in% .x$attr_value_id))) %>%
    pull(far_id)

}


