require 'dul/catalog'

Dul::Catalog.configure do |config|
  config.institution_code = ENV['INSTITUTION_CODE']
end
