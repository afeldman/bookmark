require 'nokogiri'
require 'open-uri'
require 'date'

module Bookmark

  class NilClass
    def nil_or_empty?
      true
    end
  end

  class String
    def nil_or_empty?
      empty?
    end
  end
  
  class BookmarkHTMLParser
    def inizialize(url)
      @doc = Nokogiri::HTML(open(url))
    end

    def getTitle
      @doc.css('title')[0].text
    end

    def self.getBookmark(url)
      bk = BookmarkHTMLParser.new(url)
      return { 'title' => (bk.getTitle.nil_or_empty? bk.getTitle : 'nt' ),
               'date' => DateTime.now.strftime('%s'),
               'url' => url,
               'comment' => '',
               'tags' => [] }
    end
    
  end
  
end
