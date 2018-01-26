#!/usr/bin/env ruby

=begin
gem 'rethinkdb'; require 'rethinkdb'

class GmarkDB_Rethink
  include GmarkDB
  include RethinkDB::Shortcuts
  
  def connect(connection)
    begin
      @db_con = r.connect(:host => connection['host'],
                          :port => connection['port']).repl
    rescue ReqlDriverError => e
      puts e.message
      raise 'cannot establish connection'
    rescue ReqlOpFailedError =>e
      puts e.message
      raise 'cannot establish connection'
    end
  end

  def disconnect
    @db_con.close
  end

  def create_database
    info = ''
    begin
      r.db_create('gmark').run { |t| info = t }
    rescue RethinkDB::ReqlOpFailedError => e
      p e.message if $DEBUG
    end
    info
  end
  
  def create_tags
    tag_info = ''
    begin
      r.db('gmark')
        .table_create('tags').run { |t| tag_info = t }
    rescue RethinkDB::ReqlOpFailedError => e
      p e.message if $DEBUG
    end
    tag_info
  end

  def create_bookmarks
    mark_info = ''
    begin
      r.db('gmark')
        .table_create('bookmarks').run { |t| mark_info = t}
    rescue RethinkDB::ReqlOpFailedError => e
      p e.message if $DEBUG
    end
    mark_info
  end
  
  def create_user
    user_info = ''
    begin
      r.db('gmark')
        .table_create('user').run { |t| user_info=t } 
    rescue RethinkDB::ReqlOpFailedError => e
      p e.message if $DEBUG
    end
    user_info
  end
  
  def create_value(value)
    r.db('gmark').table('bookmarks').insert(value).run
  end

end
=end
