require 'rubygems'
require 'active_support'
require 'mongo_mapper'
require 'rsolr'

module Search
  mattr_accessor :connection  
end 

require 'solr/search'