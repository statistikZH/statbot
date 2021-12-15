import re
import requests
from bs4 import BeautifulSoup

def get_bfs_asset_nr(bfs_nr):
  '''This function scrapes the asset page of a bfs-nr for the asset number'''
  
  bfs_home = "https://www.bfs.admin.ch"
  
  asset_page = requests.get(bfs_home + "/asset/de/" + bfs_nr).content
  asset_page_clean = BeautifulSoup(asset_page, 'html.parser')
  
  asset_link = asset_page_clean.find(href=re.compile(".*assets/.*/"))['href']
  asset_number = re.findall("[0-9]+", asset_link)[0]
  
  return asset_number
