module ActiveCampaign
  module V2
    module Clients
      module Tracking
        def track_event_add(event:, **args)
          conn = Connection.new(adapter: ActiveCampaign::V2::TrackingAdapter)
          conn.post(
            '',
            params: { api_action: 'track_event_add' },
            form: args.merge(event: event)
          )
        end
      end
    end
  end
end
