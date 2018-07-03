require "http"

module ActiveCampaign
  class Connection
    attr_reader :base_url, :key

    def initialize(
      base_url: ENV['ACTIVE_CAMPAIGN_URL'],
      key: ENV['ACTIVE_CAMPAIGN_KEY'],
      adapter: nil
    )
      adapter ||= ActiveCampaign::V2::Adapter
      @base_url = adapter.(base_url)
      @key = key
    end
  end
end
