module ActiveCampaign
  module V3
    module Clients
      module Deals
        module DealStage
          def deal_stage_create(title:, group:, **args)
            param_types = {
              query: :reorder,
              body: [
                :title,
                :group,
                :order,
                :dealOrder,
                :cardRegion1,
                :cardRegion2,
                :cardRegion3,
                :cardRegion4,
                :cardRegion5,
                :color,
                :width,
              ],
            }

            post('/dealStages', args.merge(title: title, group: group), param_types, :dealStage)
          end

          def deal_stage_retrieve(id:)
            param_types = { path: :id }

            get('/dealStages/:id', { id: id }, param_types)
          end

          def deal_stage_update(id:, **args)
            param_types = {
              path: :id,
              query: :reorder,
              body: [
                :title,
                :group,
                :order,
                :dealOrder,
                :cardRegion1,
                :cardRegion2,
                :cardRegion3,
                :cardRegion4,
                :cardRegion5,
                :color,
                :width,
              ]
            }

            put('/dealStages/:id', args.merge(id: id), param_types, :dealStage)
          end

          def deal_stage_delete(id:)
            param_types = { path: :id }

            delete('/dealStages/:id', { id: id }, param_types)
          end

          def deal_stage_list(**args)
            param_types = {
              query: [
                'filters[title]',
                'filters[have_stages]',
                'orders[title]',
                'orders[popular]',
              ]
            }

            get('/dealStages', args, param_types)
          end

          def deal_stage_move(id:, **args)
            param_types = {
              path: :id,
              body: :stage
            }

            put('/dealStages/:id/deals', args.merge(id: id), param_types, :deal)
          end
        end
      end
    end
  end
end
