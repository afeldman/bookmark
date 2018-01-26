#!/usr/bin/env ruby

require 'securerandom'

module Gmark

  USER_MODE = {
    :PRIVAT => 0,
    :PUBLIC => 1
  }
  
  class User
    attr_accessor :id, :email
    
    def initialize(name, email)
      @id = SecureRandom.uuid
      @name = name
      @email = email
    end
    
  end
end

if $0 == __FILE__
  user = Gmark::User.new('testuser', 'test@example.com')
  p user
end
