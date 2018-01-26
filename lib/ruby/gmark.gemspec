# coding: utf-8


require 'lib/version'

Gem::Specification.new do |s|
  s.name         = 'gmark'
  s.version      = GMARK::VERSION
  s.authors      = GMARK::AUTHOR
  s.email        = ['anton.feldmann@gmail.com']
  s.date         = '2018-01-26'
  s.summary      = %q{GMARK}
  s.description  = %q{parse bookmakrs types into a rethink database}
  s.files        = `git ls-files -z`.split("\x0")
  s.license      = 'MIT'
  s.require_path = ['lib']
end
