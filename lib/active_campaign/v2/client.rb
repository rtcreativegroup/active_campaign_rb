require 'httparty'
require 'active_campaign/parse_json'
require 'active_campaign/v2/clients/contact'
require 'active_campaign/v2/clients/form'
require 'active_campaign/v2/clients/list'
require 'active_campaign/v2/clients/tracking'

module ActiveCampaign
  module V2
    class Client
      include HTTParty
      include ActiveCampaign::ParseJson
      include ActiveCampaign::V2::Clients::Contact
      include ActiveCampaign::V2::Clients::Form
      include ActiveCampaign::V2::Clients::List
      include ActiveCampaign::V2::Clients::Tracking

      DEFAULT_PARAMS = {
        admin: -> () do
          {
            api_key: ActiveCampaign::Settings.config.api_key,
            api_output: :json,
          }
        end,
        default: -> () do
          {
            api_key: ActiveCampaign::Settings.config.api_key,
          }
        end,
      }

      def initialize(
        base_url: ActiveCampaign::Settings.config.base_url,
        format: :plain,
        timeout: ActiveCampaign::Settings.config.timeout
      )
        self.class.default_timeout timeout
        self.class.base_uri base_url
        self.class.format format
      end

      def get(endpoint, params={})
        request(:get, http_verb_payload(endpoint, params))
      end

      def post(endpoint, params={})
        headers = params.fetch(:headers, {})
        headers.merge! post_header
        request(:post, http_verb_payload(endpoint, params.merge(headers: headers)))
      end

      def put(endpoint, params={})
        request(:put, http_verb_payload(endpoint, params))
      end

      def delete(endpoint, params={})
        request(:delete, http_verb_payload(endpoint, params))
      end

      private

      def request(action, payload)
        response = self.class.send(action, *payload)

        if response.content_type == 'application/json'
          response_json = parse_json(response)

          if response_json['result_code'] == 0
            raise ActiveCampaign::Error, response_json['result_message']
          else
            response_json
          end
        else
          response.to_s
        end
      end

      def http_verb_payload(path, params)
        full_path = params.fetch(:base_uri, self.class.base_uri) + path
        query_params = default_params(full_path).merge(params.fetch(:query, {}))
        encoded_body = URI.encode_www_form(params.fetch(:body, {}))

        [
          path,
          params.merge(query: query_params, body: encoded_body)
        ]
      end

      def default_params(url)
        key = case url
        when "#{ActiveCampaign::Settings.config.base_url}/admin/api.php"
          :admin
        else
          :default
        end

        DEFAULT_PARAMS[key].()
      end

      def post_header
        { 'Content-Type' => 'application/x-www-form-urlencoded' }
      end
    end
  end
end
