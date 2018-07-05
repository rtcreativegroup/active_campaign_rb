module ActiveCampaign
  module V2
    class Adapter
      def self.call(base_url)
        base_url + '/admin/api.php'
      end
    end
  end
end
