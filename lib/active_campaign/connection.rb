require "http"

module ActiveCampaign
  class Connection
    extend Forwardable

    def_delegators :adapter, :base_url, :default_params

    def initialize(
      base_url: ENV['ACTIVE_CAMPAIGN_URL'],
      key: ENV['ACTIVE_CAMPAIGN_KEY'],
      adapter: nil
    )
      @adapter ||= adapter.new(
        base_url: base_url,
        key: key
      )
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

    attr_reader :adapter

    def request(action, endpoint:, args: {})
      uri = URI(base_url + endpoint)
      params_with_defaults = default_params.merge(args.fetch(:params, {}))

      response = HTTP.request(action, uri, args.merge(params: params_with_defaults))

      if params_with_defaults[:api_output] == :json
        parse_response(response)
      else
        response.body.to_s
      end
    end

    def parse_response(response)
      JSON.parse(response.body)
    end
  end
end
