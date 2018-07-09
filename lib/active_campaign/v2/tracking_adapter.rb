module ActiveCampaign
  module V2
    class TrackingAdapter
      attr_reader :base_url

      def initialize(key:, tracking_account_id:, event_key:, **)
        @base_url = 'https://trackcmp.net/event'
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
