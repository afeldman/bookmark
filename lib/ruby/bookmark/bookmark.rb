#!/usr/bin/env ruby

require_relative 'node'

module Gmark
  class Bookmark < Node

    @url = ''
    @parent_tag = nil
    @tags= [] #links

    def initialize(url, name, user, parent_node, mode=USER_MODE[:PRIVATE])
      super(name, user, mode)
      @url = url
      @parent_tag = parent_node
    end
  end	
end

if $0 == __FILE__
  n = Gmark::Bookmark.new('testurl', 'test', 'user1', nil, 1)
  p n
end
