module ActiveCampaign
  module V2
    module Clients
      module Contact
        def contact_add(email:, p:, **args)
          post(
            '/admin/api.php',
            query: {
              api_action: 'contact_add'
            },
            body: args.merge(
              email: email,
              "p[#{p}]": p,
            )
          )
        end

        def contact_automation_list(
          offset:,
          limit:,
          contact_id:,
          contact_email:,
          **args
        )
          get(
            '/admin/api.php',
            query: args.merge(
              api_action: 'contact_automation_list',
              offset: offset,
              limit: limit,
              contact_id: contact_id,
              contact_email: contact_email,
            )
          )
        end

        def contact_delete(id:)
          get('/admin/api.php', query: { api_action: 'contact_delete', id: id })
        end

        def contact_delete_list(ids:)
          get('/admin/api.php', query: { api_action: 'contact_delete_list', ids: Array(ids).join(',') })
        end

        def contact_edit(id:, email:, p:, **args)
          post(
            '/admin/api.php',
            query: {
              api_action: 'contact_edit'
            },
            body: args.merge(
              id: id,
              email: email,
              "p[#{p}]": p,
            )
          )
        end

        def contact_list(ids: 'all', **args)
          get('/admin/api.php', query: args.merge(api_action: 'contact_list', ids: Array(ids).join(',')))
        end

        # This can be used to search for contacts based on a custom field setup in ActiveCampaign.
        # It will return a JSON object as the response with the following key structure:
        #
        # {
        #   '0': DATA FOR FIRST RESULT,
        #   '1': DATA FOR SECOND RESULT,
        #   'result_code': 1,
        #   'result_message': 'Success: Something is returned',
        #   'result_output': 'json',
        # }
        #
        # NOTE: This is most useful for looking up a contact with a unique identifier stored in a
        # custom field. Since the results are just stored in the JSON objects with a cardinal index,
        # it would be tricky to navigate this response with many results. That being said, if you
        # expect there to be one and only one result with a unique identifier, it should work.
        #
        # NOTE: Contacts that are not subscribed to any list will not be returned in the result set.
        def custom_field_search(field:, value:, **args)
          get('/admin/api.php', query: args.merge(api_action: 'contact_list', "filters[fields][%#{field.to_s.upcase}%]": value))
        end

        # There seems to be something wrong with this endpoint. It sometimes returns id: 0 for the
        # note that was added, but when you try to delete note 0, it says that's not possible. I
        # haven't figured out a pattern. At first, I thought it was returning id: 0 for the first
        # note of any [:id, :listid] tuple, but after further testing that doesn't appear to be the
        # case
        def contact_note_add(id:, listid:, note:, **args)
          post(
            '/admin/api.php',
            query: {
              api_action: 'contact_note_add'
            },
            body: args.merge(
              id: id,
              listid: listid,
              note: note,
            )
          )
        end

        def contact_note_delete(noteid:)
          get('/admin/api.php', query: { api_action: 'contact_note_delete', noteid: noteid })
        end

        def contact_note_edit(noteid:, subscriberid:, listid:, note:)
          post(
            '/admin/api.php',
            query: {
              api_action: 'contact_note_edit'
            },
            body: {
              noteid: noteid,
              subscriberid: subscriberid,
              listid: listid,
              note: note,
            }
          )
        end

        def contact_paginator(sort:, offset:, limit:, filter:, public:)
          get(
            '/admin/api.php',
            query: {
              api_action: 'contact_paginator',
              sort: sort,
              offset: offset,
              limit: limit,
              filter: filter,
              public: public,
            }
          )
        end

        def contact_sync(email:, **args)
          post('/admin/api.php', query: { api_action: 'contact_sync' }, body: args.merge(email: email))
        end

        def contact_tag_add(tags:, **args)
          post(
            '/admin/api.php',
            query: { api_action: 'contact_tag_add' },
            body: args.merge('tags[]': Array(tags))
          )
        end

        def contact_tag_remove(tags:, **args)
          post(
            '/admin/api.php',
            query: { api_action: 'contact_tag_remove' },
            body: args.merge('tags[]': Array(tags))
          )
        end

        def contact_view(id:)
          get('/admin/api.php', query: { api_action: 'contact_view', id: id })
        end

        def contact_view_email(email:)
          get('/admin/api.php', query: { api_action: 'contact_view_email', email: email })
        end

        def contact_view_hash(hash:)
          get('/admin/api.php', query: { api_action: 'contact_view_hash', hash: hash })
        end
      end
    end
  end
end
