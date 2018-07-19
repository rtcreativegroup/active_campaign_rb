module ActiveCampaign
  module V2
    module Clients
      module Tracking
        def track_event_delete(event:)
          delete('/api/2/track/event', body: { event: event })
        end

        def track_event_list
          get('/api/2/track/event')
        end

        def track_event_status_edit(status:)
          post('/api/2/track/event', body: { status: status })
        end

        def track_site_code
          get('/api/2/track/site/code')
        end

        def track_site_list
          get('/api/2/track/site')
        end

        def track_site_status_edit(status:)
          post('/api/2/track/site', body: { status: status })
        end

        def track_site_whitelist_add(domain:)
          put('/api/2/track/site', body: { domain: domain })
        end

        def track_site_whitelist_delete(domain:)
          delete('/api/2/track/site', body: { domain: domain })
        end

        def track_event_add(event:, **args)
          post(
            '',
            base_uri: 'https://trackcmp.net/event',
            query: { api_action: 'track_event_add' },
            body: args.merge(event: event)
          )
        end
      end
    end
  end
end
