# DUL Blacklight Catalog

This is a rails application with the [Blacklight gem](https://github.com/projectblacklight/blacklight) included, all the blacklight generated files, and a couple of modifications -- noted below.

## Set up your environment

The fastest way to get started is to use [rails-dev-vagrant](https://github.com/duke-libraries/rails-dev-vagrant) to create a VM with the dependencies needed for running Rails, Blacklight, and Solr.

# Install dul-blacklight-catalog

1. Connect to your VM: `vagrant ssh`
2. Clone this repository into /vagrant/ `git clone git@github.com:duke-libraries/dul-blacklight-catalog.git`
3. Change to the application directory: `cd /vagrant/dul-blacklight-catalog`
4. Install gem dependencies with Bundler: `bundle install`
5. Run pending database migrations: `rake db:migrate`
6. Install Jetty and Solr: `rake jetty:clean`
7. Start Jetty and Solr: `rake jetty:start`
8. Ingest the sample data: `rake solr:marc:index_test_data`
                           
   OR
    
    Ingest your own MARC records: `rake solr:marc:index MARC_FILE=/some/file.mrc`
9. Start the rails server: `rails s -b 0.0.0.0`
10. Visit your application in a browser: [http://localhost:3000](http://localhost:3000)

## What is this?

It may not be immediately clear why we need this local project rather than a fork or copy of the Blacklight project. Blacklight is designed as a [Rails  Engine](http://edgeguides.rubyonrails.org/engines.html). To use it you create your own new project, include the blacklight gem as a dependency, and then use the blacklight generator to create some files in your own Rails project. This makes it possible to override default Blacklight methods and templates within your application without modifying or forking Blacklight itself.

## Modifications to the default Blacklight installation:

Blacklight includes the [blacklight-marc](https://github.com/projectblacklight/blacklight-marc) gem as a dependency to parse and index MARC records in Solr. It seems there's a bug in the latest versions of blacklight-marc that causes a `NoMethodError: undefined method extract_marc` when parsing and indexing MARC records. See this github issue: [MARC import error (undefined method 'extract_marc')](https://github.com/projectblacklight/blacklight/issues/1406). For now, I've [forked blacklight-marc](https://github.com/duke-libraries/blacklight-marc) with a temporary fix applied and included this forked gem in the dul-blacklight-catalog project.

The MARC field to Solr field mapping is specified in app/models/marc_indexer.rb. Some of the test records we tried to index produced an error because there were multiple values in the title field and display_title is defined as a single value field in in the Solr schema. The change instructs the parser to pick the first title.

`to_field 'title_display', extract_marc('245a', :trim_punctuation => true, :alternate_script=>false, :first=>true)`

