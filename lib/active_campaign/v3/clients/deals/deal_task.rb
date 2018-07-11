module ActiveCampaign
  module V3
    module Clients
      module Deals
        module DealTask
          def deal_task_create(relid:, duedate:, dealTasktype:, **args)
            param_types = {
              body: [
                :title,
                :reltype,
                :relid,
                :status,
                :note,
                :duedate,
                :dealTasktype,
              ],
            }

            post(
              '/dealTasks',
              args.merge(relid: relid, duedate: duedate, dealTasktype: dealTasktype),
              param_types,
              :dealTask
            )
          end

          def deal_task_retrieve(id:)
            param_types = { path: :id }

            get('/dealTasks/:id', { id: id }, param_types)
          end

          def deal_task_update(id:, **args)
            param_types = {
              path: :id,
              body: [
                :title,
                :reltype,
                :relid,
                :status,
                :note,
                :duedate,
                :dealTasktype,
              ],
            }

            put('/dealTasks/:id', args.merge(id: id), param_types, :dealTask)
          end

          def deal_task_delete(id:)
            param_types = { path: :id }

            delete('/dealTasks/:id', { id: id }, param_types)
          end

          def deal_task_list(**args)
            param_types = {
              query: [
                'filters[title]',
                'filters[have_stages]',
                'orders[title]',
                'orders[popular]',
              ]
            }

            get('/dealTasks', args, param_types)
          end
        end
      end
    end
  end
end
