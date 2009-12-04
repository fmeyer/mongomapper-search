# -*- encoding: utf-8 -*-

module Search::SolrDocument 
  module ClassMethods
    def search(query, opts = {})
      opts.reverse_merge!(:limit => 20, :offset => 0)
      resp = Search.connection.select(:q => query, :rows  => opts[:limit], :start => opts[:offset], :qt => :dismax, :fl => '*,score')['response']
      return resp['docs'].map{|doc| find(doc['id'])}, resp['numFound']
    end
  end

  module InstanceMethods
    def to_index
      attrs = {'id' => self._id}
      self.metaclass.keys.each_pair do |name, key|
        attrs.merge!(name => self[name]) if key.options[:fulltext]
      end
      attrs
    end
    
    protected
    def save_on_search_engine
      Search.connection.add(to_index)
      Search.connection.commit
    end
    
    def delete_from_search_engine
      Search.connection.delete_by_id(self._id)
    end
  end

  def self.included(receiver)
    receiver.extend ClassMethods
    receiver.send :include, InstanceMethods
    receiver.after_save :save_on_search_engine
    receiver.before_destroy :delete_from_search_engine
  end
end
