module ActiveCampaign
  module V2
    module Adapters
      class AdminAdapter
        def initialize(base_url:, key:, **)
          @base_url = base_url
          @key = key
        end

        def endpoint
          "#{base_url}/admin/api.php"
        end

        def default_params
          {
            api_key: key,
            api_output: :json
          }
        end

        private

        attr_reader :base_url, :key
      end
    end
  end
end
