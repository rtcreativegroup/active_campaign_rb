module ActiveCampaign
  module V2
    module Adapters
      class SiteTrackingCodeAdapter
        def initialize(base_url:, key:, **)
          @base_url = base_url
          @key = key
        end

        def endpoint
          "#{base_url}/api/2/track/site/code"
        end

        def default_params
          {
            api_key: key
          }
        end

        private

        attr_reader :base_url, :key
      end
    end
  end
end
