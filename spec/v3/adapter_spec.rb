require 'spec_helper'

RSpec.describe ActiveCampaign::V3::Adapter do
  subject(:adapter) { described_class.new(base_url: base_url, key: key) }
  let(:base_url) { 'http://www.example.com' }
  let(:key) { 'Test-Key' }

  describe '.base_url' do
    it 'returns the base_url, which is used for v2 api' do
      expect(adapter.base_url).to eq('http://www.example.com/api/3')
    end
  end

  describe '.default_params' do
    it 'returns the base_url, which is used for v2 api' do
      expect(adapter.default_params).to eq({ api_key: 'Test-Key', api_output: :json })
    end
  end
end
