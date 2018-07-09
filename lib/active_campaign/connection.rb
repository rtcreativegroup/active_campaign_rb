require "http"

module ActiveCampaign
  class Connection
    attr_reader :base_url, :key

    def initialize(
      base_url: ENV['ACTIVE_CAMPAIGN_URL'],
      key: ENV['ACTIVE_CAMPAIGN_KEY'],
      adapter: nil
    )
      adapter ||= ActiveCampaign::V2::Adapter
      @base_url = adapter.(base_url)
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

    def request(action, endpoint:, args: {})
      uri = URI(base_url + endpoint)
      params_with_defaults = args.fetch(:params, {}).merge(default_params)

      response = HTTP.request(action, uri, args.merge(params: params_with_defaults))

      parse_response(response)
    end

    def default_params
      {
        api_key: key,
        api_output: :json
      }
    end

    def parse_response(response)
      JSON.parse(response.body)
    end
  end
end
