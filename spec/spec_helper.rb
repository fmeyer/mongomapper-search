$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'spec'
require 'spec/autorun'
require 'mongomapper-search'

Spec::Runner.configure do |config|
  MongoMapper.connection = Mongo::Connection.new("127.0.0.1")  
  MongoMapper.database = "dummydb"
end
