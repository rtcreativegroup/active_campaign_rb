module ActiveCampaign
  module V2
    module Clients
      module Tracking
        def track_event_delete(event:)
          delete(:event_management, body: { event: event })
        end

        def track_event_list
          get(:event_management)
        end

        def track_event_status_edit(status:)
          post(:event_management, body: { status: status })
        end

        def track_site_code
          get(:site_tracking_code)
        end

        def track_site_list
          get(:site_tracking)
        end

        def track_site_status_edit(status:)
          post(:site_tracking, body: { status: status })
        end

        def track_site_whitelist_add(domain:)
          put(:site_tracking, body: { domain: domain })
        end

        def track_site_whitelist_delete(domain:)
          delete(:site_tracking, body: { domain: domain })
        end

        def track_event_add(event:, **args)
          post(
            :event_adding,
            query: { api_action: 'track_event_add' },
            body: args.merge(event: event)
          )
        end
      end
    end
  end
end
