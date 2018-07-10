require 'http'
require 'active_campaign/v2/clients/contact'
require 'active_campaign/v2/clients/form'
require 'active_campaign/v2/clients/list'
require 'active_campaign/v2/clients/tracking'

module ActiveCampaign
  module V2
    class Client
      include ActiveCampaign::V2::Clients::Contact
      include ActiveCampaign::V2::Clients::Form
      include ActiveCampaign::V2::Clients::List
      include ActiveCampaign::V2::Clients::Tracking

      def initialize(
        base_url: ENV['ACTIVE_CAMPAIGN_URL'],
        key: ENV['ACTIVE_CAMPAIGN_KEY'],
        tracking_account_id: ENV['ACTIVE_CAMPAIGN_TRACKING_ACCOUNT_ID'],
        event_key: ENV['ACTIVE_CAMPAIGN_EVENT_KEY']
      )
        @base_url = base_url
        @key = key
        @tracking_account_id = tracking_account_id
        @event_key = event_key
      end

      def get(endpoint, args={})
        request(:get, adapter: adapter(endpoint), args: args)
      end

      def post(endpoint, args={})
        request(:post, adapter: adapter(endpoint), args: args)
      end

      def put(endpoint, args={})
        request(:put, adapter: adapter(endpoint), args: args)
      end

      def delete(endpoint, args={})
        request(:delete, adapter: adapter(endpoint), args: args)
      end

      private

      attr_reader :base_url, :key, :tracking_account_id, :event_key

      def request(action, adapter:, args: {})
        uri = URI(adapter.endpoint)
        params_with_defaults = adapter.default_params.merge(args.fetch(:params, {}))

        response = HTTP.request(action, uri, args.merge(params: params_with_defaults))

        if params_with_defaults[:api_output] == :json
          parse_response(response)
        else
          response.body.to_s
        end
      end

      def adapter(endpoint)
        name = "#{endpoint.to_s.split('_').collect!{ |w| w.capitalize }.join}"
        namespaced_klass_name = "ActiveCampaign::V2::Adapters::#{name}Adapter"

        Object.const_get(namespaced_klass_name).new(
          base_url: base_url,
          key: key,
          tracking_account_id: tracking_account_id,
          event_key: event_key
        )
      end

      def parse_response(response)
        JSON.parse(response.body)
      end
    end
  end
end
