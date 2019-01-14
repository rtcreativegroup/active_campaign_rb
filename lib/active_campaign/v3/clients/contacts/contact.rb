module ActiveCampaign
  module V3
    module Clients
      module Contacts
        module Contact
          def contact_create(email:, **args)
            param_types = {
              body: [
                :email,
                :firstName,
                :lastName,
                :deleted,
                :orgid,
                :phone,
              ],
            }

            post('/contacts', args.merge(email: email), param_types, :contact)
          end

          def contact_sync(email:, **args)
            param_types = {
              body: [
                :email,
                :firstName,
                :lastName,
                :deleted,
                :orgid,
                :phone,
              ],
            }

            post('/contact/sync', args.merge(email: email), param_types, :contact)
          end

          def contact_retrieve(id:)
            param_types = { path: :id }

            get('/contacts/:id', { id: id }, param_types)
          end

          def contact_subscribe_to_list(contact_id:, list_id:)
            param_types = {
              body: [
                :contact,
                :list,
                :status,
              ],
            }

            post(
              '/contactLists',
              { contact: contact_id, list: list_id, status: 1 },
              param_types,
              :contactList
            )
          end

          def contact_unsubscribe_from_list(contact_id:, list_id:)
            param_types = {
              body: [
                :contact,
                :list,
                :status,
              ],
            }

            post(
              '/contactLists',
              { contact: contact_id, list: list_id, status: 2 },
              param_types,
              :contactList
            )
          end

          def contact_update(id:, **args)
            param_types = {
              path: :id,
              body: [
                :email,
                :firstName,
                :lastName,
                :deleted,
                :orgid,
                :phone,
              ],
            }

            put('/contacts/:id', args.merge(id: id), param_types, :contact)
          end

          def contact_delete(id:)
            param_types = { path: :id }

            delete('/contacts/:id', { id: id }, param_types)
          end

          def contact_list(**args)
            param_types = {
              query: [
                :ids,
                :datetime,
                :email,
                :email_like,
                :exclude,
                :fields,
                :formid,
                :id_greater,
                :id_less,
                :listid,
                :organization,
                :search,
                :segmentid,
                :seriesid,
                :status,
                :tagid,
                :created_before,
                :created_after,
                :updated_before,
                :updated_after,
                :waitid,
                'orders[cdate]',
                'orders[email]',
                'orders[first_name]',
                'orders[last_name]',
                'orders[name]',
                'orders[score]',
                'in_group_lists',
              ]
            }

            get('/contacts', args, param_types)
          end

          def contact_list_automations(id:)
            param_types = {
              path: [
                :id,
              ]
            }

            get('/contacts/:id/contactAutomations', { id: id }, param_types)
          end
        end
      end
    end
  end
end
