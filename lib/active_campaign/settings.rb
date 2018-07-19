require 'dry-configurable'

module ActiveCampaign
  class Settings
    extend ::Dry::Configurable

    setting :base_url, ENV['ACTIVE_CAMPAIGN_URL']
    setting :api_key, ENV['ACTIVE_CAMPAIGN_KEY']
    setting :tracking_account_id, ENV['ACTIVE_CAMPAIGN_TRACKING_ACCOUNT_ID']
    setting :event_key, ENV['ACTIVE_CAMPAIGN_EVENT_KEY']
  end
end
