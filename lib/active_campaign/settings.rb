require 'dry-configurable'

module ActiveCampaign
  class Settings
    extend ::Dry::Configurable

    setting :base_url, ENV['ACTIVE_CAMPAIGN_URL']
    setting :api_key, ENV['ACTIVE_CAMPAIGN_KEY']
  end
end
