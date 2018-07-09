module ActiveCampaign
  module V2
    module Clients
      module List
        def list_add(
          name:,
          sender_name:,
          sender_addr1:,
          sender_city:,
          sender_zip:,
          sender_country:,
          sender_url:,
          sender_reminder:,
          **args
        )

          post(
            '/',
            params: {
              api_action: 'list_add'
            },
            form: args.merge(
              name: name,
              sender_name: sender_name,
              sender_addr1: sender_addr1,
              sender_city: sender_city,
              sender_zip: sender_zip,
              sender_country: sender_country,
              sender_url: sender_url,
              sender_reminder: sender_reminder
            )
          )
        end

        def list_delete(id:)
          get('/', params: { api_action: 'list_delete', id: id })
        end

        def list_delete_list(ids:)
          get('/', params: { api_action: 'list_delete_list', ids: ids.join(',') })
        end

        # The list of required params online is not correct. It does not show that sender info is
        # required, but it is
        def list_edit(
            id:,
            name:,
            sender_addr1:,
            sender_country:,
            sender_city:,
            sender_zip:,
            sender_url:,
            sender_reminder:,
            sender_state:,
            sender_name:,
            subscription_notify:,
            unsubscription_notify:,
            to_name:,
            carboncopy:,
            **args
          )

          post(
            '/',
            params: {
              api_action: 'list_edit'
            },
            form: args.merge(
              id: id,
              name: name,
              sender_addr1: sender_addr1,
              sender_country: sender_country,
              sender_city: sender_city,
              sender_zip: sender_zip,
              sender_url: sender_url,
              sender_reminder: sender_reminder,
              sender_state: sender_state,
              sender_name: sender_name,
              subscription_notify: Array(subscription_notify).join(','),
              unsubscription_notify: Array(unsubscription_notify).join(','),
              to_name: to_name,
              carboncopy: Array(carboncopy).join(','),
            )
          )
        end

        def list_field_add(
          title:,
          type:,
          req:,
          perstag:,
          p:,
          **args
        )

          post(
            '/',
            params: {
              api_action: 'list_field_add'
            },
            form: args.merge(
              title: title,
              type: type,
              req: req,
              perstag: perstag,
              p: Array(p),
            )
          )
        end

        def list_field_delete(id:)
          get('/', params: { api_action: 'list_field_delete', id: id })
        end

        def list_field_edit(
          id:,
          title:,
          type:,
          req:,
          perstag:,
          p:,
          **args
        )

          post(
            '/',
            params: {
              api_action: 'list_field_edit'
            },
            form: args.merge(
              id: id,
              title: title,
              type: type,
              req: req,
              perstag: perstag,
              p: Array(p),
              )
          )
        end

        def list_field_view(ids: 'all')
          #Doesn't seem to work
          get('/', params: { api_action: 'list_field_view', ids: Array(ids).join(',') })
        end

        def list_list(ids: 'all')
          get('/', params: { api_action: 'list_list', ids: Array(ids).join(',') })
        end

        def list_paginator(
          sort:,
          offset:,
          limit:,
          filter:,
          public:,
          **args
        )
          get(
            '/',
            params: {
              api_action: 'list_paginator',
              sort: sort,
              offset: offset,
              limit: limit,
              filter: filter,
              public: public,
            }
          )
        end

        def list_view(id:)
          get('/', params: { api_action: 'list_view', id: id })
        end
      end
    end
  end
end
