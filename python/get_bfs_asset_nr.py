from bs4 import BeautifulSoup
import urllib.request as urllib2

from constants import BFS_HOME

def get_bfs_asset_nr(bfs_number: str) -> str:
    '''
    Scrape the asset number of a specific bfs number
    Inputs:
        - bfs_number: number of a bfs publication e.g: "ag-b-00.03-875-gg20"
       
    Returns
        - asset number
    '''
    response = urllib2.urlopen(f'{BFS_HOME}/asset/de/{bfs_number}')
    html_doc = response.read()
    soup = BeautifulSoup(html_doc, 'html.parser')
    strhtm = soup.prettify()
    return soup.find(itemprop="image")['content'].split('/')[6]


if __name__ == "__main__":
    number = get_bfs_asset_nr("ag-b-00.03-875-gg20")
    print(number)