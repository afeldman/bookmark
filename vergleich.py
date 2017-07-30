#!/usr/bin/env python3

import json

from bookmark import Bookmark
from stack import Stack

from os import listdir
from os.path import isfile, join, abspath

import sys 

file_path = abspath(sys.argv[1])

file_list = [join(file_path,f) for f in listdir(file_path) if isfile(join(file_path, f))]

bookmark_s = set()
def encode_Bookmark(obj):
    if isinstance(obj, Bookmark):
        return obj.__dict__
    return obj

def add_bookmark(tag):
# tag['type'] == 'url':
 uri = tag['url']
 title = tag['name']
 dateAdded = int(tag['date_added'])
 add_date = dateAdded/10000000
 
 bk=Bookmark(title,uri,add_date)
 bookmark_s.add(bk)
 
def deep_search(tags):
 #go trough all the tags
 for tag in tags:
  #if tag has children and call 
  if 'children' in tag:
   tags = tag['children']
   deep_search(tags)
  else:
   add_bookmark(tag)
   
for file in file_list: 
 f = open(file,'r')
 con = json.load(f)
 f.close()

 # get the root element
 con_list = con['roots']
 #get the bookmarkbar
 bookmark_bar = con_list['bookmark_bar']

 #one level children
 tags = bookmark_bar['children']

 deep_search(tags)

print(len(bookmark_s))

l_bookmarks = list(bookmark_s)

bookmark_j = json.dumps(l_bookmarks, default=encode_Bookmark)

with open('bookmark.json', 'w') as f:
 json.dump(bookmark_j, f)
