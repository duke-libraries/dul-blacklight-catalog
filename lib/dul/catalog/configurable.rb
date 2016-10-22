module Dul
  module Catalog
    module Configurable
      extend ActiveSupport::Concern

      included do

        mattr_accessor :institution_code

      end

      module ClassMethods
        def configure
          yield self
        end
      end

    end
  end
end
