require "http"

module ActiveCampaign
  class Connection
    extend Forwardable

    def initialize(
      api_version:,
      base_url: ENV['ACTIVE_CAMPAIGN_URL'],
      key: ENV['ACTIVE_CAMPAIGN_KEY'],
      tracking_account_id: ENV['ACTIVE_CAMPAIGN_TRACKING_ACCOUNT_ID'],
      event_key: ENV['ACTIVE_CAMPAIGN_EVENT_KEY']
    )
      @base_url = base_url
      @key = key
      @tracking_account_id = tracking_account_id
      @event_key = event_key
      @api_version = api_version
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

    attr_reader :base_url, :key, :tracking_account_id, :event_key, :api_version

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
      klass_name = "#{endpoint.to_s.split('_').collect!{ |w| w.capitalize }.join}Adapter"

      name_parts = []
      name_parts << 'ActiveCampaign'
      name_parts << api_version.capitalize
      name_parts << 'Adapters'
      name_parts << klass_name
      namespaced_klass_name = name_parts.join('::')

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
