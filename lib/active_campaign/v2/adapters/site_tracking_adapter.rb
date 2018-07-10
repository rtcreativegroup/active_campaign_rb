module ActiveCampaign
  module V2
    module Adapters
      class SiteTrackingAdapter
        def initialize(base_url:, key:, **)
          @base_url = base_url
          @key = key
        end

        def endpoint
          "#{base_url}/api/2/track/site"
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
