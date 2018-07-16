module ActiveCampaign
  module V3
    module Clients
      module DeepDataIntegrations
        module ECommerceCustomer
          def e_commerce_customer_create(connectionid:, externalid:, email:)
            param_types = {
              body: [
                :connectionid,
                :externalid,
                :email,
              ],
            }

            post(
              '/ecomCustomers',
              {
                connectionid: connectionid,
                externalid: externalid,
                email: email,
              },
              param_types,
              :ecomCustomer
            )
          end

          def e_commerce_customer_retrieve(id:)
            param_types = { path: :id }

            get('/ecomCustomers/:id', { id: id }, param_types)
          end

          def e_commerce_customer_update(id:, **args)
            param_types = {
              path: :id,
              body: [
                :connectionid,
                :externalid,
                :email,
              ],
            }

            put('/ecomCustomers/:id', args.merge(id: id), param_types, :ecomCustomer)
          end

          def e_commerce_customer_delete(id:)
            param_types = { path: :id }

            delete('/ecomCustomers/:id', { id: id }, param_types)
          end

          def e_commerce_customer_list(**args)
            param_types = {
              query: [
                'filters[email]',
                'filters[externalid]',
                'filters[connectionid]',
              ]
            }

            get('/ecomCustomers', args, param_types)
          end
        end
      end
    end
  end
end
