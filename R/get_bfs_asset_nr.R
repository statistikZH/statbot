#' Function to scrape the asset number of a specific bfs number
#'
#' This function scrapes the asset page of a bfs-nr for the asset number
#'
#' @param bfs_nr Number of a bfs publication e.g: "ag-b-00.03-875-gg20"
#'
#' @export
get_bfs_asset_nr <- function(bfs_nr){
  bfs_home <- "https://www.bfs.admin.ch"

  op <- options(RCurlOptions = list(noproxy = "*"))
  on.exit(options(op))

  webpage <- RCurl::getURLContent(sprintf("%s/asset/de/%s", bfs_home, bfs_nr)) %>%
    rvest::read_html()

  #asset_page <- xml2::read_html(sprintf("%s/asset/de/%s", bfs_home, bfs_nr))

  asset_number <- webpage %>%
    rvest::html_text(bfs_nr) %>%
    stringr::str_extract("https://.*assets/.*/") %>%
    stringr::str_extract("[0-9]+")

  return(asset_number)
}

#' download file without proxy
#'
#' @param download_url url to download the file from
#'
#' @param destfile destination file path
#'
#' @export
download_bfs_file <- function(download_url, destfile){


  op <-options(download.file.method="curl", download.file.extra = paste0("--noproxy '*'"))
  on.exit(options(op))

  download.file(download_url,destfile=destfile)

}
