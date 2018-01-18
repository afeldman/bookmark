#!/usr/bin/env ruby

require 'yaml'
require 'date'

files = Dir.glob('./json/*')

$bookmarks = []

def traverse(sublist)
   sublist['children'].each{ |child|
       traverse(child) if child['type'] == 'folder'
       $bookmarks << {'title'    => child['name'],
                     'date'    => child['date_added'],
                     'url'     => child['url'],
                     'comment' => '',
                     'tags'    => [] } if child['type'] == 'url'
   }if sublist['children']
end

if $0 == __FILE__

   files.each { |file|
      puts "file:\t#{file}"
      yaml_f = YAML.load_file(file)
      root = yaml_f['roots']
      root.select { | k,v |
         traverse(v)
      } if root
   }

   data = $bookmarks.uniq { |elem| elem['url'] }

   puts "size of bookmarks:\t#{data.length}"

   File.open('./bookmark.yml', 'w') {|f| f.write data.to_yaml }
end