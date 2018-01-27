#!/usr/bin/env ruby

require_relative 'node'
require_relative 'html'

require 'digest'
require 'yaml'

module Gmark
  class Bookmark < Node
    attr_accessor :url
        
    def initialize(url, name)
      super(name)
      @url = url
      @index = Digest::SHA512.hexdigest url
    end

    
    def to_h
      hash = {}
      instance_variables.each {|var|
        hash[var.to_s.delete("@")] = instance_variable_get(var)
      }
      hash
    end

  end

  def self.parse_textfile(textfiles)
    marks = []
    rejected = []
    File.readlines(textfiles).each do |url|
      begin
        html = Gmark::BookmarkHTMLParser.new(url.strip)
        marks << html.getBookmark
      rescue
        rejected << url.strip
      end
    end

    return [marks, rejected]
  end

  def self.parse_yaml(yamlfile)
    yaml_f = YAML.load_file(bookmarkfile)

    bookmarks = []
    rejected = []
    
    yaml_f.each { |data|
      begin
        url = data['url'].strip

        html = Gmark::BookmarkHTMLParser.new(url)
        mark = html.getBookmark
        
        mark.name = data['title']
        mark.access_time = data['date']
        
        bookmark << mark
      rescue
        reject << url
      end
    }
    return[bookmarks, rejected]
  end
  
  def self.parse_google(bookmarkfile)

    traverse = -> (sublist, bookmark, reject) {
      sublist['children'].each{ |child|
        traverse(child) if child['type'] == 'folder'
        if child['type'] == 'url'

          begin
            html = BookmarkHTMLParser.new(child['url'].strip)
            mark = html.getBookmark
            
            mark.name = child['name']
            mark.access_time = child['date_added']
            
            bookmark << mark
          rescue  => e
            puts e.message
            puts e.backtrace
            reject << child['url'].strip
          end
        end
      }if sublist['children']        
    }

    bookmarks = []
    rejected = []
    
    yaml_f = YAML.load_file(bookmarkfile)
    root = yaml_f['roots']

    root.select { | k,v |
         traverse.call(v, bookmarks, rejected)
    } if root

    return [bookmarks, rejected]
  end  

end

if $0 == __FILE__
  gmarks = Gmark.parse_google(ARGV[0])
  p gmarks[0].to_yaml 
end
