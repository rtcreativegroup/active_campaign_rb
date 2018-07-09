module ActiveCampaign
  module V2
    module Clients
      module Form
        def form_getforms
          get('/', params: { api_action: 'form_getforms' })
        end

        def form_html(id:)
          get('/', params: { api_action: 'form_html', api_output: :html, id: id })
        end
      end
    end
  end
end
