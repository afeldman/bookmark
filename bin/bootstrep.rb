#!/usr/bin/env ruby

require 'json'
require 'uri'

class Bookmarks

  attr_reader :bookmarks, :dublicates
  
  def initialize(path)
    begin
      local_bookmarks = JSON.parse(open(path).read)
      @chrome_bookmarks = local_bookmarks['roots']['bookmark_bar']['children']
    rescue
      puts "Warning: ".yel +
        "Chrome JSON Bookmarks not found."
      puts "Suggest: ".grn +
        "booker --install bookmarks"
      @chrome_bookmarks = {}
    end

    @dublicates = {}
    @bookmarks  = {}
    parse
  end

  def parse(root=nil)
    # root - parent folder in ruby
    root = Folder.new @chrome_bookmarks if root.nil?

    # all current urls, to hash
    root.json.each {|x| parse_link root.title, x }

    # all next-level folders, to array
    root.json.each {|x| parse_folder root, x }
  end

    # add link to results
  def parse_link(base, link)
    if link['type'] == 'url'
      if link['url'] =~ URI::regexp
        l = link['url'].to_sym
        #puts l
        bk = Bookmark.new base, link['name'], link['date_added'], link['url'], link['id']
        @bookmarks.has_key?(l) ? @dublicates[l] = bk : @bookmarks[l] = bk
      end
    end 
  end

  # discover and parse folders
  def parse_folder(base, link)
    if link['type'] == 'folder'
      title  = base.title + link['name'] + '/'
      subdir = Folder.new(title, link['children'])
      parse(subdir)
    end
  end
end

# for recursively parsing bookmarks
class Folder
  include Enumerable
  attr_reader :json, :title
  def initialize(title='|', json)
    @title = title.gsub(/[:,'"]/, '-').downcase
    @json  = json
  end

  # needed for Enumerable
  def each()
    @json.each
  end
end

# clean bookmark title, set attrs
class Bookmark
  attr_reader :title, :folder, :url, :id, :time
  def initialize(f, t, ti, u, id)
    @title  = t.gsub(/[:'"+]/, ' ').downcase
    @time   = ti
    @folder = f
    @url    = u
    @id     = id
  end
end

filename = ARGV.first

puts "reading file #{filename}"

bookmark = Bookmarks.new filename

puts "num of bookmarks: #{bookmark.bookmarks.length}"
puts "num of dublicates: #{bookmark.dublicates.length}"

youtube = {}
github = {}

bookmark.bookmarks.each do |key,value|
  if (value.url =~ /^(?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?([\w-]{10,})/ )
    youtube[key] = value
    bookmark.bookmarks.delete(key)
  end
  if (value.url =~ /^https?:\/\/github.com\/[^\/]*\/?$/ )
    github[key] = value
    bookmark.bookmarks.delete(key)
  end
end

puts "num of bookmarks: #{bookmark.bookmarks.length}"
puts "num of youtube: #{youtube.length}"
puts "num of github: #{github.length}"

require 'net/http'

def working_url?(url_str)
  url = URI.parse(url_str)
  Net::HTTP.start(url.host,
                  url.port,
                  :use_ssl => url.scheme == 'https') do |http|
    http.head(url.request_uri).code == '200'
  end 
rescue
  false
end

require 'progress_bar'

youbar = ProgressBar.new youtube.length, :bar =>

youtube.each do |key, value|
  youtube.delete(key) unless working_url? value.url
  youbar.increment!
end

puts "num of youtube: #{youtube.length}"

gitbar = ProgressBar.new github.length

github.each do |key, value|
  github.delete(key) unless working_url? value.url
  gitbar.increment!
end

puts "num of github: #{github.length}"

require 'date'

def convert_unix_epoch_timestamp(webkit_timestamp)
  unix_epoch_timestamp = webkit_timestamp.to_i
  # Get the January 1601 unixepoch
  since_epoch = DateTime.new(1601,1,1).to_time.to_i
  # Transfrom Chrome timestamp to seconds and add 1601 epoch
  final_epoch = (unix_epoch_timestamp / 1000000) + since_epoch
  # Print DateTime
  date = DateTime.strptime(final_epoch.to_s, '%s')
  return date
end

youtube.each_value do |value|
  time_date = convert_unix_epoch_timestamp(value.time.to_i)
  #puts "#{value.time} -> #{time_date}"
  puts "#{time_date.year} #{time_date.month} #{time_date.day}"
end
