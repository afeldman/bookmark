#!/usr/bin/env ruby

require_relative 'node'

module Gmark
  class Tag < Node
    attr_accessor :parent_tag,
                  :client_tag,
                  :gmark
    
    @parent_tag = nil
    @client_tag = []
    @gmark = []
    
    def initialize(name, parent_node)
      super(name)
      @parent_tag = parent_node
    end

    def to_h
      hash = {}
      instance_variables.each {|var|
        hash[var.to_s.delete("@")] = instance_variable_get(var)
      }
      hash
    end
  end
end

if $0 == __FILE__
  n = Gmark::Tag.new('test', nil)
  p n
end
