module ActiveCampaign
  module V3
    module Clients
      module DeepDataIntegrations
        module ECommerceOrder
          def e_commerce_order_create(
            externalid:,
            email:,
            orderProducts:,
            totalPrice:,
            currency:,
            connectionid:,
            customerid:,
            orderDate:,
            **args
          )
            param_types = {
              body: [
                :externalid,
                :source,
                :email,
                :orderProducts,
                :totalPrice,
                :currency,
                :connectionid,
                :customerid,
                :orderNumber,
                :orderUrl,
                :orderDate,
                :shippingMethod,
              ]
            }

            post(
              '/ecomOrders',
              ActiveCampaign::V3::Entities::DeepDataIntegrations::EComOrder.new(
                args.merge({
                  externalid: externalid,
                  email: email,
                  orderProducts: orderProducts,
                  totalPrice: totalPrice,
                  currency: currency,
                  connectionid: connectionid,
                  customerid: customerid,
                  orderDate: orderDate,
                })
              ),
              param_types,
              :ecomOrder
            )
          end

          def e_commerce_order_retrieve(id:)
            param_types = { path: :id }

            get('/ecomOrders/:id', { id: id }, param_types)
          end

          def e_commerce_order_update(id:, **args)
            param_types = {
              path: :id,
              body: [
                :totalPrice,
                :currency,
                :orderNumber,
                :orderUrl,
                :orderDate,
                :shippingMethod,
                :email,
                :orderProducts
              ],
            }

            put(
              '/ecomOrders/:id',
              ActiveCampaign::V3::Entities::DeepDataIntegrations::EComOrder.new(args.merge(id: id)),
              param_types,
              :ecomOrder
            )
          end

          def e_commerce_order_delete(id:)
            param_types = { path: :id }

            delete('/ecomOrders/:id', { id: id }, param_types)
          end

          def e_commerce_order_list(**args)
            param_types = {
              query: [
                'filters[email]',
                'filters[externalid]',
                'filters[connectionid]',
              ]
            }

            get('/ecomOrders', args, param_types)
          end
        end
      end
    end
  end
end
