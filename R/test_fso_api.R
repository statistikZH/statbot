
# Sample code for the FSO api
# note: there are severe limits to its API see
# https://www.pxweb.bfs.admin.ch/api/v1/de/?config
# this makes working with the API impossible


body = '{
    "query": [
      {
        "code":"Jahr",
        "selection": {
        "filter": "all",
        "values": [
          "*"
          ]
        }
      }
    ],
    "response":{
      "format":"csv"
    }
}'

# example datasets
dataset<-"px-x-0102030000_101" # works
dataset<-"px-x-0602010000_102" # doesnt work maybe because too many cells
out<-httr::POST(paste0("https://www.pxweb.bfs.admin.ch/api/v1/de/",dataset,"/",dataset,".px"),body=body,encode="json")
httr::content(out)


