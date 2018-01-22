#!/usr/bin/env ruby

require 'securerandom'
require 'date'

module Gmark

  USER_MODE = {
    :PRIVAT => 0,
    :PUBLIC => 1
  }
  
  class Node
    attr_accessor :counter, :uuid,
                  :number, :mode,
                  :user, :access_time,
                  :change_time, :modification_time,
                  :name

    @@counter = 0
    
    @uuid = nil
    @numer = -1
    @mode = nil
    @user = nil
    @access_time = nil
    @modification_time = nil
    @change_time = nil
    @name = ''

    def initialize(name, user, mode=USER_MODE[:PRIVATE])
      @uuid = SecureRandom.uuid
      @number = @@counter
      @mode = mode
      @user = user
      @access_time = DateTime.now.strftime('%s')
      @modification_time = DateTime.now.strftime('%s')
      @change_time = DateTime.now.strftime('%s')
      @name = name

      @@counter += 1
    end
  end
end

if $0 == __FILE__
  n = Gmark::Node.new('test','user1', 1)
  p n
end
