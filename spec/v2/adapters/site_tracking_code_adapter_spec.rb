require 'spec_helper'

RSpec.describe ActiveCampaign::V2::Adapters::SiteTrackingCodeAdapter do
  subject(:adapter) { described_class.new(base_url: base_url, key: key) }
  let(:base_url) { 'http://www.example.com' }
  let(:key) { 'Test-Key' }

  describe '.endpoint' do
    it 'returns the endpoint, which is used for v2 admin api' do
      expect(adapter.endpoint).to eq('http://www.example.com/api/2/track/site/code')
    end
  end

  describe '.default_params' do
    it 'returns the default params, which are used for v2 admin api' do
      expect(adapter.default_params).to eq({ api_key: 'Test-Key' })
    end
  end
end
