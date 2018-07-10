module ActiveCampaign
  module V2
    module Adapters
      class EventAddingAdapter
        attr_reader :endpoint

        def initialize(key:, tracking_account_id:, event_key:, **)
          @endpoint = 'https://trackcmp.net/event'
          @key = key
          @tracking_account_id = tracking_account_id
          @event_key = event_key
        end

        def default_params
          {
            api_key: key,
            actid: tracking_account_id,
            key: event_key
          }
        end

        private

        attr_reader :key, :tracking_account_id, :event_key
      end
    end
  end
end
