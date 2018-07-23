require 'active_campaign/version'

require 'active_campaign/settings'

require 'active_campaign/v2/client'
require 'active_campaign/v3/client'
require 'active_campaign/v3/entities/base'
require 'active_campaign/v3/entities/deep_data_integrations/e_com_order'

module ActiveCampaign
  class Error < StandardError; end
end
