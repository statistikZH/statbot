import sys
import hashlib
import os.path
from os import path
import pandas as pd



def check_changes(fname):
    """Checks if change in input file occured. If a change occured in known file
    the corresponding hash in data/hashes.csv will be updated and it will return True.
    If file not known it will add name of file and corresponding hash to data/hashes.csv
    
    :param fname: Path of file to be checked
    :type fname: string
    
    :return: ``True`` if change in file occured, ``False`` if no change occured or file unknown
    :rtype: bool
    """
    
    # make hash object
    hash_md5 = hashlib.md5()
    
    try:
        # open file for reading in binary
        with open(fname, "rb") as f:
        
            # read file in chunks and update hash
            chunk = 0
            while chunk != b'':
                chunk = f.read(1024)
                hash_md5.update(chunk)
                
    except FileNotFoundError:
        print(f'File {fname} not found.')
        return 0
    
    # save new hash
    new_hash = hash_md5.hexdigest()

    # read old hashses from hash_file
    hash_file = pd.read_csv('data/hashes.csv')
    old_hash_series = hash_file.loc[hash_file['file_name'] == fname, 'hash']
    
    # check if file in hashes.csv
    if len(old_hash_series) == 0:
        # file not in hashes.csv
        # add new row with file name and hash
        hash_file.loc[len(hash_file)] = [fname, new_hash]
        # write new csv
        hash_file.to_csv('data/hashes.csv', index=False)
        return False
    else:
        old_hash = old_hash_series.iloc[0]
        
    if new_hash == old_hash:
        # no change
        return False

    else:
        # change occured
        index = hash_file.loc[hash_file['file_name'] == fname, 'hash'].index[0]
        hash_file.at[index, 'hash'] = new_hash
        hash_file.to_csv('data/hashes.csv', index=False)
        return True
        
    
