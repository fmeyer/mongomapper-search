require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Search::SolrDocument do
  class Dummy
    include MongoMapper::Document
    include Search::SolrDocument
    
    key :field_1, String
    key :field_2, String, :fulltext => true
    key :field_3, String, :fulltext => true
  end
      
  before(:each) do
    @dummy = Dummy.new(:id => '123', :field_1 => 'abc', :field_2 => 'def', :field_3 => 'ghi')
    Search.connection = mock('solr')
    Search.connection.stub!(:add)
    Search.connection.stub!(:commit)
    
    Dummy.connection Mongo::Connection.new
    Dummy.stub!(:find).with(anything()).and_return(@dummy)
  end

  it "should create a hash with attributes to index" do
    @dummy.to_index.should have(3).fields
    @dummy.to_index.should have_key('id')
    @dummy.to_index.should have_key('field_2')
    @dummy.to_index.should have_key('field_3')
  end
  
  it "should index and commit on save" do
    Search.connection.should_receive(:add).with(@dummy.to_index)
    Search.connection.should_receive(:commit)
    @dummy.save
  end
  
  it "should remove from index then delete" do
    Search.connection.should_receive(:delete_by_id).with(@dummy._id)
    @dummy.destroy
  end
  
  it "should return instances given a text to fulltext search" do
    Search.connection.
      should_receive(:select).
      with(hash_including(:q => 'abc')).
      and_return('response' => {'docs' => [{'id' => 'a'}], 'numFound' => 1})

    dummies = Dummy.search('abc')
  end
end
