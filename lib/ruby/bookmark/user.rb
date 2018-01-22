#!/usr/bin/env ruby

class User
  attr_accessor :id, :email

  def initialize(id, email)
    @id = id
    @email = email
  end
  
end

if $0 == __FILE__
  user = User.new('testuser', 'test@example.com')
  p user
end
