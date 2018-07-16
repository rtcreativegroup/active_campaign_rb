module ActiveCampaign
  module V3
    module Clients
      module Deals
        module DealTaskType
          def deal_task_type_create(title:)
            param_types = { body: :title }

            post(
              '/dealTasktypes',
              { title: title },
              param_types,
              :dealTasktype
            )
          end

          def deal_task_type_retrieve(id:)
            param_types = { path: :id }

            get('/dealTasktypes/:id', { id: id }, param_types)
          end

          def deal_task_type_update(id:, **args)
            param_types = {
              path: :id,
              body: :title
            }

            put('/dealTasktypes/:id', args.merge(id: id), param_types, :dealTasktype)
          end

          def deal_task_type_delete(id:)
            param_types = { path: :id }

            delete('/dealTasktypes/:id', { id: id }, param_types)
          end

          def deal_task_type_list()
            get('/dealTasktypes')
          end

          def deal_task_type_move(id:, **args)
            param_types = {
              path: :id,
              body: :dealTasktype
            }

            put('/dealTasktypes/:id/dealTasks', args.merge(id: id), param_types, :dealTask)
          end
        end
      end
    end
  end
end
