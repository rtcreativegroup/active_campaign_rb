module ActiveCampaign
  module V3
    module Clients
      module DeepDataIntegration
        module Connection
          def connection_create(service:, externalid:, name:, logoUrl:, linkUrl:)
            param_types = {
              body: [
                :service,
                :externalid,
                :name,
                :logoUrl,
                :linkUrl,
              ],
            }

            post(
              '/connections',
              {
                service: service,
                externalid: externalid,
                name: name,
                logoUrl: logoUrl,
                linkUrl: linkUrl,
              },
              param_types,
              :connection
            )
          end

          def connection_retrieve(id:)
            param_types = { path: :id }

            get('/connections/:id', { id: id }, param_types)
          end

          def connection_update(id:, **args)
            param_types = {
              path: :id,
              body: [
                :service,
                :externalid,
                :name,
                :logoUrl,
                :linkUrl,
                :status,
                :syncStatus
              ],
            }

            put('/connections/:id', args.merge(id: id), param_types, :connection)
          end

          def connection_delete(id:)
            param_types = { path: :id }

            delete('/connections/:id', { id: id }, param_types)
          end

          def connection_list(**args)
            param_types = {
              query: [
                'filters[service]',
                'filters[externalid]',
              ]
            }

            get('/connections', args, param_types)
          end
        end
      end
    end
  end
end
