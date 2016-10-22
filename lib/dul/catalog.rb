require 'dul/catalog/version'

module Dul
  module Catalog

    autoload :Configurable, 'dul/catalog/configurable'

    include Dul::Catalog::Configurable

  end
end