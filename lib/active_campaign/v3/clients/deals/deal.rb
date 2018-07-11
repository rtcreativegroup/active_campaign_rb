module ActiveCampaign
  module V3
    module Clients
      module Deals
        module Deal
          def deal_create(title:, contact:, value:, currency:, group:, stage:, owner:, **args)
            param_types = {
              body: [
                :title,
                :contact,
                :value,
                :currency,
                :group,
                :stage,
                :owner,
                :percent,
                :status,
              ],
            }

            post(
              '/deals',
              args.merge(
                title: title,
                contact: contact,
                value: value,
                currency: currency,
                group: group,
                stage: stage,
                owner: owner
              ),
              param_types,
              :deal
            )
          end

          def deal_retrieve(id:)
            param_types = { path: :id }

            get('/deals/:id', { id: id }, param_types)
          end

          def deal_update(id:, **args)
            param_types = {
              path: :id,
              body: [
                :title,
                :contact,
                :value,
                :currency,
                :group,
                :stage,
                :owner,
                :percent,
                :status,
              ],
            }

            put('/deals/:id', args.merge(id: id), param_types, :deal)
          end

          def deal_delete(id:)
            param_types = { path: :id }

            delete('/deals/:id', { id: id }, param_types)
          end

          def deal_list(**args)
            param_types = {
              query: [
                'filters[search]',
                'filters[search_field]',
                'filters[title]',
                'filters[stage]',
                'filters[group]',
                'filters[status]',
                'filters[owner]',
                'filters[nextdate_range]',
                'filters[tag]',
                'filters[tasktype]',
                'filters[created_before]',
                'filters[created_after]',
                'filters[updated_before]',
                'filters[updated_after]',
                'filters[organization]',
                'filters[minimum_value]',
                'filters[maximum_value]',
                'filters[score_greater_than]',
                'filters[score_less_than]',
                'filters[score]',
                'orders[title]',
                'orders[value]',
                'orders[cdate]',
                'orders[contact_name]',
                'orders[contact_orgname]',
                'orders[next-action]]',
              ]
            }

            get('/deals', args, param_types)
          end

          def deal_note_create(id:, note:)
            param_types = {
              path: :id,
              body: :note,
            }

            post('/deals/:id/notes', { id: id, note: note }, param_types, :note)
          end

          def deal_note_update(id:, noteid:, note:)
            param_types = {
              path: [:id, :noteid],
              body: :note,
            }

            put(
              '/deals/:id/notes/:noteid',
              { id: id, noteid: noteid, note: note },
              param_types,
              :note
            )
          end
        end
      end
    end
  end
end
