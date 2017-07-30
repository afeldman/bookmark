#!/usr/bin/env python3

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
        
