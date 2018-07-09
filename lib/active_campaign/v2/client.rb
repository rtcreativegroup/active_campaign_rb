require 'forwardable'
require 'active_campaign/v2/clients/contact'
require 'active_campaign/v2/clients/form'
require 'active_campaign/v2/clients/list'

module ActiveCampaign
  module V2
    class Client
      extend Forwardable
      include ActiveCampaign::V2::Clients::Contact
      include ActiveCampaign::V2::Clients::Form
      include ActiveCampaign::V2::Clients::List

      attr_reader :connection

      def_delegators :connection, :get, :post, :put, :delete

      def initialize(connection: Connection.new(adapter: ActiveCampaign::V2::Adapter))
        @connection = connection
      end
    end
  end
end
