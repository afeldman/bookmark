#!/usr/bin/env ruby


require_relative 'user'

require 'securerandom'
require 'date'

module Gmark
  class Node
    attr_accessor :counter, :uuid,
                  :number, :mode,
                  :user, :access_time,
                  :change_time, :modification_time,
                  :name

    @@counter = 0
    
    @id = nil
    @numer = -1
    @mode = nil
    @user = nil
    @access_time = nil
    @modification_time = nil
    @change_time = nil
    @name = ''

    def initialize(name)
      @id = SecureRandom.uuid
      @number = @@counter
      @mode = USER_MODE[:PUBLIC]
      @user = 'anonym'
      @access_time = DateTime.now.strftime('%s')
      @modification_time = DateTime.now.strftime('%s')
      @change_time = DateTime.now.strftime('%s')
      @name = name

      @@counter += 1
    end
  end
end

if $0 == __FILE__
  n = Gmark::Node.new('test')
  p n
end
