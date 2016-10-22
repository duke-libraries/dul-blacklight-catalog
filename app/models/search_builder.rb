# frozen_string_literal: true
class SearchBuilder < Blacklight::SearchBuilder
  include Blacklight::Solr::SearchBuilderBehavior

  self.default_processor_chain += [:rollup_duplicate_records]

  def rollup_duplicate_records(solr_parameters)
      solr_parameters[:fq] ||= []
      solr_parameters[:fq] << record_rollup_query
  end

  private

  def record_rollup_query
    "{!collapse field=rollup_key_i nullPolicy=expand max=termfreq(institution_s,\"#{Dul::Catalog.institution_code}\")}"
  end

end
