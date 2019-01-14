module ActiveCampaign
  module V3
    module Clients
      module Contacts
        module Automation
          def contact_automation_create(contact_id:, automation_id:)
            param_types = {
              body: [
                :contact,
                :automation,
              ],
            }

            post(
              '/contactAutomations',
              { contact: contact_id, automation: automation_id },
              param_types,
              :contactAutomation
            )
          end

          def contact_automation_retrieve(id:)
            param_types = { path: :id }

            get('/contactAutomations/:id', { id: id }, param_types)
          end

          def contact_automation_delete(id:)
            param_types = { path: :id }

            delete('/contactAutomations/:id', { id: id }, param_types)
          end

          def contact_automation_list
            get('/contactAutomations')
          end
        end
      end
    end
  end
end
