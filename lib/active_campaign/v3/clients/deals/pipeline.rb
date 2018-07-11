module ActiveCampaign
  module V3
    module Clients
      module Deals
        module Pipeline
          def pipeline_create(title:, currency:, **args)
            param_types = {
              body: [
                :title,
                :currency,
                :allgroups,
                :allusers,
                :autoassign,
                :users,
                :groups,
              ],
            }

            post(
              '/dealGroups',
              args.merge(title: title, currency: currency),
              param_types,
              :dealGroup
            )
          end

          def pipeline_retrieve(id:)
            param_types = { path: :id }

            get('/dealGroups/:id', { id: id }, param_types)
          end

          def pipeline_update(id:, **args)
            param_types = {
              path: :id,
              body: [
                :title,
                :currency,
                :allgroups,
                :allusers,
                :autoassign,
                :users,
                :groups,
              ],
            }

            put('/dealGroups/:id', args.merge(id: id), param_types, :dealGroup)
          end

          def pipeline_delete(id:)
            param_types = { path: :id }

            delete('/dealGroups/:id', { id: id }, param_types)
          end

          def pipeline_list(**args)
            param_types = {
              query: [
                'filters[title]',
                'filters[have_stages]',
                'orders[title]',
                'orders[popular]',
              ]
            }

            get('/dealGroups', args, param_types)
          end
        end
      end
    end
  end
end
