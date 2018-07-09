module ActiveCampaign
  module V2
    class Adapter
      def initialize(base_url:, key:, **)
        @base_url = base_url
        @key = key
      end

      def base_url
        @base_url + '/admin/api.php'
      end

      def default_params
        {
          api_key: key,
          api_output: :json
        }
      end

      private

      attr_reader :key
    end
  end
end
