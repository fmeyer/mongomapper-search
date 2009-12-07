require 'rubygems'
require 'rake'

namespace :gem do
  begin
    require 'jeweler'
    @jeweler_tasks = Jeweler::Tasks.new do |gem|
      gem.name = "mongomapper-search"
      gem.summary = %Q{Easily integreate mongo mapper with enterprise search like solr}
      gem.description = %Q{Easily integreate mongo mapper with enterprise search like solr}
      gem.email = "fmcamargo@gmail.com"
      gem.homepage = "http://github.com/fmeyer/mongomapper-search"
      gem.authors = ["Fernando Meyer"]
      gem.add_development_dependency "rspec", ">= 1.2.9"

      gem.add_dependency "rsolr", "0.9.6"
      gem.add_dependency "mongo_mapper", "0.5.8"
      gem.add_dependency "will_paginate", "2.3.11"

      # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
    end

  rescue LoadError
    puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
  end
end

begin
  require 'spec/rake/spectask'
  Spec::Rake::SpecTask.new do |spec|
    spec.libs << 'lib' << 'spec'
    spec.pattern = 'spec/**/*_spec.rb'
    spec.rcov = true
    spec.rcov_dir = 'doc/coverage'
    spec.rcov_opts = %w{--text-summary --failure-threshold 100 --exclude spec/*,gems/*,/usr/lib/ruby/* }
  end
rescue LoadError
  task :spec do
    abort "rSpec is not available. In order to run specs, you must: sudo gem install rspec"
  end
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "mongomapper-solr #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
