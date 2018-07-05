require 'forwardable'

module ActiveCampaign
  module V2
    class Client
      extend Forwardable

      attr_reader :connection

      def_delegators :connection, :get, :post, :put, :delete

      def initialize(connection: Connection.new)
        @connection = connection
      end
    end
  end
end
