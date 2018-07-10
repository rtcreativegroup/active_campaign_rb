require 'httparty'

module ActiveCampaign
  module V3
    class Client
      include HTTParty
      base_uri "#{ENV['ACTIVE_CAMPAIGN_URL']}/api/3"
      headers({ "Api-Token" => ENV['ACTIVE_CAMPAIGN_KEY'] })
      format :plain

      def initialize(base_url: ENV['ACTIVE_CAMPAIGN_URL'], key: ENV['ACTIVE_CAMPAIGN_KEY'], **)
        self.class.base_uri "#{base_url}/api/3"
        self.class.headers({ "Api-Token" => key })
        self.class.format :plain
        @key = key
      end

      def get(endpoint, args={})
        request(:get, endpoint: endpoint, args: args)
      end

      def post(endpoint, args={})
        request(:post, endpoint: endpoint, args: args)
      end

      def put(endpoint, args={})
        request(:put, endpoint: endpoint, args: args)
      end

      def delete(endpoint, args={})
        request(:delete, endpoint: endpoint, args: args)
      end

      private

      attr_reader :base_url, :key

      def request(action, endpoint:, args: {})
        response = self.class.send(action, endpoint, args)

        case response.code
        when 403
          {
            'error' => 'The request could not be authenticated or the authenticated user is not authorized to access the requested resource.'
          }
        when 404
          {
            'error' => 'The requested resource does not exist.'
          }
        else
          if response.content_type == 'application/json'
            JSON.parse(response)
          else
            response.to_s
          end
        end
      end
    end
  end
end
