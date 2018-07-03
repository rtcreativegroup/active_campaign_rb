module ActiveCampaign
  module V3
    class Adapter
      def self.call(base_url)
        base_url + '/api/3'
      end
    end
  end
end
