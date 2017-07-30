#!/usr/bin/env python3

import json

from bookmark import Bookmark
#from stack import Stack

from os import listdir
from os.path import isfile, join, abspath

import sys

file_path = abspath(sys.argv[1])

file_list = [join(file_path,f) for f in listdir(file_path) if isfile(join(file_path, f))]

bookmark_s = set()

for file in file_list: 
 f = open(file,'r')
 con = json.load(f)
 f.close()


- con_list = con['roots'] # Access the roots
-    
- bookmark_bar = con_list['bookmark_bar']
- tags = bookmark_bar['children'] # Contains unsorted bookmarks and Tags
- for tag in tags:
-  if tag.has_key('children'):  # Tags / or stored in folder
-   Tag = tag['name']
-   bookmarks = tag['children']
-   for bookmark in bookmarks:
-    if bookmark['type'] == 'url':
-     uri = bookmark['url']
-     title = bookmark['name']
-     dateAdded = int(bookmark['date_added'])
-     add_date = dateAdded/10000000
-     
-     #print Tag, title 
-     #print 'saved on:',time.ctime(add_date)
-     #print uri
-     #print ''
-     bookmark_s.add(Bookmark(repr(title),uri,add_date))    
-     #    bookmark_dict[uri] = (repr(title), add_date)
-     
-    else:	# Unsorted Bookmarks
-     if tag['type'] == 'url':
-      bookmark = tag
-      uri = bookmark['url']
-      title = bookmark['name']
-      dateAdded = int(bookmark['date_added'])
-      add_date = dateAdded/10000000
-      Tag = 'Unsorted Bookmarks'
-      
-      #print Tag, title 
-      #print 'saved on:',time.ctime(add_date)
-      #print uri
-      #print ''
-      bookmark_s.add(Bookmark(repr(title),uri,add_date))
-#      bookmark_dict[uri] = (repr(title), add_date)
-
-#print(", ".join(str(e.link) for e in bookmark_s))   
-
-print (len(bookmark_s))
-
-l_bookmarks = list(bookmark_s)
-
-bookmark_j = json.dumps(l_bookmarks, default=encode_Bookmark)
-
-with open('bookmark.json', 'w') as f:
-     json.dump(bookmark_j, f)
+print(con)
