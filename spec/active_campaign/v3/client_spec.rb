RSpec.describe ActiveCampaign::V3::Client do
  subject(:client) { described_class.new(base_url: 'https://example.api-us1.com', key: 'key', timeout: 5) }

  describe '#get' do
    it 'fills path params without mutating a frozen path' do
      stub_request(:get, 'https://example.api-us1.com/api/3/contacts/1')

      expect { client.get('/contacts/:id'.freeze, { id: 1 }, { path: :id }) }.not_to raise_error
    end
  end
end
