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
