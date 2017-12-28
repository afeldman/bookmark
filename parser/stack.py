#!/usr/bin env python3

class Stack:
    def __init__(self):
        self.items = []
        
    def isEmpty(self):
        return self.items == []
        
    def push(self, item):
        self.items.append(item)
            
    def pop(self):
        if self.size() <=  0:
            raise Exception('No Elements in Stack')
        return self.items.pop()
   
    def peek(self):
        return self.items[len(self.items)-1]
    
    def size(self):
        return len(self.items)
