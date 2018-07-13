require 'hashie'

module ActiveCampaign
  module V3
    module Entities
      class Base < Hashie::Dash
        include Hashie::Extensions::Dash::Coercion
        include Hashie::Extensions::Dash::PropertyTranslation
        include Hashie::Extensions::Dash::IndifferentAccess
      end
    end
  end
end
