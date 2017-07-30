#!/usr/bin/env python

import json

bookmark_s = set()

class Bookmark:
 def __init__(self, name, link, date):
  self.name = name
  self.link = link
  self.date = date
  
 def __eq__(self, other):
  return self.link == other.link
  
 def __hash__(self):
  return hash(self.link)

 def __repr__(self):
  return json.dumps(self.__dict__)

def encode_Bookmark(obj):
    if isinstance(obj, Bookmark):
        return obj.__dict__
    return obj
   
 
file_list=['Bookmarks','Bookmark_lin2','Bookmarks_lin','Bookmarks_old','Bookmarks-linux']

for file in file_list:
 f = open(file,'r')
 con = json.load(f)
 f.close()


 # bookmark_bar
 con_list = con['roots'] # Access the roots
    
 bookmark_bar = con_list['bookmark_bar']
 tags = bookmark_bar['children'] # Contains unsorted bookmarks and Tags
 for tag in tags:
  if tag.has_key('children'):  # Tags / or stored in folder
   Tag = tag['name']
   bookmarks = tag['children']
   for bookmark in bookmarks:
    if bookmark['type'] == 'url':
     uri = bookmark['url']
     title = bookmark['name']
     dateAdded = int(bookmark['date_added'])
     add_date = dateAdded/10000000
     
     #print Tag, title 
     #print 'saved on:',time.ctime(add_date)
     #print uri
     #print ''
     bookmark_s.add(Bookmark(repr(title),uri,add_date))    
     #    bookmark_dict[uri] = (repr(title), add_date)
     
    else:	# Unsorted Bookmarks
     if tag['type'] == 'url':
      bookmark = tag
      uri = bookmark['url']
      title = bookmark['name']
      dateAdded = int(bookmark['date_added'])
      add_date = dateAdded/10000000
      Tag = 'Unsorted Bookmarks'
      
      #print Tag, title 
      #print 'saved on:',time.ctime(add_date)
      #print uri
      #print ''
      bookmark_s.add(Bookmark(repr(title),uri,add_date))
#      bookmark_dict[uri] = (repr(title), add_date)

#print(", ".join(str(e.link) for e in bookmark_s))   

print (len(bookmark_s))

l_bookmarks = list(bookmark_s)

bookmark_j = json.dumps(l_bookmarks, default=encode_Bookmark)

with open('bookmark.json', 'w') as f:
     json.dump(bookmark_j, f)
