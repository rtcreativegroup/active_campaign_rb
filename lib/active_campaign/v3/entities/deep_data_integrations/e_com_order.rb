module ActiveCampaign
  module V3
    module Entities
      module DeepDataIntegrations
        class EComOrder < ActiveCampaign::V3::Entities::Base
          class OrderProduct < ActiveCampaign::V3::Entities::Base
            property :name, required: true
            property :price, coerce: Integer, required: true
            property :quantity, coerce: Integer, required: true
            property :externalid, coerce: String
            property :category
          end

          property :id, coerce: Integer
          property :externalid, coerce: String, required: -> { id.nil? }
          property :source,
                   transform_with: ->(value) { [0,1].include?(value.to_i) ? value.to_i : nil }
          property :email, required: true
          property :orderProducts, coerce: Array[OrderProduct]
          property :totalPrice, coerce: String, required: true
          property :currency, required: true
          property :connectionid, coerce: Integer, required: -> { id.nil? }
          property :customerid, coerce: Integer, required: -> { id.nil? }
          property :orderNumber, coerce: String
          property :orderUrl
          property :orderDate,
                   coerce: -> (date_string) { DateTime.parse(date_string) if date_string },
                   required: true
          property :shippingMethod
        end
      end
    end
  end
end
