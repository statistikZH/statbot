# Spatial Units Creation File

### Explanation based on V3.0.2 on 16.12.2021

The script under scripts/init_scripts/create_spatial_units.R generates a csv-file under data called spatialunits.csv . This is a file that contains all the information about the spatial units (communes, cantons, districts and so on).

In the first part of the script, it gets the historicized communal data directly from FSO. The data from the FSO actually contains three files: communes, districts and cantons. The files are quite dense and contain many useful information. For example for every commune there are several entries if there were changes to the commune (mergers, disbanded, border-changes etc). 

From these three files we are extracting the variables according to V3 of the database-scheme (see also below a discussion how we got to this V3 and what thoughts and issues we encountered). 

![Spatial Units Table in DB-Scheme V3.0.2](/readme_folder/img/spatialunit.PNG).

First of all we provide a spatialunit_ontology (or granularity) based on a logic that we derived from geonames. However, while several levels of the geoname-ontology were defined such as A.ADM3 for communes, we had to come up with some additional ones like A.ADM4 for Kreise&Wohnviertel or we used A.ADM2H for regions, which are a cantonal specificity that is an alternative on that level to the districts (Bezirke). We also improvized to define here Switzerland as "CH". We were told that this is formally a second variable - but we are keeping it like this for simplification to have one variable defining the granularity.

![Spatial Unit Ontology Adapted to our needs from geonames](/readme_folder/img/geonames.png)

Then we provide a "hist" (historicized) and "current" id. This is based on the logic by the FSO. A truly unique ID is the "hist"" one. So every commune can have different hist-IDs that show the different moments of time for that commune. Say commune A merged with commune B and is still called A after the merger. Then A-small and A-large will both have a unique hist-ID. This hist-id is different for communal, district and cantontal level. That means that when taking several granularities together, we do not have a unique ID anymore. Therefore, we need the spatialunit_ontology plus the spatialunit_hist_id to have a unique match for a spatial unit (which is debatable - see below for the slash-issue).

The spatialunit_current_id is thus one that is currently used. On communal level it is known as the "BFS-Nummer" for example. This variable helps thus in the joining of data. For district and cantonal level, there are also such numbers. 

Then we have spatialunit_name_XX in four different languages. There were several considerations and issues behind using here four different variable fields. First, the FSO-data that we are loading in only contains mainly one value for the name of the commune/district/canton. It seems to be coded in local languages (e.g. Genève and not Genf). We added the names in different languages in the first place for the cantonal values. We hard-coded in the script the name-values of the cantons in four languages. 

The above-mentioned values of the communes, however, sometimes include a slash such as "Freiburg/Fribourg". This creates a tricky issue for us, because we cannot automatically say, that the language before the slash is German and the one after is French: We find very different cases of slashes between language regions but also for example in Graubünden among dialects. At the moment of writing we are leaving the slashed values as we do not have a good solution yet. For example: If we would duplicate the values (one for Freiburg and one for Fribourg) then we would not have unique cases anymore for ontology and hist-id. Open for suggestions.

This leads me to: Why not having a unique id for this created spatialunits_table - particularly as every row is right now a unique spatial unit interpretation ? The issue linked to the unqiue id, is that this would be created when initializing the script - but the communal (and other) data is changing. Thus, when re-running the script with the changes, the unique-id will change as well. Theoretically this would not be a problem, if we then re-run all the scripts (all the ETL parts etc), so that all the data-elements always point to the correct unique-id. However, it is discussable if it makes sense to re-run everything. Also here: Open for suggestions.

The table also contains valid_from and valid_until columns that were taken from FSO. For the cantonal data this has been improvized and it says from 1979 on, because at the moment no changes of cantons (Berne and Jura) would be considered. This is maybe a TODO for later. 

At the end of the table there are also columns for the hist-ids of the districts and the cantons. This makes only sense for the communal data, where it is useful to quickly aggregate the communes to districts and cantons. On district-level it makes less sense, as it is the same id as its spatialunit_hist_id. The same for the cantonal level. If it does not make sense, there is just a NA.

In addition to all the data taken from the BFS, there is also additional data loaded from regional statistical offices that cover the particularities in the different cantons. For exaple the script right now considers the "regions" (which are different than districts) in ZH and the "Wohnviertel"" in Basel-Stadt. So here there is an open construction field at the moment of writing to include even more spatial units that are particular to other regional offices (Kreise, Verwaltungskreise etc. etc.). Just get in touch with us to insert all the other spatial units. We do not have yet any historicized logic for the ZH-regions and for the BS-Wohnviertel - of course this can be improved.

## Further considerations

While creating this V3 of the DB-Scheme we thought that the fact-tables need 3 elements to be identified uniquely. This is based on the geonames logic: Ontology, name and version such as Bülach is a commune (A.ADM3) and we are looking at its version of 2021 (Bülach:2021). The element of "version" is not anymore in the fact-table but it is included in the spatialunit-table even though not explicitly: it can be derived from valid_from and valid_until. If you have suggestions for imrpovement we are open. 








