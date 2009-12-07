require 'rubygems'
require 'active_support'
require 'mongo_mapper'
require 'rsolr'
require 'will_paginate/collection'

module Search
  mattr_accessor :connection  
end 

require 'solr/search'