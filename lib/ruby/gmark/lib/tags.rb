#!/usr/bin/env ruby

require_relative 'node'

module Gmark
  class Tag < Node
    attr_accessor :parent_tag, :client_tag, :gmark
    
    @parent_tag = nil
    @client_tag = []
    @gmark = []
    
    def initialize(name, parent_node)
      super(name)
      @parent_tag = parent_node
    end
    
  end
end

if $0 == __FILE__
  n = Gmark::Tag.new('test', nil)
  p n
end
