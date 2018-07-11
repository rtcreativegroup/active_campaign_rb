require 'httparty'
require 'active_campaign/v3/clients/deals/deal_stage'
require 'active_campaign/v3/clients/deals/deal_task'
require 'active_campaign/v3/clients/deals/deal_task_type'
require 'active_campaign/v3/clients/deals/pipeline'

module ActiveCampaign
  module V3
    class Client
      include HTTParty
      include ActiveCampaign::V3::Clients::Deals::DealStage
      include ActiveCampaign::V3::Clients::Deals::DealTask
      include ActiveCampaign::V3::Clients::Deals::DealTaskType
      include ActiveCampaign::V3::Clients::Deals::Pipeline

      base_uri "#{ENV['ACTIVE_CAMPAIGN_URL']}/api/3"
      headers({ "Api-Token" => ENV['ACTIVE_CAMPAIGN_KEY'] })
      format :plain

      def initialize(base_url: ENV['ACTIVE_CAMPAIGN_URL'], key: ENV['ACTIVE_CAMPAIGN_KEY'], **)
        self.class.base_uri "#{base_url}/api/3"
        self.class.headers({ "Api-Token" => key })
        self.class.format :plain
        @key = key
      end

      def get(path, params = {}, param_types = {}, object_name = nil)
        request(:get, http_verb_payload(path, params, param_types, object_name))
      end

      def post(path, params = {}, param_types = {}, object_name = nil)
        request(:post, http_verb_payload(path, params, param_types, object_name))
      end

      def put(path, params = {}, param_types = {}, object_name = nil)
        request(:put, http_verb_payload(path, params, param_types, object_name))
      end

      def delete(path, params = {}, param_types = {}, object_name = nil)
        request(:delete, http_verb_payload(path, params, param_types, object_name))
      end

      private

      attr_reader :base_url, :key

      def request(action, payload)
        response = self.class.send(action, *payload)

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

      def http_verb_payload(path, params, param_types, object_name)
        path_params = select_params(params, param_types[:path])
        query_params = select_params(params, param_types[:query])
        body_params = select_params(params, param_types[:body])

        params = {}
        params[:query] = query_params if !query_params.empty?
        params[:body] = objectify_params(object_name, body_params).to_json if !body_params.empty?

        [
          inline_path_params(path, path_params),
          params
        ]
      end

      def select_params(params, allowed_params)
        params.select { |key, _| Array(allowed_params).map(&:to_s).include?(key.to_s) }
      end

      def inline_path_params(path, params)
        params.each do |key, value|
          path.gsub!(":#{key.to_s}", value.to_s)
        end

        path
      end

      def objectify_params(object_name, params)
        object_name ? { object_name => params } : params
      end
    end
  end
end
