# frozen_string_literal: true
class SearchBuilder < Blacklight::SearchBuilder
  include Blacklight::Solr::SearchBuilderBehavior
  include BlacklightAdvancedSearch::AdvancedSearchBuilder
  include TrlnArgon::ArgonSearchBuilder

  self.default_processor_chain += [:add_advanced_parse_q_to_solr, :add_advanced_search_to_solr]

  include BlacklightAdvancedSearch::AdvancedSearchBuilder


  self.default_processor_chain += [:add_advanced_parse_q_to_solr, :add_advanced_search_to_solr]

end
