#!/usr/bin/env ruby

module Gmark

  USER_MODE = {
    :PRIVAT => 0,
    :PUBLIC => 1
  }
  
  
  class User
    attr_accessor :id, :email
    
    def initialize(id, email)
      @id = id
      @email = email
    end
    
  end
end

if $0 == __FILE__
  user = Gmark::User.new('testuser', 'test@example.com')
  p user
end
