#!/usr/bin/env ruby

require_relative 'node'

module Gmark
  class Bookmark < Node

    @url = ''
    @parent_tag = nil
    @tags= [] #links

    def initialize(url, name, parent_node)
      super(name)
      @url = url
      @parent_tag = parent_node
    end
  end	
end

if $0 == __FILE__
  n = Gmark::Bookmark.new('testurl', 'test', nil)
  p n
end
