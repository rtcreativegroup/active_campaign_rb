module ActiveCampaign
  module V2
    module Clients
      module Tracking
        def track_event_add(event:, **args)
          post(
            :event_adding,
            params: { api_action: 'track_event_add' },
            form: args.merge(event: event)
          )
        end
      end
    end
  end
end
