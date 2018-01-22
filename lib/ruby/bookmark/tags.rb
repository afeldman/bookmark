#!/usr/bin/env ruby

require_relative 'node'

module Gmark
  class Tag < Node
    attr_accessor :parent_tag, :client_tag
    
    @parent_tag = nil
    @client_tag = []

    def initialize(name, user, parent_node, mode=USER_MODE[:PRIVATE])
      super(name, user, mode)
      @parent_tag = parent_node
    end
    
  end
end

if $0 == __FILE__
  n = Gmark::Tag.new('test','user1', nil, 1)
  p n
end
