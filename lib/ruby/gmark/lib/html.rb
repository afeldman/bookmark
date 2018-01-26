#!/usr/bin/env ruby

require_relative 'bookmark'

require 'nokogiri'
require 'open-uri'
require 'date'
require 'net/http'

class NilClass
  def nil_or_empty?
    true
  end
end

class Object
  def blank?
    respond_to?(:empty?) ? !!empty? : !self
  end

  # An object is present if it's not blank.
  def present?
    !blank?
  end
end

class String
  def nil_or_empty?
    empty?
  end
end

module Gmark

  def self.url_exist?(url_string)
    url = URI.parse(url_string)
    req = Net::HTTP.new(url.host, url.port)
    req.use_ssl = (url.scheme == 'https')
    path = url.path if url.path.present?
    res = req.request_head(path || '/')
    res.code != "404" # false if returns 404 - not found
  rescue Errno::ENOENT
    false # false if can't find the server
  rescue Errno::ECONNREFUSED
    false
  end
  
  class BookmarkHTMLParser
    def initialize(url)
      @url = url
      if URL?
        @doc = Nokogiri::HTML(open(url))
      else
        @doc = nil
      end
    end

    def URL?
      Gmark::url_exist?(@url)
    end

    def doc?
      return ( @doc? true : false)
    end
    
    def getTitle
      @doc.css('title')[0].text.strip if doc?
    end

    def getBookmark(parent_tag=nil)
      Bookmark.new(@url,getTitle,parent_tag) if URL? and doc?
    end
  end
end


if $0 == __FILE__
  url = 'https://rethinkdb.com/docs/permissions-and-accounts/'
  html = Gmark::BookmarkHTMLParser.new(url)
  p html.getBookmark
end
