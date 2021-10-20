library(SPARQL) # SPARQL querying package
library(ggplot2)
# Step 1 - Set up preliminaries and define query
#actually it doesnt matter which one of the two followings:
#endpoint <- "http://datashop.westeurope.cloudapp.azure.com/statistics/sparql"
endpoint <- "http://datashop.westeurope.cloudapp.azure.com/statistics/query"
# create query statement
query <-
  "
PREFIX schema: <http://schema.org/>
PREFIX cube: <https://cube.link/>
PREFIX property: <http://datashop.westeurope.cloudapp.azure.com/statistics/property/>

#SELECT ?time ?place ?count
SELECT ?obs ?count ?place ?time ?id ?count ?zeit

WHERE {
  <http://datashop.westeurope.cloudapp.azure.com/statistics/DS0048> a cube:Cube;
             cube:observationSet/cube:observation ?obs.
    ?obs schema:identifier ?id .
  OPTIONAL{         ?obs property:RAUM/schema:name ?place .}
  ?obs property:TIME  ?time .
  ?obs property:ZEIT  ?zeit .
  OPTIONAL{ ?obs <http://datashop.westeurope.cloudapp.azure.com/statistics/measure/M0048> ?count .}
}

"



# Step 2 - Use SPARQL package to submit query and save results to a data frame
qd <- SPARQL(endpoint,query)
df <- qd$results
