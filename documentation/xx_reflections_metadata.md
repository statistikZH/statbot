Update on 11.08.2021
Destinaries: Mainly statistical organizations

# Some thoughts on metadata issues

## 1. Relational Data versus Linked Data

Very likely we will need for project StatBot linked data instead of relational data. As Capadisli et al. wrote: "what linked statistics provide, and in fact enable, are **queries across datasets**: Given that the dimension concepts are interlinked, one can learn from a  certain observation’s dimension value, and enable the **automation of cross-dataset queries**"" (Capadisli et al. 2013: 2, emphasis added by us).

Thus a solution has very likely to be able to access different data collections - it is unlikely that data will be stored in one location - which would be the case for classical relational data. 

Further, "Knowledge graphs are a powerful concept for querying large amounts of data" (Liang et al. 2021:1).

Maybe another argument for linked data: It enables to create very "nuanced information" (Chakraborty et al. 2020: 1). It is maybe more nuanced as when using/joining different tables in the logic of relational data. 


## 2. Already existing solutions

For statistical organizations using SDMX, there exist already scripts to convert their data to linked data: https://csarven.ca/linked-sdmx-data

A solution using linked data does thus include organizations using SDMX. However, we need a feedback from an SDMX using organization. 

## 3. New Pipelines

New pipelines are currently being prepared in the main directory of this repository (starting with acronym LOD_).
