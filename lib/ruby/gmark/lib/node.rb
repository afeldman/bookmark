#!/usr/bin/env ruby

require_relative 'user'

require 'digest'
require 'securerandom'
require 'date'

module Gmark
  class Node
    attr_accessor :uuid, :index,
                  :number, :mode,
                  :user, :access_time,
                  :change_time, :modification_time,
                  :name

    def initialize(name)
      @id = SecureRandom.uuid
      @index = Digest::SHA512.hexdigest name
      @mode = USER_MODE[:PUBLIC]
      @user = 'anonym'
      @access_time = DateTime.now.strftime('%s')
      @modification_time = DateTime.now.strftime('%s')
      @change_time = DateTime.now.strftime('%s')
      @name = name
    end

    def eql?(node)
      @index == node.index
    end
    
    def ==(node)
      @index == node.index
    end

    def to_t
      raise "Not implemented"
    end
  end
end

if $0 == __FILE__
  n = Gmark::Node.new('test')
  p n
end
