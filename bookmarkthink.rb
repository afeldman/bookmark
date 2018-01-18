require 'yaml'
require 'rethinkdb'
include RethinkDB::Shortcuts

host = ARGV[1]

r.connect(:host => host, :port => 28015).repl

bookmarks = YAML.load_file(ARGV[0])
r.table('bookmarks').insert(bookmarks)
