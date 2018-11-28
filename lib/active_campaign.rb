require 'active_campaign/version'

require 'active_campaign/settings'

require 'active_campaign/v2/client'
require 'active_campaign/v3/client'
require 'active_campaign/v3/entities/base'
require 'active_campaign/v3/entities/deep_data_integrations/e_com_order'

module ActiveCampaign
  class Error < StandardError; end
  class UnauthorizedError < ActiveCampaign::Error; end
  class ForbiddenError < ActiveCampaign::Error; end
  class NotFoundError < ActiveCampaign::Error; end
  class InternalServerError < ActiveCampaign::Error; end
  class ServiceUnavailableError < ActiveCampaign::Error; end
  class UnprocessableEntityError < ActiveCampaign::Error; end
end
