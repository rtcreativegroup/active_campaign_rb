require 'httparty'
require 'active_campaign/parse_json'
require 'active_campaign/v3/clients/contacts/contact'
require 'active_campaign/v3/clients/deals/deal'
require 'active_campaign/v3/clients/deals/deal_stage'
require 'active_campaign/v3/clients/deals/deal_task'
require 'active_campaign/v3/clients/deals/deal_task_type'
require 'active_campaign/v3/clients/deals/pipeline'
require 'active_campaign/v3/clients/deep_data_integrations/connection'
require 'active_campaign/v3/clients/deep_data_integrations/e_commerce_customer'
require 'active_campaign/v3/clients/deep_data_integrations/e_commerce_order'

module ActiveCampaign
  module V3
    class Client
      include HTTParty
      include ActiveCampaign::ParseJson
      include ActiveCampaign::V3::Clients::Contacts::Contact
      include ActiveCampaign::V3::Clients::Deals::Deal
      include ActiveCampaign::V3::Clients::Deals::DealStage
      include ActiveCampaign::V3::Clients::Deals::DealTask
      include ActiveCampaign::V3::Clients::Deals::DealTaskType
      include ActiveCampaign::V3::Clients::Deals::Pipeline
      include ActiveCampaign::V3::Clients::DeepDataIntegrations::Connection
      include ActiveCampaign::V3::Clients::DeepDataIntegrations::ECommerceCustomer
      include ActiveCampaign::V3::Clients::DeepDataIntegrations::ECommerceOrder

      def initialize(
        base_url: ActiveCampaign::Settings.config.base_url,
        key: ActiveCampaign::Settings.config.api_key,
        format: :plain,
        timeout: ActiveCampaign::Settings.config.timeout
      )
        self.class.default_timeout timeout
        self.class.base_uri "#{base_url}/api/3"
        self.class.headers({ "Api-Token" => key })
        self.class.format format
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

      def request(action, payload)
        response = self.class.send(action, *payload)

        case response.code
        when 401
          raise ActiveCampaign::UnauthorizedError, response
        when 403
          raise ActiveCampaign::ForbiddenError, response
        when 404
          raise ActiveCampaign::NotFoundError, response
        when 422
          raise ActiveCampaign::UnprocessableEntityError, response
        when 500
          raise ActiveCampaign::InternalServerError, response
        when 503
          raise ActiveCampaign::ServiceUnavailableError, response
        else
          if response.content_type == 'application/json'
            response_json = parse_json(response)

            if response_json['errors']
              raise ActiveCampaign::Error, response_json['errors']
            else
              response_json
            end
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
